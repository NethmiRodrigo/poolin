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
  getActiveRequest,
  getAvailableOffers,
  getRequestDetails,
  postRideRequests,
} from "./request";

const router = Router();

router.post("/create-offer", postRideOffer);
router.get("/offer", auth, getActiveOffer);
router.get("/get/offer/:id", auth, getOfferDetails);
router.get("/get/offer/requests/:id", auth, getOfferRequests);
router.get("/get/offer/party/:id", auth, getConfirmedRequests);

router.get("/request", getActiveRequest);
router.post("/post-requests", postRideRequests);
router.get("/get/request/:id", getRequestDetails);
router.get("/get/matching-requests", getAvailableOffers);

export default router;
