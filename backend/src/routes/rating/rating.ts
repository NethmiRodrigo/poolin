import { Request, Response } from "express";
import { Rating } from "../../database/entity/Rating";
/** Utility functions */
import { AppError } from "../../util/error-handler";
import { isEmpty } from "class-validator";
import { User } from "../../database/entity/User";

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

export const getTotalRatings = async (req: Request, res: Response) => {
  const { id } = req.params;
  const role = req.query.role as string;
  // const ratings = await Rating.find({
  //   where: { ratingFor: id },

  // });
  const user = await Rating.createQueryBuilder("rating")
    .where("rating.ratingFor = :id", {
      id,
    })
    .andWhere("rating.ratedAs = :role", {
      role,
    })
    .select(
      "ROUND(AVG(rating.rating),1) as averageRating, COUNT(rating.rating) as totalRatings"
    )
    .getRawOne();

  return res.status(200).json({ ratings: user });
};

// export const getTripRatings = async (req: Request, res: Response) => {
//   const { id } = req.params;
//   const ratings = await Rating.find({
//     where: { ratingFor: id },
//     relations: ["ratingBy"],
//   });
//   return res.status(200).json({ ratings });
// };
