import { Transporter } from "nodemailer";
import { MailOptions } from "nodemailer/lib/json-transport";
import cookie from "cookie";
import jwt from "jsonwebtoken";

/** Utility functions */
import { getMailer, sendPlainMail } from "../util/mailer";
import codeHandler from "./code-handler";
import { AppError } from "./error-handler";
import { sendSMS } from "../util/sms-api";

/** Entities */
import { TempUser, VerificationStatus } from "../database/entity/TempUser";
import { EmailFormat } from "../database/entity/EmailFormat";
import { Response } from "express";
import { User } from "../database/entity/User";

/**
 * @description - This function removes the user from TempUser entity and addds the user to the User entity
 * @param tempID - number (id of user in TempUser)
 * @returns object (user)
 */
export const createUserAccount = async (tempID: number) => {
  const tempUser = await TempUser.findOneBy({ id: tempID });
  if (!tempUser) throw new AppError(401, {}, "Couldn't create account");

  if (tempUser.emailStatus != VerificationStatus.VERIFIED)
    throw new AppError(401, {}, "User email not verified");
  if (tempUser.mobileStatus != VerificationStatus.VERIFIED)
    throw new AppError(401, {}, "User mobile not verified");

  // save user in database
  const user = await User.create({
    email: tempUser.email,
    password: tempUser.password,
    mobile: tempUser.mobile,
  }).save();

  // remove user from TempUser entity
  const removedUser = await TempUser.delete({ id: tempID });
  if (!removedUser) throw new AppError(401, {}, "Couldn't create account");

  return user;
};

/**
 * @description - This function checks if an email is already registered
 * @param email - string (email)
 * @returns boolean
 */
export const isEmailRegistered = async (email: string) => {
  const user = await User.findOneBy({ email });
  if (!user) return false;
  else return true;
};

/**
 * @description - This function is used to sender a 4-digit OTP via SMS to a new user
 * @param mobile - string (recepient's mobile number)
 * @param email - string (email of user)
 * @returns response from SMS API
 */
export const smsOTP = async (
  mobile: string,
  email: string,
  type: string = "signup"
) => {
  // generate 4-digit OTP
  const otp = codeHandler(4, true);

  // calculate expiration time (should expire in 15 mins)
  const currentDate = new Date();
  const expiresAt = new Date(currentDate.getTime() + 15 * 60000);

  // save mobile and otp in database
  if (type === "signup") {
    const tempUser = await TempUser.findOneBy({ email });
    if (!tempUser) throw new AppError(400, {}, "User cannot be found");
    tempUser.mobile = mobile;
    tempUser.smsOTP = otp;
    tempUser.smsOTPSentAt = currentDate;
    await tempUser.save();
  } else {
    const user = await User.findOneBy({ email });
    if (!user) throw new AppError(400, {}, "Could not find user");
    user.mobile = mobile;
    user.smsOTP = otp;
    user.smsOTPSentAt = currentDate;
    user.mobileVerified = VerificationStatus.UNVERIFIED;
    await user.save();
  }

  // send SMS
  const message = `Hi there! This is to verify the mobile number of your Poolin account. Please enter the OTP ${otp} in your app to verify (Expires at: ${expiresAt}`;

  const result = await sendSMS(mobile, message);
  return { otp, result };
};

/**
 * @description - This function is used to verify the domain of an email
 * @param email - string (email to be verified)
 * @returns boolean
 */
export const isEmailDomainValid = async (email: string) => {
  const validEmailFormats = await EmailFormat.find({
    select: { emailFormat: true },
  });

  let isValid = false;

  for (let i = 0; i < validEmailFormats.length; i++) {
    if (
      email
        .toLowerCase()
        .endsWith(validEmailFormats[i].emailFormat.toLowerCase())
    ) {
      isValid = true;
      break;
    }
  }

  return isValid;
};

/**
 * @description - This function is used to sender a 4-digit OTP via email to a new user
 * @param email - string (email to be verified)
 * @returns boolean
 */
export const emailOTPAtSignup = async (email: string) => {
  // generate 4-digit OTP
  const otp = codeHandler(4, true);

  // calculate expiration time (should expire in 15 mins)
  const currentDate = new Date();
  const expiresAt = new Date(currentDate.getTime() + 1 * 60000);

  // save otp in database
  const tempUser = await TempUser.findOneBy({ email });
  if (!tempUser) throw new AppError(400, {}, "Email cannot be found");
  tempUser.emailOTP = otp;
  tempUser.emailOTPSentAt = currentDate;
  await tempUser.save();

  // send email
  const body = `Hi there! 
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
  const result = await sendPlainMail(mailOptions);

  if (!result || (!result.accepted.length && !result.accepted.includes(email)))
    throw new Error("Email could not be send. Please try again");

  return { result, otp };
};

/**
 * @description - This function generates a new token for a user
 * @param response - Response (to be sent to user)
 * @param user - object (user)
 * @returns token, response
 */
export const createUserToken = async (response: Response, user: object) => {
  const token = jwt.sign({ user }, process.env.JWT_SECRET);

  response.set(
    "Set-Cookie",
    cookie.serialize("Token", token, {
      httpOnly: true,
      secure: process.env.NODE_ENV === "production",
      sameSite: "strict",
      path: "/",
    })
  );

  return { token, response };
};

/**
 * @description Checks if a phone number is valid
 * @param mobile
 * @returns a boolean
 */
export const IsPhoneValid = async (mobile: string) => {
  let valid = true;
  // remove all non-numeric characters except '+'
  mobile = mobile.replace(/[^\+0-9]/gi, "");

  // check if mobile number is valid
  // (should have a leading '+' followed by 11 digits)
  if (!/^\+[0-9]+$/.test(mobile) || !(mobile.length == 12)) valid = false;

  // check if mobile number already registered
  const user = await User.findOneBy({ mobile });
  if (user) valid = false;

  return valid;
};
