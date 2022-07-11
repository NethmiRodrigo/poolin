import { Request, Response, Router } from "express";
import { isEmpty } from "class-validator";
import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";
import cookie from "cookie";

import { User } from "../entity/User";
import { EmailFormat } from "../entity/EmailFormat";
import { AppError } from "../util/error-handler";

const login = async (req: Request, res: Response) => {
  const { email, password } = req.body;
  let errors: any = {};
  if (isEmpty(email)) errors.email = "Email cannot be empty";
  if (isEmpty(password)) errors.password = "Password cannot be empty";

  if (Object.keys(errors).length > 0) throw new AppError(401, errors, "");

  const user = await User.findOneBy({ email });
  if (!user) throw new AppError(401, {}, "User not found");

  const passwordMatched = await bcrypt.compare(password, user.password);
  if (!passwordMatched) throw new AppError(401, {}, "Incorrect credentials");

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

const verifyCredentials = async (req: Request, res: Response) => {
  const { email, password, confirmPassword } = req.body;
  let errors: any = {};
  if (isEmpty(email)) errors.email = "Email cannot be empty";
  if (isEmpty(password)) errors.password = "Password cannot be empty";
  if (isEmpty(confirmPassword)) errors.confirmPassword = "Confirm password cannot be empty";

  if (Object.keys(errors).length > 0) throw new AppError(401, errors, "");

  // check if passwords match
  if(password != confirmPassword) throw new AppError(401, {}, "Passwords do not match");

  // check password strength
  if(password.length < 8) throw new AppError(401, {}, "Password too short");

  // check if email already registered
  const user = await User.findOneBy({ email });

  if (user) throw new AppError(401, {}, "Email already registered");

  // check if email belongs to supported domain
  const validEmailFormats = await EmailFormat.find({select: { emailFormat: true }});

  let isValid = false;

  for(let i=0; i<validEmailFormats.length; i++) {
    if(email.toLowerCase().endsWith(validEmailFormats[i].emailFormat.toLowerCase())) {
      isValid = true;
      break;
    }
  }

  if(!isValid) throw new AppError(401, {}, "Invalid email");

  return res.json({ });
};

const router = Router();
router.post("/login", login);
router.post("/verifyCredentials", verifyCredentials);

export default router;
