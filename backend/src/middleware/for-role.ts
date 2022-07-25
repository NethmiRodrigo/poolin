import { NextFunction, Request, Response } from "express";
import { Role, User } from "../database/entity/User";
import { AppError } from "../util/error-handler";

export default (roles: Role[]) =>
  async (_: Request, res: Response, next: NextFunction) => {
    const user: User = res.locals.user;
    if (!user || !roles.includes(user.role))
      throw new AppError(
        401,
        { error: `Requires role ${roles}` },
        "Unauthorized"
      );

    return next();
  };
