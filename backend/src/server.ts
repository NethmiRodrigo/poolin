import "reflect-metadata";
import "express-async-errors";
import express from "express";
import morgan from "morgan";
import dotenv from "dotenv";
import { AppDataSource } from "./data-source";

import authRoutes from "./routes/auth";

/** Middleware */
import trim from "./middleware/trim";
import { errorLogger, errorResponder } from "./util/error-handler";

dotenv.config();

const app = express();

/** Middleware */
app.use(express.json());
app.use(morgan("dev"));
app.use(trim);

/** API Routes */
app.get("/", (_, res) => res.send("Poolin is up and running"));
app.use("/api/auth", authRoutes);

// Upsteam error handling
app.use(errorLogger);
app.use(errorResponder);

app.listen(process.env.PORT, async () => {
  console.log(`
  ▄███████▄  ▄██████▄   ▄██████▄   ▄█             ▄█   ███▄▄▄▄   
  ███    ███ ███    ███ ███    ███ ███                 ███▀▀▀██▄ 
  ███    ███ ███    ███ ███    ███ ███            ███▌ ███   ███ 
  ███    ███ ███    ███ ███    ███ ███            ███▌ ███   ███ 
▀█████████▀  ███    ███ ███    ███ ███            ███▌ ███   ███ 
  ███        ███    ███ ███    ███ ███            ███  ███   ███ 
  ███        ███    ███ ███    ███ ███▌    ▄      ███  ███   ███ 
 ▄████▀       ▀██████▀   ▀██████▀  █████▄▄██      █▀    ▀█   █▀  
                                   ▀                             
                 🚘 Pool-in server running at http://localhost:5000                                                                                                                                             
  `);
  try {
    await AppDataSource.initialize();
    console.log("Database is connected!");
  } catch (error) {
    console.log(error);
  }
});
