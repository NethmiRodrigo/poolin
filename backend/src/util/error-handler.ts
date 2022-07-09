import { Request, Response, NextFunction } from "express";

/*
Utility function to log errors thrown from any endpoint
*/
export const errorLogger = (error, request, response, next) => {
  console.log(`❌ [ERROR] [${error.statusCode || 500}] - ${error.message}`);

  /* Log full stack trace [comment out to reduce clutter] */
  // console.log(error);

  next(error);
};

/*
Utility function to handle errors thrown from any endpoint
*/
export const errorResponder = (
  error: any,
  request: Request,
  response: Response,
  next: NextFunction
) => {
  response.header("Content-Type", "application/json");

  const status = error.statusCode || 500;
  response.status(status).json({
    message: error.message || undefined,
    error: Object.keys(error.complexObject || {}).length
      ? error.complexObject
      : undefined,
  });
};

/*
Utility class to carry errors upstream.
*/
export class AppError extends Error {
  statusCode: number;
  complexObject: any;

  constructor(statusCode: number, complex?: any, message?: string) {
    super(message);

    Object.setPrototypeOf(this, new.target.prototype);
    this.name = Error.name;
    this.statusCode = statusCode;
    this.complexObject = complex;
    Error.captureStackTrace(this);
  }
}
