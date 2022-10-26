import { Router } from "express";
import { fetchTotalIncome, fetchTotalSale, getAllPayments } from "./payment";

const router = Router();

router.get("/", getAllPayments);
router.get("/total-income", fetchTotalIncome);
router.get("/total-sale", fetchTotalSale);
// router.post("/report-user", reportUser);

export default router;
