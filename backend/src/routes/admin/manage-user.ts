import { Request, Response } from "express";

/** Entities */
import { User } from "../../database/entity/User";

/** Utility functions */
import { AppError } from "../../util/error-handler";

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
