import { Request, Response } from "express";
import { Rating } from "../../database/entity/Rating";
/** Utility functions */
import { AppError } from "../../util/error-handler";
import { isEmpty } from "class-validator";

export const rateUser = async (req: Request, res: Response) => {
  const { rating, ratingFor, ratingBy, role, tripId } = req.body;
  if (isEmpty(rating))
    throw new AppError(401, { rating: "Rating cannot be empty" });
  if (isEmpty(ratingFor))
    throw new AppError(401, { ratingFor: "Rated party for cannot be empty" });
  if (isEmpty(ratingBy))
    throw new AppError(401, { ratingBy: "Rating party by cannot be empty" });
  if (isEmpty(role)) throw new AppError(401, { role: "Role cannot be empty" });
  if (isEmpty(tripId))
    throw new AppError(401, { tripId: "Trip id cannot be empty" });

  const ratingEntity = new Rating();
  ratingEntity.rating = rating;
  ratingEntity.ratingFor = ratingFor;
  ratingEntity.ratingBy = ratingBy;
  ratingEntity.ratedAs = role;
  ratingEntity.tripId = tripId;
  await ratingEntity.save();

  return res.status(200).json({ success: "Rating successfully added" });
};
