import { Request, Response, Router } from "express";
import { isEmail, isEmpty } from "class-validator";
import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";
import cookie from "cookie";
import { getConnection } from "typeorm";
import nodemailer from "nodemailer";
import { Transporter } from "nodemailer";
import { MailOptions } from "nodemailer/lib/json-transport";

/** Middleware */
import auth from "../middleware/auth";

/** Utility functions */
import { getMailer, sendPlainMail } from "../util/mailer";
import { sendSMS } from "../util/sms-api";
import { AppError } from "../util/error-handler";
import codeHandler from "../util/code-handler";
import { checkIfDateIsExpired } from "../util/date-checker";

/** Entities */
import { User } from "../entity/User";
import { EmailFormat } from "../entity/EmailFormat";
import { TempUser, VerificationStatus } from "../entity/TempUser";
import { ForgotPassword } from "../entity/ForgotPassword";

import { AppDataSource } from "../data-source";

/**
 * Login API Route
 */
const login = async (req: Request, res: Response) => {
  const { email, password } = req.body;
  let errors: any = {};
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

/**
 * API route to verify new user's credentials 
 */
const verifyCredentials = async (req: Request, res: Response) => {
  const { email, password, confirmPassword } = req.body;
  let errors: any = {};
  if (!isEmpty(email) && !isEmail(email)) errors.email = "Email is invalid";
  if (isEmpty(password)) errors.password = "Password cannot be empty";
  if (isEmpty(confirmPassword)) errors.confirmPassword = "Confirm password cannot be empty";

  if (Object.keys(errors).length > 0) throw new AppError(401, errors);

  // check if passwords match
  if(password != confirmPassword) throw new AppError(401, {}, "Passwords do not match");

  // check password strength
  if(password.length < 8) throw new AppError(401, {}, "Password too short");

  // check if email is already registered
  if(!isEmailRegistered(email)) throw new AppError(401, {}, "Email already registered");

  // check if email belongs to any supported domain
  if(!isEmailDomainValid(email)) throw new AppError(401, {}, "Invalid email");

  // save user credentials in temporary entity
  const tempUser = await TempUser.create({ email: email, password: password }).save()

  // send OTP via Email (valid for 15 mins)
  const result = await emailOTP(email);
  if (!result.accepted.length && !result.accepted.includes(email))
  throw new Error("Email could not be send. Please try again");

  return res.status(200).json({ success: "OTP sent via email", email });
}

const isEmailRegistered = async (email)  => {
  const user = await User.findOneBy({ email });
  if (user) {
    return true;
  } else {
    return false;
  }
}

const isEmailDomainValid = async (email)  => {
  const validEmailFormats = await EmailFormat.find({select: { emailFormat: true }});

  let isValid = false;

  for(let i=0; i<validEmailFormats.length; i++) {
    if(email.toLowerCase().endsWith(validEmailFormats[i].emailFormat.toLowerCase())) {
      isValid = true;
      break;
    }
  }

  return isValid;
}

/**
 * API Route to resend email OTP 
 */
 const resendEmailOTP = async (req: Request, res: Response) => {
  const email = req.body.email;

  if (!isEmpty(email) && !isEmail(email)) throw new AppError(400, {}, "Invalid email");

  const result = await emailOTP(email)
  if (!result.accepted.length && !result.accepted.includes(email))
  throw new Error("Email could not be send. Please try again");

  return res.status(200).json({ success: "OTP re-sent via email", email });
}

const emailOTP = async (email) => {
  // generate 4-digit OTP
  const otp = codeHandler(4, true);
  
  // calculate expiration time (should expire in 15 mins)
  const currentDate = new Date();
  const expiresAt = new Date(currentDate.getTime() + 1*60000);

  // save otp in database
  const tempUser = await TempUser.findOneBy({ email });
  if (!tempUser) throw new AppError(400, {}, "Email cannot be found");
  tempUser.emailOTP = otp;
  tempUser.emailOTPSentAt = currentDate;
  await tempUser.save();

  // send email
  const body = 
  `Hi there! 
  This is verify the email of your Poolin account. 
  Please enter the OTP ${otp} in your app to verify 
  (Expires at: ${expiresAt}`;

  const mailer: Transporter = await getMailer();

  const mailOptions: MailOptions = {
    to: email,
    from: "poolin@info.com",
    subject: "Your verification code for Poolin",
    text: body,
  };

  // send otp
  const result = await mailer.sendMail(mailOptions);

  if (process.env.NODE_ENV === "development")
  console.log("✔ Preview URL: %s", nodemailer.getTestMessageUrl(result));

  return result;
}

/**
 * API Route to verify email OTP
 */
const verifyEmailOTP = async (req: Request, res: Response) => {
  const { email, otp, } = req.body;
  let errors: any = {};

  if (!isEmpty(email) && !isEmail(email)) errors.email = "Email is invalid";
  if (isEmpty(otp)) errors.otp = "Please enter OTP";

  if (Object.keys(errors).length > 0) throw new AppError(401, errors);

  // check if email previously saved in TempUser
  const tempUser = await TempUser.findOneBy({ email });
  if (!tempUser) throw new AppError(401, {}, "Email not recognized");

  // verify OTP - If 15 minutes has elapsed
  const currentDate = new Date();
  const expiresAt = new Date(tempUser.emailOTPSentAt.getTime() + 15*60000);
  if(expiresAt < currentDate ) throw new AppError(401, {}, "OTP expired. PLease try again");

  // update email verification status
  tempUser.emailStatus = VerificationStatus.VERIFIED;
  await tempUser.save();
  
  return res.status(200).json({ success: "Email verified" });
}

/**
 * API Route to verify Mobile Number
 */
const verifyMobileNumber = async (req: Request, res: Response) => {
  let { mobile, email, } = req.body;
  let errors: any = {};

  if (!isEmpty(email) && !isEmail(email)) errors.email = "Email is invalid";
  if (isEmpty(mobile)) errors.mobile = "Please enter mobile number";

  if (Object.keys(errors).length > 0) throw new AppError(401, errors);

  // remove all non-numeric characters except '+'
  mobile = mobile.replace(/[^\+0-9]/ig, "");

  // check if mobile number is valid 
  // (should have a leading '+' followed by 11 digits)
  if (!(/^\+[0-9]+$/.test(mobile)) || !(mobile.length == 12)) throw new AppError(401, {}, "Invalid mobile number");

  // check if mobile number already registered
  const user = await User.findOneBy({ mobile });
  if (user) throw new AppError(401, { error: "Mobile already registered" });

  const result = await smsOTP(mobile, email)
  if (!result) throw new AppError(400, {}, "Couldn't send OTP. Please try again")

  console.log(result)

  return res.status(200).json({ success: "OTP sent via SMS" });
}

const smsOTP = async (mobile, email) => {
  // generate 4-digit OTP
  const otp = codeHandler(4, true);
  
  // calculate expiration time (should expire in 15 mins)
  const currentDate = new Date();
  const expiresAt = new Date(currentDate.getTime() + 15*60000)

  // save mobile and otp in database
  const tempUser = await TempUser.findOneBy({ email });
  if (!tempUser) throw new AppError(400, {}, "User cannot be found");
  tempUser.mobile = mobile;
  tempUser.smsOTP = otp;
  tempUser.smsOTPSentAt = currentDate;
  await tempUser.save();

  // send SMS
  const message = 
  `Hi there! This is to verify the mobile number of your Poolin account. Please enter the OTP ${otp} in your app to verify (Expires at: ${expiresAt}`;

  return await sendSMS(mobile, message)
}

/**
 * API Route to verify sms OTP
 */
 const verifySMSOTP = async (req: Request, res: Response) => {
  const { email, mobile, otp, } = req.body;
  let errors: any = {};

  if (!isEmpty(email) && !isEmail(email)) errors.email = "Email is invalid";
  if (isEmpty(mobile)) errors.mobile = "Please enter mobile number";
  if (isEmpty(otp)) errors.otp = "Please enter OTP";

  if (Object.keys(errors).length > 0) throw new AppError(401, errors);

  // check if email previously saved in TempUser
  const tempUser = await TempUser.findOneBy({ email });
  if (!tempUser) throw new AppError(401, {}, "Email not recognized");
  if (tempUser.mobile != mobile) throw new AppError(401, {}, "New mobile number detected");

  // verify OTP - If 15 minutes has elapsed
  const currentDate = new Date();
  const expiresAt = new Date(tempUser.smsOTPSentAt.getTime() + 15*60000);
  if(expiresAt < currentDate ) throw new AppError(401, {}, "OTP expired. PLease try again");

  // update SMS verification status
  tempUser.mobileStatus = VerificationStatus.VERIFIED;
  const result = await tempUser.save();

  // const accountCreated = await createUserAccount(result.id)

  return res.status(200).json({ success: "Mobile number verified" });
}

const createUserAccount = async (tempID) => {
  const tempUser = await TempUser.findOneById(tempID);
  if (!tempUser) throw new AppError(401, {}, "Couldn't create account");

  // // save user in database
  // const user = await User.create({ 
  //   email: tempUser.email, 
  //   password: tempUser.password,
  //   mobile: tempUser.mobile 
  // }).save()

}

/**
 * API Route to get the logged in user details
 */
 const getLoggedInUser = async (_: Request, res: Response) => {
  return res.json(res.locals.user);
};

/**
 * API Route to log the user out
 */
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

/**
 * API Route to send the reset password OTP
 */
const sendResetPasswordEmail = async (req: Request, res: Response) => {
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

/**
 * API Route to verify the OTP for reset password
 */
const verifyResetPasswordOTP = async (req: Request, res: Response) => {
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

  if (checkIfDateIsExpired)
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
const resetPassword = async (req: Request, res: Response) => {
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

  user.password = password;
  await user.save();

  await AppDataSource.createQueryBuilder()
    .delete()
    .from(ForgotPassword)
    .where("email = :email AND otp = :otp", { email, otp })
    .execute();
  return res.status(200).json({ success: "Successfully updated password" });
};

const router = Router();
router.post("/login", login);
router.post("/verify-credentials", verifyCredentials);
router.post("/verify-mobile-num", verifyMobileNumber);
router.post("/verify-email-otp", verifyEmailOTP);
router.post("/verify-sms-otp", verifySMSOTP);
router.get("/me", auth, getLoggedInUser);
router.get("/logout", auth, logout);
router.post("/send-reset-password-email", sendResetPasswordEmail);
router.post("/verify-password-otp", verifyResetPasswordOTP);
router.post("/reset-password", resetPassword);

export default router;
