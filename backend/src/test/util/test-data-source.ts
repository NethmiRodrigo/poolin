import "reflect-metadata";
import { DataSource } from "typeorm";
import { EmailFormat } from "../../database/entity/EmailFormat";
import { ForgotPassword } from "../../database/entity/ForgotPassword";
import { RequestToOffer } from "../../database/entity/RequestToOffer";
import { RideOffer } from "../../database/entity/RideOffer";
import { RideRequest } from "../../database/entity/RideRequest";
import { TempUser } from "../../database/entity/TempUser";
import { User } from "../../database/entity/User";
import { Vehicle } from "../../database/entity/Vehicle";

export const TestAppDataSource = new DataSource({
  type: "postgres",
  host: process.env.DATABASE_HOST,
  port: parseInt(<string>process.env.DATABASE_PORT),
  username: process.env.DATABASE_USER,
  password: process.env.DATABASE_PASS,
  database: "poolin-test",
  synchronize: true,
  logging: false,
  entities: [
    User,
    ForgotPassword,
    EmailFormat,
    TempUser,
    Vehicle,
    RideOffer,
    RideRequest,
    RequestToOffer,
  ],
  migrations: [],
  subscribers: [],
});
