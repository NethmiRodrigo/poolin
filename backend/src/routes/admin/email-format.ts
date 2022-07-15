import { isEmpty } from "class-validator";
import { Request, Response } from "express";
import { EmailFormat } from "../../database/entity/EmailFormat";
import { AppError } from "../../util/error-handler";

/**
 * Add Email Format API Route
 */
export const createEmailFormat = async (
  request: Request,
  response: Response
) => {
  const { emailFormat } = request.body;
  if (isEmpty(emailFormat))
    throw new AppError(400, { emailFormat: "Cannot be empty" }, "");

  const format = await EmailFormat.findOneBy({ emailFormat });
  if (format)
    throw new AppError(400, { emailFormat: "Format already exists" }, "");

  await EmailFormat.create({ emailFormat }).save();

  return response.status(200).json({ message: "Format successfully created" });
};
