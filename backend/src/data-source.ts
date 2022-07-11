import "reflect-metadata";
import { DataSource } from "typeorm";

import { User } from "./entity/User";
import { EmailFormat } from "./entity/EmailFormat";

export const AppDataSource = new DataSource({
  type: "postgres",
  host: "localhost",
  port: 5432,
  username: "postgres",
  password: "root",
  database: "poolin",
  synchronize: true,
  logging: false,
  entities: [User, EmailFormat],
  migrations: [],
  subscribers: [],
});
