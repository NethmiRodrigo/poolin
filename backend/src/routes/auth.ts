import { Request, Response, Router } from "express";
import { isEmail, isEmpty } from "class-validator";
import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";
import cookie from "cookie";
import nodemailer from "nodemailer";
import { Transporter } from "nodemailer";
import { MailOptions } from "nodemailer/lib/json-transport";

/** Middleware */
import auth from "../middleware/auth";

/** Utility functions */
import { getMailer, sendPlainMail } from "../util/mailer";
import { AppError } from "../util/error-handler";
import codeHandler from "../util/code-handler";

/** Entities */
import { User } from "../entity/User";
import { ForgotPassword } from "../entity/ForgotPassword";

const login = async (req: Request, res: Response) => {
  const { email, password } = req.body;
  let errors: any = {};
  if (isEmpty(email)) errors.email = "Email cannot be empty";
  if (isEmpty(password)) errors.password = "Password cannot be empty";
  if (!isEmpty(email) && !isEmail(email)) errors.email = "Email is invalid";

  if (Object.keys(errors).length > 0) throw new AppError(401, errors, "");

  const user = await User.findOneBy({ email });
  if (!user) throw new AppError(401, { error: "User not found" });

  const passwordMatched = await bcrypt.compare(password, user.password);
  if (!passwordMatched)
    throw new AppError(401, { error: "Incorrect credentials" });

  const token = jwt.sign({ user }, process.env.JWT_SECRET);

  res.set(
    "Set-Cookie",
    cookie.serialize("Token", token, {
      httpOnly: true,
      secure: process.env.NODE_ENV === "production",
      sameSite: "strict",
    })
  );

  return res.json({ user, token });
};

const getLoggedInUser = async (_: Request, res: Response) => {
  return res.json(res.locals.user);
};

const logout = async (_: Request, res: Response) => {
  res.set(
    "Set-Cookie",
    cookie.serialize("Token", "", {
      httpOnly: true,
      secure: process.env.NODE_ENV === "production",
      sameSite: "strict",
      expires: new Date(0),
    })
  );
  return res.status(200).json({ success: "User logged out" });
};

const sendResetPasswordEmail = async (req: Request, res: Response) => {
  const { email } = req.body;
  if (isEmpty(email)) throw new AppError(400, { email: "Cannot be empty" });
  if (!isEmail(email)) throw new AppError(400, { email: "Invalid email" });

  const user = await User.findOneBy({ email });
  if (!user) throw new AppError(401, { error: "User not found" });

  const otp = codeHandler(4, true);
  const expiresAt = new Date();
  expiresAt.setDate(expiresAt.getDate() + 1);

  const forgotPasswordEntity = new ForgotPassword({ email, otp, expiresAt });
  await forgotPasswordEntity.save();

  const body = `Hi there! You requested to change your password. Please enter the OTP ${otp} in your app to confirm`;

  const mailer: Transporter = await getMailer();

  const mailOptions: MailOptions = {
    to: email,
    from: "poolin@info.com",
    subject: "Password Reset",
    text: body,
  };

  const result = await mailer.sendMail(mailOptions);

  if (process.env.NODE_ENV === "development")
    console.log("✔ Preview URL: %s", nodemailer.getTestMessageUrl(result));

  if (!result.accepted.length && !result.accepted.includes(email))
    throw new Error("Email could not be send. Please try again");

  return res.status(200).json({ success: "Email sent successfully" });
};

const router = Router();
router.post("/login", login);
router.get("/me", auth, getLoggedInUser);
router.get("/logout", auth, logout);
router.post("/send-reset-password-email", sendResetPasswordEmail);

export default router;
