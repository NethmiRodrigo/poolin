import { Router } from "express";

/** Routes */
import { createEmailFormat } from "./email-format";
import { toggleVerification } from "./manage-user";
import { fetchAllUsers } from "./manage-user";

const router = Router();
router.post("/create-email-format", createEmailFormat);
router.get("/toggle-verification/:id/:verified", toggleVerification);
router.get("/get-all-users", fetchAllUsers);

export default router;
