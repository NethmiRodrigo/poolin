import { NextFunction, Request, Response } from "express";
import { AppError } from "../util/error-handler";

export default (req: Request, _: Response, next: NextFunction) => {
  //Throw error if params in body is empty
  Object.keys(req.body).forEach((key) => {
    if (
      req.body[key] == null ||
      (typeof req.body[key] === "string" && req.body[key].length <= 0)
    )
      throw new AppError(400, { [key]: `${key} param is empty` });
  });

  next();
};
