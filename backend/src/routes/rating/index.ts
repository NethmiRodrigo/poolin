import { Router } from "express";
import { getTotalRatings, rateUser } from "./rating";

const router = Router();

router.post("/rate-user", rateUser);
router.get("/ratings/:id", getTotalRatings);
export default router;
