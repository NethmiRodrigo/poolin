import { Request, Response } from "express";
import { geojsonToWKT } from "@terraformer/wkt";
import { wktToGeoJSON } from "@terraformer/wkt";

/** Entities */
import { RideOffer } from "../../database/entity/RideOffer";
import { RideRequest } from "../../database/entity/RideRequest";
import { User } from "../../database/entity/User";
import { RequestToOffer } from "../../database/entity/RequestToOffer";
import { subMinutes, addMinutes } from "date-fns";
import { getOSRMDuration } from "../../middleware/osrmduration";
import { AppDataSource } from "../../data-source";
import { AppError } from "../../util/error-handler";

export const postRideRequests = async (req: Request, res: Response) => {
  const { offers, src, dest, startTime, window, distance, price } = req.body;

  const user: User = res.locals.user;

  const newRequest = new RideRequest({
    user: user,
    from: src.name,
    fromGeom: {
      type: "Point",
      coordinates: [src.lat, src.long],
    },
    to: dest.name,
    toGeom: {
      type: "Point",
      coordinates: [dest.lat, dest.long],
    },
    departureTime: startTime,
    timeWindow: window,

    distance: distance,
  });

  await newRequest.save();

  offers.forEach(async (id) => {
    const rideOffer = await RideOffer.findOne({ where: { id } });
    const requestToOffer = new RequestToOffer({
      request: newRequest,
      offer: rideOffer,
      price: price ? price : rideOffer.pricePerKm * distance,
    });
    await requestToOffer.save();
  });

  return res.status(200).json({ success: "Ride Requests posted successfully" });
};

export const getActiveRequest = async (req: Request, res: Response) => {
  const email = req.query.email;

  const user = await User.findOne({ where: { email: email as string } });

  if (!user) {
    return res.status(404).json({ error: "User not found" });
  }

  const request = await RideRequest.createQueryBuilder("request")
    .where("request.status='confirmed'")
    .leftJoinAndSelect("request.user", "user")
    .where("user.email = :email", { email: email as string })
    .select(["request.id AS id"])
    .getRawOne();

  if (!request) {
    return res.status(404).json({ error: "No active request" });
  }

  return res
    .status(200)
    .json({ success: "Ride Offer fetched successfully", request });
};

export const getAvailableOffers = async (req: Request, res: Response) => {
  const { srcLat, srcLong, destLat, destLong, startTime, window } = req.query;
  const start = {
    type: "Point",
    coordinates: [srcLat, srcLong],
  };

  const srcGeom = geojsonToWKT(start);

  const end = {
    type: "Point",
    coordinates: [destLat, destLong],
  };

  const destGeom = geojsonToWKT(end);

  //STD_Within checks for points that are within a given distance of a given polyline.
  //We do this for start and end points of a request, checking whether they intersect with the polyline for each offer.
  //Note : 0.002 is the optimal threhold value that was found by trial and error.
  //All points and lines need to have the SRID value of 4326.

  const intersectingOffers = await RideOffer.createQueryBuilder("offer")

    .leftJoinAndSelect("offer.user", "user")
    .select([
      "offer.id, offer.userId as driverID, user.firstname, user.lastname,  user.isVerified, user.gender, user.email, user.stars, user.totalRatings, user.vehicleType, user.vehicleModel, user.profileImageUri, offer.pricePerKm, offer.departureTime, ST_AsText(offer.fromGeom) as from, offer.from as fromName, ST_AsText(offer.toGeom) as to, offer.to as toName",
    ])
    .where("ST_DWithin(offer.polyline,ST_GeomFromText(:point,4326),0.002)", {
      point: srcGeom,
    })
    .andWhere("ST_DWithin(offer.polyline,ST_GeomFromText(:point,4326),0.002)", {
      point: destGeom,
    })
    //lineLocalePoint returns as a fraction the portin of the line upto which the point lies from the start of the line.
    //lineLocalePoint uses linear referencing. If point is not found on line, it returns the closest point on the line.
    .andWhere(
      "ST_LineLocatePoint(offer.polyline,ST_GeomFromText(:start,4326)) < ST_LineLocatePoint(offer.polyline,ST_GeomFromText(:end,4326))",
      {
        start: srcGeom,
        end: destGeom,
      }
    )
    .andWhere("offer.status IN ('active')")
    .getRawMany();

  // from the result set, we filter out offers that are not available at the time of the request

  const reqStartTime = Date.parse(startTime as string);

  const asyncOp = async (offer) => {
    const departurePoint = wktToGeoJSON(offer.from).coordinates;
    const duration = await getOSRMDuration(
      { lat: departurePoint[0], long: departurePoint[1] },
      { lat: srcLat, long: srcLong }
    );

    const pickupTime: Date = addMinutes(offer.departureTime, duration);

    const minTime: Date = subMinutes(reqStartTime, +window);
    const maxTime: Date = addMinutes(reqStartTime, +window);

    return minTime <= pickupTime && pickupTime <= maxTime;
  };
  const filteredList = [];

  for (let e of intersectingOffers) {
    try {
      if (await asyncOp(e)) {
        filteredList.push(e);
      }
    } catch (err) {
      return res.status(500).json({ error: "Error fetching offers" });
    }
  }

  const offers = filteredList.map((offer) => {
    return {
      id: offer.id,
      driver: {
        id: offer.driverid,
        firstname: offer.firstname,
        lastname: offer.lastname,
        isVerified: offer.isVerified,
        gender: offer.gender,
        email: offer.email,
        stars: offer.stars,
        totalRatings: offer.totalRatings,
        profileImageUri: offer.profileImageUri,
        vehicleType: offer.vehicleType,
        vehicleModel: offer.vehicleModel,
      },
      pricePerKm: offer.pricePerKm,
      startTime: offer.departureTime,
      source: {
        name: offer.fromname,
        coordinates: wktToGeoJSON(offer.from).coordinates,
      },
      destination: {
        name: offer.toname,
        coordinates: wktToGeoJSON(offer.to).coordinates,
      },
    };
  });
  return res
    .status(200)
    .json({ success: "Received available offers", offers: offers });
};

export const getRequestDetails = async (req: Request, res: Response) => {
  const { id } = req.params;

  const request = await RideRequest.createQueryBuilder("request")
    //join happens as property of parent
    .leftJoinAndSelect("request.requestToOffers", "rto")
    .where("request.id = :id", { id: +id })
    .leftJoinAndSelect("request.user", "user")
    .select([
      "user.firstname AS fname",
      "user.lastname AS lname",
      "user.id AS id",
      "user.profileImageUri as avatar",
      "request.from AS pickup",
      "request.to AS dropOff",
      "request.departureTime AS startTime",
      "request.updatedAt AS updatedAt",
      "rto.price AS price",
    ])
    .getRawOne();

  return res
    .status(200)
    .json({ success: "Ride Request fetched successfully", request });
};

export const acceptRequest = async (req: Request, res: Response) => {
  const { request, offer } = req.body;

  const requestRepository = AppDataSource.getRepository(RequestToOffer);

  const response = await requestRepository.findOne({
    relations: { request: true, offer: true },
    where: { request: { id: request }, offer: { id: offer } },
  });

  if (!response) throw new AppError(500, { error: "Could not find request" });

  if (response) {
    response.isAccepted = true;
    await response.save();

    const offerObj: RideOffer = await RideOffer.findOne({
      where: { id: offer },
    });

    if (offerObj.seats <= 0) {
      throw new AppError(500, { error: "Seats are all full" });
    }

    offerObj.seats = offerObj.seats - 1;
    if (offerObj.seats == 0) offerObj.status = "booked";
    offerObj.save();

    const requestObject: RideRequest = await RideRequest.findOne({
      where: { id: request },
    });
    requestObject.status = "confirmed";
    await requestObject.save();
  }

  return res.status(200).json({ message: "Request accepted successfully" });
};
