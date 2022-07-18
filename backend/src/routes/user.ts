import { Request, Response, Router } from "express";
import { isEmpty } from "class-validator";
import bcrypt from "bcrypt";

/** Entities */
import { User } from "../database/entity/User";

/** Utility functions */
import { AppError } from "../util/error-handler";

/** Middleware */
import auth from "../middleware/auth";
//import { getLoggedInUser } from "../routes/auth/login";

const updateInfo = async (req: Request, res: Response) => {
  const user: User = res.locals.user;
  
  const { fName, lName, gender, mobile, occupation, dateOfBirth } = req.body;
  let errors: any = {};

  //check for empty fields
  if (isEmpty(fName)) errors.fName = "First name cannot be empty";
  if (isEmpty(lName)) errors.lName = "Last name cannot be empty";
  if (isEmpty(gender)) errors.gender = "Gender cannot be empty";

  //Throws an error if any of the fields are empty
  if (Object.keys(errors).length > 0) throw new AppError(401, errors, "");

  // remove all non-numeric characters except '+'
  //const phone = mobile.replace(/[^\+0-9]/ig, "");

  // check if mobile number is valid
  // (should have a leading '+' followed by 11 digits)
  //if (!(/^\+[0-9]+$/.test(phone)) || !(phone.length == 12)) throw new AppError(401, {}, "Invalid mobile number");

  user.firstname = fName;
  user.lastname = lName;
  user.gender = gender;

  await user.save();

  return res.status(200).json({ success: "User updated", user });
};

const updatePassword = async (req: Request, res: Response) => {
  const user: User = res.locals.user;

  const { password, newPassword, confirmPassword } = req.body;

  let errors: any = {};

  //check for empty fields
  if (isEmpty(password)) errors.password = "Current password cannot be empty";
  if (isEmpty(newPassword)) errors.newPassword = "New password cannot be empty";
  if (isEmpty(confirmPassword)) errors.confirmPassword = "Confirm password cannot be empty";

  if (Object.keys(errors).length > 0) throw new AppError(401, errors, "");

  const passwordMatched = await bcrypt.compare(password, user.password);
  if (!passwordMatched) throw new AppError(401, {}, "Incorrect credentials");

  if (newPassword !== confirmPassword)
    throw new AppError(401, {}, "Passwords do not match");

  const hash = await bcrypt.hash(newPassword,10);
  user.password = hash;
  await user.save();

  return res.status(200).json({ success: "Password successfully updated" });
};

const updateMobile = async (req: Request, res: Response) => {
  let {mobile} = req.body;
  let errors: any = {};

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

  // const { result, otp } = await smsOTPAtSignup(mobile);
  // if (!result)
  //   throw new AppError(400, {}, "Couldn't send OTP. Please try again");

  // return res.status(200).json({ success: "OTP sent via SMS", otp });

}

const router = Router();

//router.get("/me", auth, getLoggedInUser);
router.post("/updateInfo", auth, updateInfo);
router.post("/updatePassword", auth, updatePassword);
router.post("/updateMobile", auth, updateMobile);

export default router;
