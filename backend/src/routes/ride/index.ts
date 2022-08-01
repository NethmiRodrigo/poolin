import { Router } from "express";
import { v4 } from "uuid";

/** Middleware */
import auth from "../../middleware/auth";

/** Utils */
import { upload } from "../../service/upload-service";

/** Routes */
import {
  getConfirmedRequests,
  getOfferDetails,
  getOfferRequests,
  postRideOffer,
} from "./offer";
import { postRideRequests } from "./request";

const router = Router();

router.post("/create-offer", postRideOffer);
router.post("/post-requests", postRideRequests);
router.get("/get/offer/:id", getOfferDetails);
router.get("/get/offer/requests/:id", getOfferRequests);
router.get("/get/offer/party/:id", getConfirmedRequests);
export default router;
