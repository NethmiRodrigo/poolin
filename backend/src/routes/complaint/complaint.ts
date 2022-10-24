import { Request, Response } from "express";

/** Utility functions */
import { AppError } from "../../util/error-handler";
import { isEmpty } from "class-validator";
import { Complaint } from "../../database/entity/Complaint";
import { User } from "../../database/entity/User";

export const reportUser = async (req: Request, res: Response) => {
  const { complaint, complaintForUserId, complaintByUserId, tripId } = req.body;

  if (isEmpty(complaint))
    throw new AppError(401, { complaint: "Complaint cannot be empty" });
  if (isEmpty(complaintForUserId))
    throw new AppError(401, {
      complaintFor: "Complainee cannot be empty",
    });
  if (isEmpty(complaintByUserId))
    throw new AppError(401, {
      complaintBy: "Complainer cannot be empty",
    });

  if (isEmpty(tripId))
    throw new AppError(401, { tripId: "Trip id cannot be empty" });

  const userMakingComplaint = await User.findOneBy({ id: complaintByUserId });

  if (!userMakingComplaint) throw new AppError(500, {}, "Wrong parameters");

  const userBeingComplainedAbout = await User.findOneBy({
    id: complaintForUserId,
  });

  if (!userBeingComplainedAbout)
    throw new AppError(500, {}, "Wrong parameters");

  const complaintEntity = new Complaint();
  complaintEntity.description = complaint;
  complaintEntity.complainee = userMakingComplaint;
  complaintEntity.complainer = userBeingComplainedAbout;
  complaintEntity.tripId = tripId;
  await complaintEntity.save();

  return res.status(200).json({ success: "Complaint successfully added" });
};

export const getAllComplaints = async (_, res: Response) => {
  const response = await Complaint.find({
    relations: { complainee: true, complainer: true },
  });
  return res.status(200).json(response);
};
