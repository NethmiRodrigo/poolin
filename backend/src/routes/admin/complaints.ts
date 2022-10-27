import { Request, Response } from "express";
import { Polygon } from "wkx";

/** Entities */
import { User } from "../../database/entity/User";

/** Utility functions */
import { AppError } from "../../util/error-handler";

import { AppDataSource } from "../../data-source";
import { Complaint } from "../../database/entity/Complaint";

/**
 * 
 * Fetch all complaint
 */
export const fetchAllComplaint = async (req: Request, res: Response) => {
  // const { id, verified } = req.params;

  const userRepository = await AppDataSource.getRepository(Complaint);
  const allComplaints = await userRepository.find();
  console.log("All Complaints: ", allComplaints);
  return res.json({allComplaints})
};

/**
 * blacklist user
 */
 export const blacklist = async (req: Request, res: Response) => {
  const { complaineeId } = req.params;

  const user = await User.findOneBy({ id: +complaineeId });

  if (!user) throw new AppError(401, { error: "User not found" });

  const { status } = req.body;
  user.status = status;

  await user.save();

  return res.json({ user });
};

/**
 * close complaint
 */
 export const closeComplaint = async (req: Request, res: Response) => {
  const { id } = req.params;

  const complaint = await Complaint.findOneBy({ id: +id });

  const { status } = req.body;

  complaint.status = status;

  await complaint.save();

  return res.json({ complaint });
};