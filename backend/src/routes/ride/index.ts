import { Router } from "express";
import { v4 } from "uuid";

/** Middleware */
import auth from "../../middleware/auth";

/** Utils */
import { upload } from "../../service/upload-service";

/** Routes */
import { getOfferDetails, postRideOffer } from "./offer";
import { postRideRequests } from "./request";

const router = Router();

router.post("/create-offer", postRideOffer);
router.post("/post-requests", postRideRequests);
router.get("/get/:id", getOfferDetails);

export default router;
