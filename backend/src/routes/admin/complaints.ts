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
