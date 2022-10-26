import { Router } from "express";
import {  fetchTotalsale, } from "./dashboard";

const router = Router();


router.get("/", fetchTotalsale);

// router.post("/report-user", reportUser);

export default router;
