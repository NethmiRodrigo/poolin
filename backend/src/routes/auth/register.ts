import { Request, Response } from "express";
import { isEmail, isEmpty } from "class-validator";
import bcrypt from "bcrypt";

/** Utility functions */
import { AppError } from "../../util/error-handler";
import {
  createUserAccount,
  createUserToken,
  emailOTPAtSignup,
  isEmailDomainValid,
  isEmailRegistered,
  smsOTP,
} from "../../util/auth-helper";

/** Entities */
import { User } from "../../database/entity/User";
import { TempUser, VerificationStatus } from "../../database/entity/TempUser";

/**
 * API route to verify new user's credentials
 */
export const verifyCredentials = async (req: Request, res: Response) => {
  const { email, password, confirmPassword } = req.body;
  let errors: any = {};
  if (!isEmpty(email) && !isEmail(email)) errors.email = "Email is invalid";
  if (isEmpty(password)) errors.password = "Password cannot be empty";
  if (isEmpty(confirmPassword))
    errors.confirmPassword = "Confirm password cannot be empty";

  if (Object.keys(errors).length > 0) throw new AppError(401, errors);

  // check if passwords match
  if (password != confirmPassword)
    throw new AppError(401, {}, "Passwords do not match");

  // check password strength
  if (password.length < 8) throw new AppError(401, {}, "Password too short");

  // check if email is already registered
  let confirmation = await isEmailRegistered(email);
  if (confirmation) throw new AppError(401, {}, "Email already registered");

  // check if email belongs to any supported domain
  if (!isEmailDomainValid(email)) throw new AppError(401, {}, "Invalid email");

  const tempUser = await TempUser.findOneBy({ email });
  if (tempUser) {
    const hashedPassword = await bcrypt.hash(password, 8);
    await TempUser.update({ email }, { email, password: hashedPassword });
  }
  // save user credentials in temporary entity
  else {
    const newUser = new TempUser({
      email: email,
      password: password,
    });
    const result = await newUser.save();
    console.log(result);
  }

  // send OTP via Email (valid for 15 mins)
  const { otp } = await emailOTPAtSignup(email);

  return res.status(200).json({ success: "OTP sent via email", email, otp });
};

/**
 * API Route to resend email OTP
 */
export const resendEmailOTP = async (req: Request, res: Response) => {
  const email = req.body.email;

  if (!isEmpty(email) && !isEmail(email))
    throw new AppError(400, {}, "Invalid email");

  const { otp } = await emailOTPAtSignup(email);

  return res.status(200).json({ success: "OTP re-sent via email", email, otp });
};

/**
 * API Route to verify email OTP
 */
export const verifyEmailOTP = async (req: Request, res: Response) => {
  const { email, otp } = req.body;
  let errors: any = {};

  if (!isEmpty(email) && !isEmail(email)) errors.email = "Email is invalid";
  if (isEmpty(otp)) errors.otp = "Please enter OTP";

  if (Object.keys(errors).length > 0) throw new AppError(401, errors);

  // check if email previously saved in TempUser
  const tempUser = await TempUser.findOneBy({ email });
  if (!tempUser) throw new AppError(401, {}, "Email not recognized");

  // verify OTP - If 15 minutes has elapsed
  const currentDate = new Date();
  const expiresAt = new Date(tempUser.emailOTPSentAt.getTime() + 15 * 60000);
  if (currentDate > expiresAt)
    throw new AppError(401, {}, "OTP expired. PLease try again");

  // update email verification status
  tempUser.emailStatus = VerificationStatus.VERIFIED;
  await tempUser.save();

  return res.status(200).json({ success: "Email verified" });
};

/**
 * API Route to verify mobile number or request a new OTP
 */
export const verifyMobileNumber = async (req: Request, res: Response) => {
  let { mobile, email } = req.body;
  let errors: any = {};

  if (!isEmpty(email) && !isEmail(email)) errors.email = "Email is invalid";
  if (isEmpty(mobile)) errors.mobile = "Please enter mobile number";

  if (Object.keys(errors).length > 0) throw new AppError(401, errors);

  // remove all non-numeric characters except '+'
  mobile = mobile.replace(/[^\+0-9]/gi, "");

  // check if mobile number is valid
  // (should have a leading '+' followed by 11 digits)
  if (!/^\+[0-9]+$/.test(mobile) || !(mobile.length == 12))
    throw new AppError(401, {}, "Invalid mobile number");

  // check if mobile number already registered
  const user = await User.findOneBy({ mobile });
  if (user) throw new AppError(401, { error: "Mobile already registered" });

  const { result, otp } = await smsOTP(mobile, email);
  if (!result)
    throw new AppError(400, {}, "Couldn't send OTP. Please try again");

  return res.status(200).json({ success: "OTP sent via SMS", otp });
};

/**
 * API Route to verify sms OTP
 */
export const verifySMSOTP = async (req: Request, res: Response) => {
  const { email, mobile, otp } = req.body;
  let errors: any = {};

  if (!isEmpty(email) && !isEmail(email)) errors.email = "Email is invalid";
  if (isEmpty(mobile)) errors.mobile = "Please enter mobile number";
  if (isEmpty(otp)) errors.otp = "Please enter OTP";

  if (Object.keys(errors).length > 0) throw new AppError(401, errors);

  // check if email previously saved in TempUser
  const tempUser = await TempUser.findOneBy({ email });
  if (!tempUser) throw new AppError(401, {}, "Email not recognized");
  if (tempUser.mobile != mobile)
    throw new AppError(401, {}, "New mobile number detected");

  // verify OTP - If 15 minutes has elapsed
  const currentDate = new Date();
  const expiresAt = new Date(tempUser.smsOTPSentAt.getTime() + 15 * 60000);
  if (currentDate > expiresAt)
    throw new AppError(401, {}, "OTP expired. PLease try again");

  if (otp !== tempUser.smsOTP)
    throw new AppError(400, { otp: "OTP is incorrect" });

  // update SMS verification status
  tempUser.mobileStatus = VerificationStatus.VERIFIED;
  const result = await tempUser.save();

  const user = await createUserAccount(result.id);

  const { token, response } = await createUserToken(res, user);

  return response.json({ user, token });
};

/**
 * API route to verify user info (first name, last name, gender)
 */
export const verifyUserInfo = async (req: Request, res: Response) => {
  const { email, firstName, lastName, gender } = req.body;
  let errors: any = {};
  if (!isEmpty(email) && !isEmail(email)) errors.email = "Email is invalid";
  if (isEmpty(firstName)) errors.firstName = "First name cannot be empty";
  if (isEmpty(lastName)) errors.lastName = "Last name cannot be empty";
  if (isEmpty(gender)) errors.gender = "Gender cannot be empty";

  if (Object.keys(errors).length > 0) throw new AppError(401, errors);

  // check if email is already registered
  const registered = await isEmailRegistered(email);
  if (!registered) throw new AppError(401, {}, "Email not registered");

  // save user info in database
  const user = await User.findOneBy({ email });

  user.firstname = firstName;
  user.lastname = lastName;
  user.gender = gender;
  await user.save();

  return res.status(200).json({ success: "User info saved" });
};
