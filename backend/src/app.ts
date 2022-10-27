import "reflect-metadata";
import "express-async-errors";
import express from "express";
import morgan from "morgan";
import cookieParser from "cookie-parser";
import http from "http";
import dotenv from "dotenv";
import cors from "cors";
import compression from "compression";

/** Routes */
import authRoutes from "./routes/auth/index";
import userRoutes from "./routes/user/index";
import adminRoutes from "./routes/admin/index";
import rideRoutes from "./routes/ride/index";
import devRoutes from "./routes/dev/index";
import friendRoutes from "./routes/friends/index";
import ratingRoutes from "./routes/rating/index";
import complaintRoutes from "./routes/complaint/index";
import paymentRoutes from "./routes/payment/index";
import saleRoutes from "./routes/dashboard/index";

/** Middleware */
import trim from "./middleware/trim";
import notEmpty from "./middleware/not-empty";
import { errorLogger, errorResponder } from "./util/error-handler";
import forRole from "./middleware/for-role";
import auth from "./middleware/auth";

/** Constants */
import { Role } from "./database/entity/User";

const app = express();
dotenv.config();

/** Middleware */
app.use(cors());
app.use(compression());
app.use(express.json());
app.use(morgan("dev"));
app.use(trim);
app.use(notEmpty);
app.use(cookieParser());

/** API Routes */
app.get("/", (_, res) => res.send("Poolin is up and running"));
app.use("/api/auth", authRoutes);
app.use("/api/user", auth, userRoutes);
app.use("/api/admin", adminRoutes);
app.use("/api/ride", auth, rideRoutes);
app.use("/api/dev", devRoutes);
app.use("/api/friends", auth, friendRoutes);
app.use("/api/rate", auth, ratingRoutes);

app.use("/api/complaints", complaintRoutes);
app.use("/api/payments", paymentRoutes);
app.use("/api/payments/total-income", paymentRoutes);
app.use("/api/payments/total-sale", paymentRoutes);
app.use("/api/dashboard/total-sale", saleRoutes);

// Upstream error handling
if (process.env.NODE_ENV === "development") app.use(errorLogger);
app.use(errorResponder);

export default http.createServer(app);
