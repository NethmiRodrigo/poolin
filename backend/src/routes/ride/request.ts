import { Request, Response } from "express";

/** Entities */
import { RideOffer } from "../../database/entity/RideOffer";
import { RideRequest } from "../../database/entity/RideRequest";
import { User } from "../../database/entity/User";
import { RequestToOffer } from "../../database/entity/RequestToOffer";

export const postRideRequests = async (req: Request, res: Response) => {
  const { email, offers, src, dest, startTime, window, distance, price } =
    req.body;

  const user = await User.findOne({ where: { email } });

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

  return res.status(200).json({ success: "Ride Offer posted successfully" });
};

export const getRequestDetails = async (req: Request, res: Response) => {
  const { id } = req.params;

  const request = await RideRequest.createQueryBuilder("request")
    //join happens as property of parent
    .leftJoinAndSelect("offer.requestsToOffer", "rto")
    .where("request.id = :id", { id: +id })
    .leftJoinAndSelect("request.user", "user")
    .select([
      "user.firstname AS fname",
      "user.lastname AS lname",
      "user.id AS id",
      "user.profileImageUri as avatar",
      "request.from AS pickup",
      "request.to AS dropOff",
      "request.startTime AS startTime",
    ])
    .getRawMany();

  return res
    .status(200)
    .json({ success: "Ride Request fetched successfully", request });
};