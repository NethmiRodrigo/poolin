import { Request, Response } from "express";
import { Polygon } from "wkx";

/** Entities */
import { User } from "../../database/entity/User";

/** Utility functions */
import { AppError } from "../../util/error-handler";

import { AppDataSource } from "../../data-source";

/**
 * Verify user
 */
export const toggleVerification = async (req: Request, res: Response) => {
  const { id, verified } = req.params;

  const user = await User.findOneBy({ id: +id });
  if (!user) throw new AppError(401, { error: "User not found" });

  const verfiedBool = verified === "true";

  user.isVerified = verfiedBool;

  await user.save();

  return res.json({ user });
};

/**
 *
 * Fetch all users
 */
export const fetchAllUsers = async (req: Request, res: Response) => {
  // const { id, verified } = req.params;

  const userRepository = await AppDataSource.getRepository(User);
  const allUsers = await userRepository.find();
  console.log("All users: ", allUsers);
  return res.json({ allUsers });
};
