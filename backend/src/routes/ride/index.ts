import { Router } from "express";
import { v4 } from "uuid";

/** Middleware */
import auth from "../../middleware/auth";

/** Utils */
import { upload } from "../../service/upload-service";

/** Routes */
import { postRideOffer } from "./offer";

const router = Router();

router.post("/create-offer", postRideOffer);

export default router;
