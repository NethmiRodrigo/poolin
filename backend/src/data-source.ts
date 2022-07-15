import "reflect-metadata";
import { DataSource } from "typeorm";
import dotenv from "dotenv";
import { ForgotPassword } from "./entity/ForgotPassword";
import { User } from "./entity/User";
import { TempUser } from "./entity/TempUser";
import { EmailFormat } from "./entity/EmailFormat";

dotenv.config();

export const AppDataSource = new DataSource({
  type: "postgres",
  host: process.env.DATABASE_HOST,
  port: parseInt(<string>process.env.DATABAnSE_PORT),
  username: process.env.DATABASE_USER,
  password: process.env.DATABASE_PASS,
  database: process.env.DATABASE_NAME,
  synchronize: true,
  logging: false,
  entities: [User, ForgotPassword, EmailFormat, TempUser],
  migrations: [],
  subscribers: [],
});
