import "reflect-metadata";
import { DataSource } from "typeorm";
import dotenv from "dotenv";
import neo4j from "neo4j-driver";

import { ForgotPassword } from "./database/entity/ForgotPassword";
import { User } from "./database/entity/User";
import { TempUser } from "./database/entity/TempUser";
import { EmailFormat } from "./database/entity/EmailFormat";
import { RideOffer } from "./database/entity/RideOffer";
import { Vehicle } from "./database/entity/Vehicle";
import { RequestToOffer } from "./database/entity/RequestToOffer";
import { RideRequest } from "./database/entity/RideRequest";
import { Rating } from "./database/entity/Rating";
import { Complaint } from "./database/entity/Complaint";
import { Payment } from "./database/entity/Payment";

dotenv.config();

export const AppDataSource = new DataSource({
  type: "postgres",
  host: process.env.DATABASE_HOST,
  port: parseInt(<string>process.env.DATABASE_PORT),
  username: process.env.DATABASE_USER,
  password: process.env.DATABASE_PASS,
  database: process.env.DATABASE_NAME,
  synchronize: true,
  logging: false,
  entities: [
    User,
    ForgotPassword,
    EmailFormat,
    TempUser,
    RideOffer,
    Vehicle,
    RequestToOffer,
    RideRequest,
    Rating,
    Complaint,
    Payment,
  ],
  migrations: ["./src/database/migration"],
  subscribers: [],
});

export const NeoDriver = neo4j.driver(
  process.env.NEO_URL,
  neo4j.auth.basic(process.env.NEO_USER, process.env.NEO_PASSWORD)
);
