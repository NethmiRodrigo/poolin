import request from "supertest";
import bcrypt from "bcrypt";
import app from "../app";
import { User } from "../entity/User";
import TestConnection from "./util/connection";

let connection: TestConnection;

const API_URL: string = "/api/auth/login";

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

  it("Should be able to login with email and password", async () => {
    const response = await request(app).post(API_URL).send({
      email: "test@email.com",
      password: "password",
    });
    expect(response.statusCode).toEqual(200);
    expect(response.body).toHaveProperty("token");
  });

  it("Should not be able to login without email", async () => {
    const response = await request(app).post(API_URL).send({
      email: "",
      password: "password",
    });
    expect(response.statusCode).toEqual(400);
    expect(response.body).toHaveProperty("error");
  });

  it("Should not be able to login without email", async () => {
    const response = await request(app).post(API_URL).send({
      email: "",
      password: "password",
    });
    expect(response.statusCode).toEqual(400);
    expect(response.body).toHaveProperty("error");
  });

  it("Should not be able to login without password", async () => {
    const response = await request(app).post(API_URL).send({
      email: "test@email.com",
      password: "",
    });
    expect(response.statusCode).toEqual(400);
    expect(response.body).toHaveProperty("error");
  });

  it("Should not be able to login without email and password", async () => {
    const response = await request(app).post(API_URL).send({
      email: "",
      password: "",
    });
    expect(response.statusCode).toEqual(400);
    expect(response.body).toHaveProperty("error");
  });

  it("Should not be able to login without a valid email", async () => {
    const response = await request(app).post(API_URL).send({
      email: "testuser",
      password: "password",
    });
    expect(response.statusCode).toEqual(400);
    expect(response.body).toHaveProperty("error");
  });

  it("Should not be able to login without a valid email", async () => {
    const response = await request(app).post(API_URL).send({
      email: "testuser",
      password: "password",
    });
    expect(response.statusCode).toEqual(400);
    expect(response.body).toHaveProperty("error");
  });

  it("Should not be able to login if user with email does not exist", async () => {
    const response = await request(app).post(API_URL).send({
      email: "testuser@email.com",
      password: "password",
    });
    expect(response.statusCode).toEqual(401);
    expect(response.body).toHaveProperty("error");
  });

  afterAll(async () => {
    await connection.dropTable("users");
    await connection.destroy();
    app.close();
  });
});
