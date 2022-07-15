import "reflect-metadata";
import "express-async-errors";
import express from "express";
import morgan from "morgan";
import dotenv from "dotenv";
import cookieParser from "cookie-parser";
import { AppDataSource } from "./data-source";

import authRoutes from "./routes/auth";
import userRoutes from "./routes/user";

/** Middleware */
import trim from "./middleware/trim";
import { errorLogger, errorResponder } from "./util/error-handler";
import { User } from "./entity/User";

dotenv.config();

const app = express();

/** Middleware */
app.use(express.json());
app.use(morgan("dev"));
app.use(trim);
app.use(cookieParser());

/** API Routes */
app.get("/", (_, res) => res.send("Poolin is up and running"));
app.use("/api/auth", authRoutes);
app.use("/api/auth", userRoutes);

// Upstream error handling
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
                 🚘 Pool-in server running at https://localhost:5000                                                                                                                                             
  `);
  try {
    await AppDataSource.initialize();
    console.log("Database is connected!");
    
  } catch (error) {
    console.log(error);
  }
});
