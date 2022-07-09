import { Request, Response, Router } from "express";
import { isEmail, isEmpty } from "class-validator";
import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";
import cookie from "cookie";

import { User } from "../entity/User";
import { AppError } from "../util/error-handler";
import auth from "../middleware/auth";

const login = async (req: Request, res: Response) => {
  const { email, password } = req.body;
  let errors: any = {};
  if (isEmpty(email)) errors.email = "Email cannot be empty";
  if (isEmpty(password)) errors.password = "Password cannot be empty";
  if (!isEmail(email)) errors.email = "Email is invalid";

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

const router = Router();
router.post("/login", login);
router.get("/me", auth, getLoggedInUser);
router.get("/logout", auth, logout);

export default router;
