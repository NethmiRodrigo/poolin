import "reflect-metadata";
import { DataSource } from "typeorm";
import dotenv from "dotenv";
import { ForgotPassword } from "../../entity/ForgotPassword";
import { User } from "../../entity/User";

dotenv.config({ path: "./src/.env" });

export const TestAppDataSource = new DataSource({
  type: "postgres",
  host: process.env.DATABASE_HOST,
  port: parseInt(<string>process.env.DATABASE_PORT),
  username: process.env.DATABASE_USER,
  password: process.env.DATABASE_PASS,
  database: "poolin-test",
  synchronize: true,
  logging: false,
  entities: [User, ForgotPassword],
  migrations: [],
  subscribers: [],
});
