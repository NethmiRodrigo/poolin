import { AppDataSource } from "./data-source";
import express, { Response } from "express";
import morgan from "morgan";

import authRoutes from "./routes/auth";

const app = express();

app.use(express.json());
app.use(morgan("dev"));

/** Routes */
app.get("/", (_, res: Response) =>
  res.send("Poolin backend is up and running")
);
app.use("/api/auth", authRoutes);

app.listen(5000, async () => {
  console.log("Poolin server is running at http://localhost:5000");
  try {
    await AppDataSource.initialize();
    console.log("Database is connected!");
  } catch (error) {
    console.log(error);
  }
});
