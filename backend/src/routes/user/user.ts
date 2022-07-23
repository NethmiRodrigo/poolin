import { Request, Response } from "express";

/** Entities */
import { User } from "../../database/entity/User";

/** Utility functions */
import { AppError } from "../../util/error-handler";

export const updateProfileImage = async (req: Request, res: Response) => {
  const user: User = res.locals.user;

  if (!req.file)
    if (user) throw new AppError(401, { error: "File is missing" });

  user.profileImageUri = (req.file as any).key;
  await user.save();

  return res.status(200).json({ user });
};
