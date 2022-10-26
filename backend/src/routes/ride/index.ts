import { Router } from "express";

/** Routes */
import {
  getActiveOffer,
  getConfirmedRequests,
  getOfferDetails,
  getOfferRequests,
  postRideOffer,
} from "./offer";
import { getOfferParty, getParty, getRequestParty } from "./party";
import {
  acceptRequest,
  getActiveRequest,
  getAvailableOffers,
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
router.get("/get/matching-requests", getAvailableOffers);

router.get("/party", getParty);
router.get("/get/party/offer/:id", getOfferParty);
router.get("/get/party/request/:id", getRequestParty);

export default router;
