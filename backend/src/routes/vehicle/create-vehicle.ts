import { Request, Response } from "express";
import { isEmpty, isNumber } from "class-validator";

/** Entities */
import { User } from "../../database/entity/User";

/** Utility functions */
import { AppError } from "../../util/error-handler";
import { Type, Vehicle } from "../../database/entity/Vehicle";

/**
 * Create vehicle API Route
 */
export const createVehicle = async (req: Request, res: Response) => {
  const { numberPlate, numberOfSeats, ownerId, type } = req.body;
  let errors: any = {};
  if (isEmpty(numberPlate)) errors.numberPlate = "Number plate cannot be empty";
  if (!isNumber(numberOfSeats))
    errors.numberOfSeats = "Number of seats required";
  if (!(type && Object.values(Type).includes(type)))
    errors.type = "Valid type required";

  if (Object.keys(errors).length > 0) throw new AppError(400, errors, "");

  const user = await User.findOneBy({ id: ownerId });
  if (!user) throw new AppError(404, { user: "User not found" });

  const vehicle = Vehicle.create({
    numberPlate,
    numberOfSeats,
    owner: user,
    type: type,
  });

  await vehicle.save();

  return res.status(201).json({ vehicle });
};
