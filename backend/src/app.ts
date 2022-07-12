import "reflect-metadata";
import "express-async-errors";
import express from "express";
import morgan from "morgan";
import cookieParser from "cookie-parser";
import http from "http";

import authRoutes from "./routes/auth";

/** Middleware */
import trim from "./middleware/trim";
import { errorLogger, errorResponder } from "./util/error-handler";

const app = express();

/** Middleware */
app.use(express.json());
app.use(morgan("dev"));
app.use(trim);
app.use(cookieParser());

/** API Routes */
app.get("/", (_, res) => res.send("Poolin is up and running"));
app.use("/api/auth", authRoutes);

// Upstream error handling
app.use(errorLogger);
app.use(errorResponder);

export default http.createServer(app);
