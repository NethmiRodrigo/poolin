import "reflect-metadata";
import express from "express";
import morgan from "morgan";
import dotenv from "dotenv";
import { AppDataSource } from "./data-source";

import authRoutes from "./routes/auth";

import trim from "./middleware/trim";

dotenv.config();

const app = express();

app.use(express.json());
app.use(morgan("dev"));
app.use(trim);

app.get("/", (_, res) => res.send("Poolin is up and running"));
app.use("/api/auth", authRoutes);

app.listen(process.env.POT, async () => {
  console.log("Poolin server is running at http://localhost:5000");
  try {
    await AppDataSource.initialize();
    console.log("Database is connected!");
  } catch (error) {
    console.log(error);
  }
});
