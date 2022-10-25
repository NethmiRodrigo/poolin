import { Router } from "express";
import { fetchAllComplaint } from "./complaints";
import { blockUser } from "./complaints";

/** Routes */
import { createEmailFormat } from "./email-format";
import { toggleVerification } from "./manage-user";
import { fetchAllUsers } from "./manage-user";

const router = Router();
router.post("/create-email-format", createEmailFormat);
router.get("/toggle-verification/:id/:verified", toggleVerification);
router.get("/get-all-users", fetchAllUsers);
router.get("/get-all-complaints", fetchAllComplaint);
router.post("/block-user", blockUser);

export default router;
