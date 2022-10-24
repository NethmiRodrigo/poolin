import { Request, Response } from "express";
import { In } from "typeorm";
import { AppDataSource } from "../../data-source";

/** Entities */
import { RideOffer } from "../../database/entity/RideOffer";
import { User } from "../../database/entity/User";

import { getOSRMPolyline } from "../../middleware/osrmpolyline";

export const getParty = async (req: Request, res: Response) => {
  const users = await User.find();

  if (!users) {
    return res.status(404).json({ error: "No party found" });
  }

  return res.status(200).json({ success: "Party fetched successfully", users });
};
