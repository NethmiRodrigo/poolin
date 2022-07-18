import { Router } from "express";
import auth from "../../middleware/auth";
import { updateInfo, updateMobile, updatePassword } from "./user";

const router = Router();

router.post("/update-info", auth, updateInfo);
router.post("/change-password", auth, updatePassword);
router.post("update-mobile", updateMobile);

export default router;
