import { Request, Response } from "express";
import { isEmpty } from "class-validator";
import bcrypt from "bcrypt";

/** Entities */
import { RideOffer } from "../../database/entity/RideOffer";
import { RideRequest } from "../../database/entity/RideRequest";
import { User } from "../../database/entity/User";
import { RequestToOffer } from "../../database/entity/RequestToOffer";
import { off } from "process";

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
