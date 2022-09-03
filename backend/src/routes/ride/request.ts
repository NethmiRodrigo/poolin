import { Request, Response } from "express";

/** Entities */
import { RideOffer } from "../../database/entity/RideOffer";
import { RideRequest } from "../../database/entity/RideRequest";
import { User } from "../../database/entity/User";
import { RequestToOffer } from "../../database/entity/RequestToOffer";
import { AppDataSource } from "../../data-source";
import { AppError } from "../../util/error-handler";

export const postRideRequests = async (req: Request, res: Response) => {
  const { email, offers, src, dest, startTime, window, distance, price } =
    req.body;

  const user = await User.findOne({ where: { email } });

  const newRequest = new RideRequest({
    user: user,

    from: src.name,
    fromGeom: {
      type: "Point",
      coordinates: [src.lat, src.long],
    },
    to: dest.name,
    toGeom: {
      type: "Point",
      coordinates: [dest.lat, dest.long],
    },
    departureTime: startTime,
    timeWindow: window,

    distance: distance,
  });

  await newRequest.save();

  offers.forEach(async (id) => {
    const rideOffer = await RideOffer.findOne({ where: { id } });
    const requestToOffer = new RequestToOffer({
      request: newRequest,
      offer: rideOffer,
      price: price ? price : rideOffer.pricePerKm * distance,
    });
    await requestToOffer.save();
  });

  return res.status(200).json({ success: "Ride Requests posted successfully" });
};

export const getActiveRequest = async (req: Request, res: Response) => {
  const email = req.query.email;

  const user = await User.findOne({ where: { email: email as string } });

  if (!user) {
    return res.status(404).json({ error: "User not found" });
  }

  const request = await RideRequest.createQueryBuilder("request")
    .where("request.status='confirmed'")
    .leftJoinAndSelect("request.user", "user")
    .where("user.email = :email", { email: email as string })
    .select(["request.id AS id"])
    .getRawOne();

  if (!request) {
    return res.status(404).json({ error: "No active request" });
  }

  return res
    .status(200)
    .json({ success: "Ride Offer fetched successfully", request });
};

export const getRequestDetails = async (req: Request, res: Response) => {
  const { id } = req.params;

  const request = await RideRequest.createQueryBuilder("request")
    //join happens as property of parent
    .leftJoinAndSelect("request.requestToOffers", "rto")
    .where("request.id = :id", { id: +id })
    .leftJoinAndSelect("request.user", "user")
    .select([
      "user.firstname AS fname",
      "user.lastname AS lname",
      "user.id AS id",
      "user.profileImageUri as avatar",
      "request.from AS pickup",
      "request.to AS dropOff",
      "request.departureTime AS startTime",
      "request.updatedAt AS updatedAt",
      "rto.price AS price",
    ])
    .getRawOne();

  return res
    .status(200)
    .json({ success: "Ride Request fetched successfully", request });
};

export const acceptRequest = async (req: Request, res: Response) => {
  const { request, offer } = req.body;

  const requestRepository = AppDataSource.getRepository(RequestToOffer);

  const response = await requestRepository.findOne({
    relations: { request: true, offer: true },
    where: { request: { id: request }, offer: { id: offer } },
  });

  if (!response) throw new AppError(500, { error: "Could not find request" });

  if (response) {
    response.isAccepted = true;
    await response.save();

    const offerObj: RideOffer = await RideOffer.findOne({
      where: { id: offer },
    });
    if (offerObj.seats <= 0)
      throw new AppError(500, { error: "Seats are all full" });
    offerObj.seats = offerObj.seats - 1;
    offerObj.save();

    const requestObject: RideRequest = await RideRequest.findOne({
      where: { id: request },
    });
    requestObject.status = "confirmed";
    await requestObject.save();
  }

  return res.status(200).json({ message: "Request accepted successfully" });
};
