import { Request, Response } from "express";

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
  const email = req.query.email;

  const user = await User.findOne({ where: { email: email as string } });

  if (!user) {
    return res.status(404).json({ error: "User not found" });
  }

  const offer = await RideOffer.createQueryBuilder("offer")
    .leftJoinAndSelect("offer.user", "user")
    .where("offer.status IN ('active','booked')")
    .andWhere("user.email = :email", { email: email as string })
    .select(["offer.id AS id"])
    .getRawOne();

  if (!offer) {
    return res.status(404).json({ error: "No active offer" });
  }

  return res
    .status(200)
    .json({ success: "Ride Offer fetched successfully", offer });
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

  const requests = await RideOffer.createQueryBuilder("offer")
    //join happens as property of parent
    .leftJoinAndSelect("offer.requestsToOffer", "request")
    .where("offer.id = :id", { id: +id })
    .where("request.isAccepted = true")
    .leftJoinAndSelect("request.request", "rideRequest")
    .where("rideRequest.status = 'confirmed'")
    .leftJoinAndSelect("rideRequest.user", "user")
    .select([
      "user.firstname AS fname",
      "user.lastname AS lname",
      "user.profileImageUri as avatar",
      "rideRequest.from AS pickup",
      "rideRequest.departureTime AS startTime",
    ])
    .getRawMany();

  return res
    .status(200)
    .json({ success: "Confirmed Requests  fetched successfully", requests });
};
