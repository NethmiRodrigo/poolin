import { Router } from "express";
import { createVehicle } from "./create-vehicle";

const router = Router();

router.post("/create", createVehicle);

export default router;
