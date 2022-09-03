import { Request, Response } from "express";
import { In } from "typeorm";
import { AppDataSource } from "../../data-source";

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

  const rideRepository = AppDataSource.getRepository(RideOffer);

  const response = await rideRepository.findOne({
    relations: { user: true, requestsToOffer: true },
    where: { user: { email: user.email }, status: In(["active", "booked"]) },
  });

  if (!response) {
    return res.status(200).json({ error: "No active offer", offer: null });
  }

  return res.status(200).json({ offer: response });
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
      "user.id as user_id",
      "user.profileImageUri as avatar",
      "rideRequest.from AS pickup",
      "rideRequest.departureTime AS startTime",
      "request.price AS price",
    ])
    .getRawMany();

  return res
    .status(200)
    .json({ success: "Confirmed Requests  fetched successfully", requests });
};
