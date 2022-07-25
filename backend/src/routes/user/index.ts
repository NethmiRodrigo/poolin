import { Router } from "express";
<<<<<<< HEAD
import auth from "../../middleware/auth";
import { updateInfo, updateMobile, updatePassword } from "./user";

const router = Router();

router.post("/update-info", auth, updateInfo);
router.post("/change-password", auth, updatePassword);
router.post("update-mobile", updateMobile);
=======
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
>>>>>>> 314cf590095363b66ab9944dce7b7cea29cf062b

export default router;
