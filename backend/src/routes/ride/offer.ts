import { Request, Response } from "express";

/** Entities */
import { RideOffer } from "../../database/entity/RideOffer";
import { User } from "../../database/entity/User";

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
    where: [{ id: +id }, { isActive: true }],
  });

  if (!offer) {
    return res.status(404).json({ error: "No active offer" });
  }

  return res
    .status(200)
    .json({ success: "Ride Offer fetched successfully", offer });
};

export const getOfferRequests = async (req: Request, res: Response) => {
  const { id } = req.params;

  const offers = await RideOffer.createQueryBuilder("offer")
    //join happens as property of parent
    .leftJoinAndSelect("offer.requestsToOffer", "request")
    .where("offer.id = :id", { id: +id })
    .leftJoinAndSelect("request.request", "rideRequest")
    .where("rideRequest.isActive = true")
    .leftJoinAndSelect("rideRequest.user", "user")
    .select([
      "user.firstname AS fname",
      "rideRequest.id AS requestId",
      "request.price AS price",
    ])
    .getRawMany();

  return res
    .status(200)
    .json({ success: "Ride Offer fetched successfully", offers });
};

export const getConfirmedRequests = async (req: Request, res: Response) => {
  const { id } = req.params;

  const offers = await RideOffer.createQueryBuilder("offer")
    //join happens as property of parent
    .leftJoinAndSelect("offer.requestsToOffer", "request")
    .where("offer.id = :id", { id: +id })
    .where("request.isAccepted = true")
    .leftJoinAndSelect("request.request", "rideRequest")
    .leftJoinAndSelect("rideRequest.user", "user")
    .select([
      "user.firstname AS fname",
      "user.lastname AS lname",
      "rideRequest.from AS pickup",
      "rideRequest.startTime AS startTime",
    ])
    .getRawMany();

  return res
    .status(200)
    .json({ success: "Ride Offer fetched successfully", offers });
};
