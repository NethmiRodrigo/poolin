import { Request, Response } from "express";

/** Utility functions */
import { AppError } from "../../util/error-handler";
import { isEmpty } from "class-validator";
import { Complaint } from "../../database/entity/Complaint";

export const reportUser = async (req: Request, res: Response) => {
  const { complaint, complaintFor, complaintBy, tripId } = req.body;
  if (isEmpty(complaint))
    throw new AppError(401, { complaint: "Complaint cannot be empty" });
  if (isEmpty(complaintFor))
    throw new AppError(401, {
      complaintFor: "Complainee cannot be empty",
    });
  if (isEmpty(complaintBy))
    throw new AppError(401, {
      complaintBy: "Complainer cannot be empty",
    });

  if (isEmpty(tripId))
    throw new AppError(401, { tripId: "Trip id cannot be empty" });

  const complaintEntity = new Complaint();
  complaintEntity.description = complaint;
  complaintEntity.complainee = complaintFor;
  complaintEntity.complainer = complaintBy;
  complaintEntity.tripId = tripId;
  await complaintEntity.save();

  return res.status(200).json({ success: "Complaint successfully added" });
};
