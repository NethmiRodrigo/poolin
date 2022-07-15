import request from "supertest";
import bcrypt from "bcrypt";
import app from "../../app";
import { User } from "../../database/entity/User";
import TestConnection from "../util/connection";

let connection: TestConnection;

const API_URL: string = "/api/auth/verify-user-info";

describe("Test verify-user-info endpoint", () => {
  beforeAll(async () => {
    connection = await new TestConnection().initialize();
    await User.clear();
    const password = await bcrypt.hash("password", 8);
    const user = await User.create({
      email: "test000@stu.ucsc.lk",
      password: password,
      mobile: "+94770000005",
    }).save();
  });

  it("Should confirm valid firstName, lastName, gender", async () => {
    const response = await request(app).post(API_URL).send({
      email: "test000@stu.ucsc.lk",
      firstName: "Test",
      lastName: "User",
      gender: "female",
    });
    expect(response.statusCode).toEqual(200);
    expect(response.body).toHaveProperty("success");
  });

  it("Should deny invalid gender", async () => {
    const response = await request(app).post(API_URL).send({
      email: "test000@stu.ucsc.lk",
      firstName: "Test",
      lastName: "User",
      gender: "test",
    });
    // console.debug(response)
    expect(response.statusCode).toEqual(500);
  });

  afterAll(async () => {
    await connection.dropTable("users");
    await connection.destroy();
    app.close();
  });
});
