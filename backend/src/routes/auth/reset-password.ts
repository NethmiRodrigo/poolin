import { Request, Response } from "express";
import { isEmail, isEmpty } from "class-validator";
import bcrypt from "bcrypt";
import nodemailer from "nodemailer";
import { MailOptions } from "nodemailer/lib/json-transport";

/** Utility functions */
import { sendPlainMail } from "../../util/mailer";
import { AppError } from "../../util/error-handler";
import codeHandler from "../../util/code-handler";
import { checkIfDateIsExpired } from "../../util/date-checker";

/** Entities */
import { User } from "../../entity/User";
import { ForgotPassword } from "../../entity/ForgotPassword";

/**
 * API Route to send the reset password OTP
 */
export const sendResetPasswordEmail = async (req: Request, res: Response) => {
  const { email } = req.body;
  if (isEmpty(email)) throw new AppError(400, { email: "Cannot be empty" });
  if (!isEmail(email)) throw new AppError(400, { email: "Invalid email" });

  const user = await User.findOneBy({ email });
  if (!user) throw new AppError(401, { error: "User not found" });

  const otp = codeHandler(4, true);
  const expiresAt = new Date();
  expiresAt.setDate(expiresAt.getDate() + 1);

  const forgotPasswordEntity = new ForgotPassword({
    email,
    otp,
    expiresAt,
    used: false,
  });
  await forgotPasswordEntity.save();

  const body = `Hi there! You requested to change your password. Please enter the OTP ${otp} in your app to confirm`;

  const mailOptions: MailOptions = {
    to: email,
    from: "poolin@info.com",
    subject: "Password Reset",
    text: body,
  };

  const result = await sendPlainMail(mailOptions);

  if (!result || (!result.accepted.length && !result.accepted.includes(email)))
    throw new Error("Email could not be send. Please try again");

  if (process.env.NODE_ENV !== "production")
    console.log("✔ Preview URL: %s", nodemailer.getTestMessageUrl(result));

  return res.status(200).json({ success: "Email sent successfully" });
};

/**
 * API Route to verify the OTP for reset password
 */
export const verifyResetPasswordOTP = async (req: Request, res: Response) => {
  const { email, otp } = req.body;
  let errors: any = {};
  if (isEmpty(email)) errors.email = "Email cannot be empty";
  if (!isEmpty(email) && !isEmail(email)) errors.email = "Email is invalid";
  if (isEmpty(otp)) errors.otp = "OTP cannot be empty";

  if (Object.keys(errors).length) throw new AppError(400, errors);

  const user = User.findOneBy({ email });
  if (!user) throw new AppError(400, {}, "Wrong email");

  const forgotPasswordEntity = await ForgotPassword.findOneBy({ otp, email });
  if (!forgotPasswordEntity)
    throw new AppError(
      400,
      {},
      "Wrong OTP. Please request a new one and try again"
    );

  if (forgotPasswordEntity.used)
    throw new AppError(400, {}, "OTP is invalid. Please try again");

  if (checkIfDateIsExpired(forgotPasswordEntity.expiresAt))
    throw new AppError(
      400,
      {},
      "Your OTP has expired. Please request a new one and try again"
    );

  forgotPasswordEntity.used = true;
  await forgotPasswordEntity.save();

  return res.status(200).json({ success: "OTP verified successfully" });
};

/**
 * API Route to reset password
 */
export const resetPassword = async (req: Request, res: Response) => {
  const { password, confirmPassword, email, otp } = req.body;
  let errors: any = {};

  if (isEmpty(password)) errors.password = "Password cannot be empty";
  if (isEmpty(confirmPassword))
    errors.confirmPassword = "Confirm password cannot be empty";
  if (isEmpty(email)) errors.email = "Email cannot be empty";
  if (isEmpty(otp)) errors.otp = "OTP cannot be empty";
  if (!isEmpty && !isEmail(email)) errors.email = "Email is invalid";
  if (password !== confirmPassword) errors.password = "Passwords do not match";

  if (Object.keys(errors).length > 0) throw new AppError(400, errors, "");

  const forgotPasswordEntity = await ForgotPassword.findOneBy({ email, otp });
  if (!forgotPasswordEntity) throw new AppError(400, {}, "Invalid OTP");
  if (!forgotPasswordEntity.used)
    throw new AppError(400, {}, "OTP has not being verified");

  if (checkIfDateIsExpired(forgotPasswordEntity.expiresAt))
    throw new AppError(400, {}, "Password reset request has expired");

  const user = await User.findOneBy({ email });
  if (!user) throw new AppError(400, {}, "User cannot be found");

  user.password = await bcrypt.hash(password, 8);
  await user.save();

  await forgotPasswordEntity.remove();
  return res.status(200).json({ success: "Successfully updated password" });
};
