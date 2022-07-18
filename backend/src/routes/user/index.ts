import { Router } from "express";
import auth from "../../middleware/auth";
import { updateInfo, updatePassword } from "./user";

const router = Router();

router.post("/update-info", auth, updateInfo);
router.post("/change-password", auth, updatePassword);

export default router;
