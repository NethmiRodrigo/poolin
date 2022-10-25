import { Request, Response } from "express";
import { In } from "typeorm";
import { AppDataSource } from "../../data-source";

/** Entities */
import { RideOffer } from "../../database/entity/RideOffer";
import { RideRequest } from "../../database/entity/RideRequest";
import { User } from "../../database/entity/User";

import { getOSRMPolyline } from "../../middleware/osrmpolyline";

export const getParty = async (req: Request, res: Response) => {
  const users = await User.find();

  if (!users) {
    return res.status(404).json({ error: "No party found" });
  }

  return res.status(200).json({ success: "Party fetched successfully", users });
};

export const getOfferParty = async (req: Request, res: Response) => {
  const { id } = req.params;

  const passengers = await RideOffer.createQueryBuilder("offer")
    .where("offer.id = :id", { id: +id })
    .andWhere("offer.status = :status", { status: "active" })
    .leftJoinAndSelect("offer.requestsToOffer", "rto")
    .leftJoinAndSelect("rto.request", "request")
    .where("request.status = :status", { status: "active" })
    .leftJoinAndSelect("offer.user", "user")
    .select([
      "user.id AS id",
      "firstname",
      "lastname",
      `user.profileImageUri as "profileImageUri"`,
    ])
    .getRawMany();

  return res
    .status(200)
    .json({ success: "Offer party fetched successfully", users: passengers });
};

export const getRequestParty = async (req: Request, res: Response) => {
  const { id } = req.params;

  const offer = await RideRequest.createQueryBuilder("request")
    .where("request.id = :id", { id: +id })
    .andWhere("request.status = :status", { status: "active" })
    .leftJoinAndSelect("request.requestToOffers", "rto")
    .leftJoinAndSelect("rto.offer", "offer")
    .select(["offer.id AS id"])
    .getRawOne();

  console.log(offer["id"]);

  const driver = await RideRequest.createQueryBuilder("request")
    .where("request.id = :id", { id: +id })
    .andWhere("request.status = :status", { status: "active" })
    .leftJoinAndSelect("request.requestToOffers", "rto")
    .leftJoinAndSelect("rto.offer", "offer")
    .leftJoinAndSelect("offer.user", "user")
    .select([
      "user.id AS id",
      "firstname",
      "lastname",
      `user.profileImageUri as "profileImageUri"`,
    ])
    .getRawOne();

  const passengers = await RideOffer.createQueryBuilder("offer")
    .where("offer.id = :id", { id: +offer["id"] })
    .andWhere("offer.status = :status", { status: "active" })
    .leftJoinAndSelect("offer.requestsToOffer", "rto")
    .leftJoinAndSelect("rto.request", "request")
    .where("request.status = :status", { status: "active" })
    .leftJoinAndSelect("offer.user", "user")
    .select([
      "user.id AS id",
      "firstname",
      "lastname",
      `user.profileImageUri as "profileImageUri"`,
    ])
    .getRawMany();

  return res.status(200).json({
    success: "Request party fetched successfully",
    driver: driver,
    users: passengers,
  });
};
