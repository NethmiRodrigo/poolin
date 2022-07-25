import { Router } from "express";
import { uuid } from "uuidv4";

/** Middleware */
import auth from "../../middleware/auth";

/** Utils */
import { upload } from "../../service/upload-service";

/** Routes */
import {
  updateInfo,
  updateMobile,
  updatePassword,
  updateProfileImage,
  verifyUpdateMobile,
} from "./user";

const router = Router();

router.post("/update-info", auth, updateInfo);
router.post("/change-password", auth, updatePassword);
router.post("/update-mobile", auth, updateMobile);
router.post("/verify-updated-mobile", auth, verifyUpdateMobile);
router.post(
  "/update-profile-image",
  [auth, upload(`profile-images/${uuid()}`).single("file")],
  updateProfileImage
);

export default router;
