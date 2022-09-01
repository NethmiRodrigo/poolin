import { Router } from "express";
import { addFriends, getCloseFriends } from "./manage-friends";

const router = Router();

router.post("/add", addFriends);
router.get("/get/:level", getCloseFriends);

export default router;
