import { Router } from "express";



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
router.get("/offer", getActiveOffer);
router.get("/get/offer/:id", getOfferDetails);
router.get("/get/offer/requests/:id", getOfferRequests);
router.get("/get/offer/party/:id", getConfirmedRequests);

router.get("/request", getActiveRequest);
router.post("/post-requests", postRideRequests);
router.get("/get/request/:id", getRequestDetails);
router.get("/get/matching-requests", getAvailableOffers);


export default router;
