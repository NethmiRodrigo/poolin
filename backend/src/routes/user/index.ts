import { Router } from "express";
import { uuid } from "uuidv4";
import auth from "../../middleware/auth";
import { upload } from "../../service/upload-service";
import { updateProfileImage } from "./user";

const router = Router();

router.post(
  "/update-profile-image",
  [auth, upload(`profile-images/${uuid()}`).single("file")],
  updateProfileImage
);

export default router;
