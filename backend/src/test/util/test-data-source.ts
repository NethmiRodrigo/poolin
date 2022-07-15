import "reflect-metadata";
import { DataSource } from "typeorm";
import { EmailFormat } from "../../entity/EmailFormat";
import { ForgotPassword } from "../../entity/ForgotPassword";
import { TempUser } from "../../entity/TempUser";
import { User } from "../../entity/User";

export const TestAppDataSource = new DataSource({
  type: "postgres",
  host: process.env.DATABASE_HOST,
  port: parseInt(<string>process.env.DATABASE_PORT),
  username: process.env.DATABASE_USER,
  password: process.env.DATABASE_PASS,
  database: "poolin-test",
  synchronize: true,
  logging: false,
  entities: [User, ForgotPassword, EmailFormat, TempUser],
  migrations: [],
  subscribers: [],
});
