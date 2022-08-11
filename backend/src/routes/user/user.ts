import { Request, Response } from "express";
import { isEmpty } from "class-validator";
import bcrypt from "bcrypt";

/** Entities */
import { User } from "../../database/entity/User";

/** Utility functions */
import { AppError } from "../../util/error-handler";
import { AppDataSource } from "../../data-source";
import { EntityMetadata } from "typeorm";
import { IsPhoneValid, smsOTP } from "../../util/auth-helper";
import { VerificationStatus } from "../../database/entity/TempUser";
import { findFriendsOfAUser } from "../friends/util";

export const updateInfo = async (req: Request, res: Response) => {
  const user: User = res.locals.user;
  if (!user) throw new AppError(401, { error: "User cannot be found" });

  if (AppDataSource.hasMetadata("users")) {
    const metadata: EntityMetadata = AppDataSource.getMetadata("users");
    const columns = metadata.ownColumns.map((column) => column.propertyName);
    for (const property in req.body) {
      if (!columns.includes(property))
        throw new AppError(400, {}, `${property} not found in User entity`);
      user[property] = req.body[property];
    }
    await user.save();
  } else throw new AppError(500, { error: "Failed to fetch entity metadata" });

  return res.status(200).json({ success: "User updated", user });
};

export const updatePassword = async (req: Request, res: Response) => {
  const user: User = res.locals.user;

  const { password, newPassword, confirmPassword } = req.body;

  let errors: any = {};

  //check for empty fields
  if (isEmpty(password)) errors.password = "Current password cannot be empty";
  if (isEmpty(newPassword)) errors.newPassword = "New password cannot be empty";
  if (isEmpty(confirmPassword))
    errors.confirmPassword = "Confirm password cannot be empty";

  if (Object.keys(errors).length > 0) throw new AppError(401, errors);

  const passwordMatched = await bcrypt.compare(password, user.password);
  if (!passwordMatched) throw new AppError(401, {}, "Incorrect credentials");

  if (newPassword !== confirmPassword)
    throw new AppError(401, {}, "Passwords do not match");

  const hash = await bcrypt.hash(newPassword, 10);
  user.password = hash;
  await user.save();

  return res.status(200).json({ success: "Password successfully updated" });
};

export const updateMobile = async (req: Request, res: Response) => {
  const user: User = res.locals.user;
  if (!user) throw new AppError(401, {}, "User cannot be found");

  const { mobile } = req.body;
  if (isEmpty(mobile))
    throw new AppError(401, { mobile: "Mobile cannot be null" });

  if (!IsPhoneValid(mobile))
    throw new AppError(401, {
      error: "Mobile already registered or mobile number is invalid",
    });

  const { result, otp } = await smsOTP(mobile, user.email, "update");
  if (!result)
    throw new AppError(400, {}, "Couldn't send OTP. Please try again");

  return res.status(200).json({ success: "OTP sent via SMS", otp });
};

export const verifyUpdateMobile = async (req: Request, res: Response) => {
  const user: User = res.locals.user;
  const { otp } = req.body;
  if (!user) throw new AppError(401, {}, "User cannot be found");

  if (user.smsOTP !== otp) throw new AppError(400, { otp: "OTP is incorrect" });

  // verify OTP - If 15 minutes has elapsed
  const currentDate = new Date();
  const expiresAt = new Date(user.smsOTPSentAt.getTime() + 15 * 60000);
  if (currentDate > expiresAt)
    throw new AppError(401, {}, "OTP expired. PLease try again");

  user.mobileVerified = VerificationStatus.VERIFIED;
  const result = await user.save();

  return res
    .status(200)
    .json({ message: "Mobile updated successfully", user: result });
};

export const updateProfileImage = async (req: Request, res: Response) => {
  const user: User = res.locals.user;

  if (!req.file) throw new AppError(401, { error: "File is missing" });

  user.profileImageUri = (req.file as any).key;
  await user.save();

  return res.status(200).json({ user });
};

export const getUser = async (req: Request, res: Response) => {
  const { id } = req.params;

  const user = await User.findOneBy({ id: +id });

  if (!user) throw new AppError(404, { error: "User not found" });

  const friends = await findFriendsOfAUser(user.id.toFixed(1), 1);
  const result = { ...user, friends };

  return res.status(200).json(result);
};
