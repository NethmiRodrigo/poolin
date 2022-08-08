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
  getRequestDetails,
  postRideRequests,
} from "./request";

const router = Router();

router.post("/create-offer", auth, postRideOffer);
router.get("/offer", auth, getActiveOffer);
router.get("/get/offer/:id", auth, getOfferDetails);
router.get("/get/offer/requests/:id", auth, getOfferRequests);
router.get("/get/offer/party/:id", auth, getConfirmedRequests);

router.get("/request", auth, getActiveRequest);
router.post("/post-requests", auth, postRideRequests);
router.get("/get/request/:id", auth, getRequestDetails);

export default router;
