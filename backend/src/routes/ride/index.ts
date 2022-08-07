import { Router } from "express";

/** Routes */
import {
  getConfirmedRequests,
  getOfferDetails,
  getOfferRequests,
  postRideOffer,
} from "./offer";
import { getRequestDetails, postRideRequests } from "./request";

const router = Router();

router.post("/create-offer", postRideOffer);
router.get("/get/offer/:id", getOfferDetails);
router.get("/get/offer/requests/:id", getOfferRequests);
router.get("/get/offer/party/:id", getConfirmedRequests);

router.post("/post-requests", postRideRequests);
router.get("/get/request/:id", getRequestDetails);

export default router;