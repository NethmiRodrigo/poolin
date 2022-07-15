import "reflect-metadata";
import { DataSource } from "typeorm";
import dotenv from "dotenv";
import { ForgotPassword } from "./database/entity/ForgotPassword";
import { User } from "./database/entity/User";
import { TempUser } from "./database/entity/TempUser";
import { EmailFormat } from "./database/entity/EmailFormat";

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
  entities: [User, ForgotPassword, EmailFormat, TempUser],
  migrations: ["./src/database/migration"],
  subscribers: [],
});
