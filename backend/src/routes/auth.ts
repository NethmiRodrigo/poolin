import { Request, Response, Router } from "express";

const login = async (req: Request, res: Response) => {};

const router = Router();
router.post("/login", login);

export default router;
