import { Router } from "express";
import { getAllComplaints, reportUser } from "./complaint";

const router = Router();

router.get("/", getAllComplaints);
router.post("/report-user", reportUser);

export default router;
