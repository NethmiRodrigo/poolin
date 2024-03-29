import { NextFunction, Request, Response } from "express";
import jwt from "jsonwebtoken";
import { User } from "../database/entity/User";
import { AppError } from "../util/error-handler";

export default async (req: Request, res: Response, next: NextFunction) => {
  if (!req.headers.cookie) throw new AppError(401, {}, "Unauthenticated");
  const token: string = req.headers.cookie.split("=")[1];
  const decodedToken: any = jwt.verify(token, process.env.JWT_SECRET);
  const user = await User.findOneBy({ email: decodedToken.user.email });
  if (!user) throw new Error("User cannot be found");

  res.locals.user = user;
  return next();
};
