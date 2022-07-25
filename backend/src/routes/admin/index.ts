import { Router } from "express";

/** Routes */
import { createEmailFormat } from "./email-format";
import { toggleVerification } from "./manage-user";

const router = Router();
router.post("/create-email-format", createEmailFormat);
router.get("/toggle-verification/:id/:verified", toggleVerification);

export default router;
