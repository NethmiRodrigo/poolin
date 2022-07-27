import { Router } from "express";
import { v4 } from "uuid";

/** Middleware */
import auth from "../../middleware/auth";

/** Utils */
import { upload } from "../../service/upload-service";

/** Routes */
import {
  getUser,
  updateInfo,
  updateMobile,
  updatePassword,
  updateProfileImage,
  verifyUpdateMobile,
} from "./user";

const router = Router();

router.get("/get/:id", getUser);
router.post("/update-info", auth, updateInfo);
router.post("/change-password", auth, updatePassword);
router.post("/update-mobile", auth, updateMobile);
router.post("/verify-updated-mobile", auth, verifyUpdateMobile);
router.post(
  "/update-profile-image",
  [auth, upload(`profile-images/${v4()}`).single("file")],
  updateProfileImage
);

export default router;
