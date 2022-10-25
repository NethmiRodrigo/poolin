import { Router } from "express";
import { fetchAllComplaint } from "./complaints";
import { fetchTotalIncome } from "./payments";

//import { blockUser } from "./complaints";

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
//router.post("/block-user", blockUser);

export default router;
