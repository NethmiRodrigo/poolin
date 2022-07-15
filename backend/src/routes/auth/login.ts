import { Request, Response } from "express";
import { isEmail, isEmpty } from "class-validator";
import bcrypt from "bcrypt";
import cookie from "cookie";

/** Entities */
import { User } from "../../database/entity/User";

/** Utility functions */
import { AppError } from "../../util/error-handler";
import { createUserToken } from "../../util/auth-helper";

/**
 * Login API Route
 */
export const login = async (req: Request, res: Response) => {
  const { email, password } = req.body;
  let errors: any = {};
  if (isEmpty(email)) errors.email = "Email cannot be empty";
  if (isEmpty(password)) errors.password = "Password cannot be empty";
  if (!isEmpty(email) && !isEmail(email)) errors.email = "Email is invalid";

  if (Object.keys(errors).length > 0) throw new AppError(400, errors, "");

  const user = await User.findOneBy({ email });
  if (!user) throw new AppError(401, { error: "User not found" });

  const passwordMatched = await bcrypt.compare(password, user.password);
  if (!passwordMatched)
    throw new AppError(401, { error: "Incorrect credentials" });

  const { token, response } = await createUserToken(res, user);

  return response.json({ user, token });
};

/**
 * API Route to log the user out
 */
export const logout = async (_: Request, res: Response) => {
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
 * API Route to get the logged in user details
 */
export const getLoggedInUser = async (_: Request, res: Response) => {
  return res.json(res.locals.user);
};
