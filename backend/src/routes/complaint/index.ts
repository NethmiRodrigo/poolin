import { Router } from "express";
import { reportUser } from "./complaint";

const router = Router();

router.post("/report-user", reportUser);

export default router;
