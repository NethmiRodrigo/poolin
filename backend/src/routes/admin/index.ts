import { Router } from "express";

/** Routes */
import { createEmailFormat } from "./email-format";

const router = Router();
router.post("/create-email-format", createEmailFormat);

export default router;
