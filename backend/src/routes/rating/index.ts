import { Router } from "express";
import { rateUser } from "./rating";

const router = Router();

router.post("/rate-user", rateUser);

export default router;
