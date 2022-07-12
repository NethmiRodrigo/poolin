import { NextFunction, Request, Response } from "express";
import jwt from "jsonwebtoken";
import { User } from "../entity/User";
import { AppError } from "../util/error-handler";

export default async (req: Request, res: Response, next: NextFunction) => {
  const token = req.cookies.Token;
  if (!token) throw new AppError(401, {}, "Unauthenticated");
  const { email }: any = jwt.verify(token, process.env.JWT_SECRET);

  const user = await User.findOneBy({ email });
  if (!user) throw new Error("User cannot be found");

  res.locals.user = user;
  return next();
};
