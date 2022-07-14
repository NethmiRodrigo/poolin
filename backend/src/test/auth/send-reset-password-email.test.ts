import request from "supertest";
import bcrypt from "bcrypt";
import app from "../../app";
import { User } from "../../entity/User";
import TestConnection from "../util/connection";

const API_URL: string = "/api/auth/send-reset-password-email";
let connection: TestConnection;

describe(API_URL, () => {
  beforeAll(async () => {
    connection = await new TestConnection().initialize();
    const password = await bcrypt.hash("password", 8);
    const testUser = User.create({
      email: "test@email.com",
      password,
    });
    await testUser.save();
  });

  it("Should receive OTP by email if user exists", async () => {
    const response = await request(app).post(API_URL).send({
      email: "test@email.com",
    });
    expect(response.statusCode).toEqual(200);
    expect(response.body).toHaveProperty("success");
  });

  it("Should not be able to recieve an OTP if email is empty", async () => {
    const response = await request(app).post(API_URL).send({
      email: "",
    });
    expect(response.statusCode).toEqual(400);
    expect(response.body).toHaveProperty("error");
  });

  it("Should not be able to recieve an OTP if email is invalid", async () => {
    const response = await request(app).post(API_URL).send({
      email: "testuser",
    });
    expect(response.statusCode).toEqual(400);
    expect(response.body).toHaveProperty("error");
  });

  afterAll(async () => {
    await connection.dropTable("users");
    await connection.dropTable("forgot_password");
    await connection.destroy();
    app.close();
  });
});
