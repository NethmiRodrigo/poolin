import { Router } from "express";
import { createUser } from "./user";

const router = Router();

router.post("/create/user", createUser);

export default router;
