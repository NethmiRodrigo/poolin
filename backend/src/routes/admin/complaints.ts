import { Request, Response } from "express";
import { Polygon } from "wkx";

/** Entities */
import { User } from "../../database/entity/User";

/** Utility functions */
import { AppError } from "../../util/error-handler";

import { AppDataSource } from "../../data-source";
import { Complaint } from "../../database/entity/Complaint";
import { open } from "fs";

/**
 * 
 * Fetch all complaint
 */
export const fetchAllComplaint = async (req: Request, res: Response) => {
  // const { id, verified } = req.params;

  const userRepository = await AppDataSource.getRepository(Complaint);
  const allComplaints = await userRepository.find({ where: { status: "OPEN" } });
  console.log("All Complaints: ", allComplaints);
  return res.json({allComplaints})
};

/**
 * blacklist user
 */
 export const blacklist = async (req: Request, res: Response) => {
  const { email } = req.body;

  const user = await User.findOneBy({ email });

  if (!user) throw new AppError(401, { error: "User not found" });

  user.status = 0;

  await user.save();

  return res.json({ user });
};