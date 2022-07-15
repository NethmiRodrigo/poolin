import { Request, Response, Router } from "express";
import { isEmpty } from "class-validator";
import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";
import cookie from "cookie";

import { User } from "../entity/User";
import { AppError } from "../util/error-handler";
import auth from "../middleware/auth";

const updateInfo = async (req: Request, res: Response) => {
  
  const user : User = res.locals.user;

  const { fName, lName, gender, mobile, occupation, dateOfBirth } = req.body;
  let errors: any = {};
  
  //check for empty fields
  if (isEmpty(fName)) errors.fName = "First name cannot be empty";
  if (isEmpty(lName)) errors.lName = "Last name cannot be empty";
  if (isEmpty(gender)) errors.gender = "Gender cannot be empty";
  // if (isEmpty(mobile)) errors.mobile = "Mobile number cannot be empty";
  // if (isEmpty(occupation)) errors.occupation = "Occupation status cannot be empty";

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
  // user.mobile = phone;
  // user.occupation = occupation;
  // user.dateOfBirth = dateOfBirth;

  await user.save();

  return res.status(200).json({ success: "User updated" });

};

const updatePassword = async (req: Request, res: Response) => {
  const user : User = res.locals.user;

  const { password, newPassword, confirmPassword } = req.body;

  let errors: any = {};
  
  //check for empty fields
  if (isEmpty(password)) errors.password = "Current password cannot be empty";
  if (isEmpty(newPassword)) errors.newPassword = "New password cannot be empty";
  if (isEmpty(confirmPassword)) errors.confirmPassword = "Confirm password cannot be empty";

  if (Object.keys(errors).length > 0) throw new AppError(401, errors, "");

  const passwordMatched = await bcrypt.compare(password, user.password);
  if (!passwordMatched) throw new AppError(401, {}, "Incorrect credentials");

  if (newPassword !== confirmPassword) throw new AppError(401, {}, "Passwords do not match");

  user.password = newPassword;
  await user.save();

  
  return res.status(200).json({ success: "Password successfully updated" });
}

const router = Router();

router.post("/updateInfo", auth, updateInfo);
router.post("/updatePassword", auth, updatePassword);

export default router;
