import { Request, Response } from "express";
import { isEmpty } from "class-validator";
import bcrypt from "bcrypt";

/** Entities */
import { RideOffer } from "../../database/entity/RideOffer";

/** Utility functions */
import { AppError } from "../../util/error-handler";
import { AppDataSource } from "../../data-source";
import { EntityMetadata } from "typeorm";
import { Point } from "geojson";

export const postRideOffer = async (req: Request, res: Response) => {
  const { userId, src, dest, seats, ppkm, startTime, endTime, distance } =
    req.body;

  const newOffer = new RideOffer({
    userId: userId,
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
