import { Request, Response } from "express";
import { Double, In } from "typeorm";
import { AppDataSource } from "../../data-source";
import { wktToGeoJSON } from "@terraformer/wkt";

/** Entities */
import { RideOffer } from "../../database/entity/RideOffer";
import { User } from "../../database/entity/User";

import { getOSRMPolyline } from "../../middleware/osrmpolyline";

export const postRideOffer = async (req: Request, res: Response) => {
  const { email, src, dest, seats, ppkm, startTime, endTime, distance } =
    req.body;

  const user = await User.findOne({ where: { email } });

  const newOffer = new RideOffer({
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
    polyline: {
      type: "LineString",

      coordinates: await getOSRMPolyline(src, dest),
    },

    departureTime: startTime,
    arrivalTime: endTime,
    pricePerKm: ppkm,
    seats: seats,
    distance: distance,
  });

  await newOffer.save();

  return res.status(200).json({ success: "Ride Offer posted successfully" });
};

export const getOfferDetails = async (req: Request, res: Response) => {
  const { id } = req.params;

  const offer = await RideOffer.findOne({
    where: [{ id: +id }],
  });

  if (!offer) {
    return res.status(404).json({ error: "No active offer" });
  }

  return res
    .status(200)
    .json({ success: "Ride Offer fetched successfully", offer });
};

export const getActiveOffer = async (req: Request, res: Response) => {
  const user: User = res.locals.user;

  if (!user) {
    return res.status(404).json({ error: "User not found" });
  }

  const response = await RideOffer.createQueryBuilder("offer")
    .where("offer.userId = :id", { id: user.id })
    .andWhere("offer.status = 'booked'")
    .select([
      "offer.id AS id",
      "offer.from AS fromName",
      "ST_AsText(offer.fromGeom) AS from",
      "offer.to AS toName",
      "ST_AsText(offer.toGeom) AS to",
      "offer.departureTime AS departureTime",
      "offer.arrivalTime AS arrivalTime",
      "offer.pricePerKm AS pricePerKm",
      "offer.status AS status",
      "offer.seats AS seats",
      "offer.distance AS distance",
    ])
    .getRawOne();

  if (!response) {
    return res.status(200).json({ error: "No active offer", offer: null });
  }

  const offer = {
    id: response.id,
    departureTime: new Date(+new Date(response.departuretime) + 60000*330),
    arrivalTime: new Date(+new Date(response.arrivaltime) + 60000*330),
    pricePerKm: response.priceperkm,
    status: response.status,
    seats: response.seats,
    distance: response.distance,
    source: {
      name: response.fromname,
      coordinates: wktToGeoJSON(response.from).coordinates,
    },
    destination: {
      name: response.toname,
      coordinates: wktToGeoJSON(response.to).coordinates,
    },
  }

  return res.status(200).json({ offer: offer });
};

export const getOfferRequests = async (req: Request, res: Response) => {
  const { id } = req.params;

  const requests = await RideOffer.createQueryBuilder("offer")
    //join happens as property of parent
    .leftJoinAndSelect("offer.requestsToOffer", "request")
    .where("offer.id = :id", { id: +id })
    .leftJoinAndSelect("request.request", "rideRequest")
    .where("rideRequest.status = 'active'")
    .leftJoinAndSelect("rideRequest.user", "user")
    .select([
      "user.firstname AS fname",
      "user.lastname AS lname",
      "rideRequest.from as start",
      "rideRequest.to as end",
      "user.profileImageUri as avatar",
      "rideRequest.id AS requestId",
      "request.price AS price",
    ])
    .getRawMany();

  return res
    .status(200)
    .json({ success: "Ride Offer Requests fetched successfully", requests });
};

export const getConfirmedRequests = async (req: Request, res: Response) => {
  const { id } = req.params;

  const fetchedRequests = await RideOffer.createQueryBuilder("offer")
    //join happens as property of parent
    .leftJoinAndSelect("offer.requestsToOffer", "request")
    .where("offer.id = :id", { id: +id })
    .where("request.isAccepted = true")
    .leftJoinAndSelect("request.request", "rideRequest")
    .where("rideRequest.status = 'confirmed'")
    .leftJoinAndSelect("rideRequest.user", "user")
    .select([
      "user.firstname AS firstname",
      "user.lastname AS lastname",
      "user.id AS user_id",
      "user.profileImageUri AS avatar",
      "rideRequest.departureTime AS pickupTime",
      "ST_AsText(rideRequest.fromGeom) AS from",
      "rideRequest.from AS fromName",
      "ST_AsText(rideRequest.toGeom) AS to",
      "rideRequest.to AS toName",
      "request.price AS price",
    ])
    .getRawMany();

  let requests = [];
  requests = fetchedRequests.map((req) => {
    return {
      user_id: req.user_id,
      firstname: req.firstname,
      lastname: req.lastname,
      avatar: req.avatar,
      pickupTime: new Date(+new Date(req.pickuptime) + 60000*330),
      price: parseFloat(req.price).toFixed(2),
      pickup: {
        name: req.fromname,
        coordinates: wktToGeoJSON(req.from).coordinates,
      },
      dropoff: {
        name: req.toname,
        coordinates: wktToGeoJSON(req.to).coordinates,
      },
    };
  });

  return res
    .status(200)
    .json({ success: "Confirmed Requests fetched successfully", requests });
};
