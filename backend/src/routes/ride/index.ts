import { Router } from "express";

/** Middleware */
import auth from "../../middleware/auth";

/** Routes */
import {
  getActiveOffer,
  getConfirmedRequests,
  getOfferDetails,
  getOfferRequests,
  postRideOffer,
} from "./offer";
import {
  acceptRequest,
  getActiveRequest,
  getRequestDetails,
  postRideRequests,
} from "./request";

const router = Router();

router.post("/create-offer", postRideOffer);
router.get("/offer", getActiveOffer);
router.get("/get/offer/:id", getOfferDetails);
router.get("/get/offer/requests/:id", getOfferRequests);
router.get("/get/offer/party/:id", getConfirmedRequests);

router.get("/request", getActiveRequest);
router.post("/post-requests", postRideRequests);
router.get("/get/request/:id", getRequestDetails);
router.post("/request/accept", acceptRequest);

export default router;
