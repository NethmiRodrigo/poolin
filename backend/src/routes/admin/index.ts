import { Router } from "express";
import { fetchAllComplaint } from "./complaints";
import { fetchTotalIncome } from "./payments";
import { fetchTotalPayabaleWeek } from "./payments";
import { fetchTotalProfit } from "./payments";
import { fetchAllPayments } from "./payments";
// import { blacklist } from "./complaints";

/** Routes */
import { createEmailFormat } from "./email-format";
import { toggleVerification } from "./manage-user";
import { fetchAllUsers } from "./manage-user";


const router = Router();
router.post("/create-email-format", createEmailFormat);
router.get("/toggle-verification/:id/:verified", toggleVerification);
router.get("/get-all-users", fetchAllUsers);
router.get("/get-all-complaints", fetchAllComplaint);
router.get("/total-income", fetchTotalIncome);
router.get("/total-payable", fetchTotalPayabaleWeek);
router.get("/total-profit", fetchTotalProfit);
router.get("/all-payments", fetchAllPayments);


// router.post("/blacklist-user", blacklist);

export default router;
