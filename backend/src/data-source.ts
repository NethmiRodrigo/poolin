import "reflect-metadata";
import { DataSource } from "typeorm";
import dotenv from "dotenv";
import { ForgotPassword } from "./database/entity/ForgotPassword";
import { User } from "./database/entity/User";
import { TempUser } from "./database/entity/TempUser";
import { EmailFormat } from "./database/entity/EmailFormat";
import { RideOffer } from "./database/entity/RideOffer";
import { Vehicle } from "./database/entity/Vehicle";
<<<<<<< HEAD
import { Rating } from "./database/entity/Rating";
=======
import { RequestToOffer } from "./database/entity/RequestToOffer";
import { RideRequest } from "./database/entity/RideRequest";
>>>>>>> master

dotenv.config();

export const AppDataSource = new DataSource({
  type: "postgres",
  host: process.env.DATABASE_HOST,
  port: parseInt(<string>process.env.DATABASE_PORT),
  username: process.env.DATABASE_USER,
  password: `${process.env.DATABASE_PASS}`,
  database: process.env.DATABASE_NAME,
  synchronize: true,
  logging: false,
<<<<<<< HEAD
  entities: [User, ForgotPassword, EmailFormat, TempUser, Vehicle, Rating],
=======
  entities: [
    User,
    ForgotPassword,
    EmailFormat,
    TempUser,
    RideOffer,
    Vehicle,
    RequestToOffer,
    RideRequest,
  ],
>>>>>>> master
  migrations: ["./src/database/migration"],
  subscribers: [],
});
