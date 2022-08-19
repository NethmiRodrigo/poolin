import { Router } from "express";
import { createNode, createUser } from "./user";

const router = Router();

router.post("/create/user", createUser);
router.post("/create/node", createNode);

export default router;
