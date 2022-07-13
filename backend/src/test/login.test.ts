import request from "supertest";
import app from "../app";
import { User } from "../entity/User";
import TestConnection from "./util/connection";

let connection: TestConnection;

describe("/api/auth/login", () => {
  beforeAll(async () => {
    connection = await new TestConnection().initialize();
    const testUser = User.create({
      email: "test@email.com",
      password: "password",
      name: "Test User",
    });
    await testUser.save();
  });

  it("Should be able to login with email and password", async () => {
    const response = await request(app).post("/api/auth/login").send({
      email: "test@email.com",
      password: "password",
    });
    expect(response.statusCode).toEqual(200);
    expect(response.body).toHaveProperty("token");
  });

  it("Should not be able to login without email", async () => {
    const response = await request(app).post("/api/auth/login").send({
      email: "",
      password: "password",
    });
    expect(response.statusCode).toEqual(400);
    expect(response.body).toHaveProperty("error");
  });

  it("Should not be able to login without email", async () => {
    const response = await request(app).post("/api/auth/login").send({
      email: "",
      password: "password",
    });
    expect(response.statusCode).toEqual(400);
    expect(response.body).toHaveProperty("error");
  });

  it("Should not be able to login without password", async () => {
    const response = await request(app).post("/api/auth/login").send({
      email: "test@email.com",
      password: "",
    });
    expect(response.statusCode).toEqual(400);
    expect(response.body).toHaveProperty("error");
  });

  it("Should not be able to login without email and password", async () => {
    const response = await request(app).post("/api/auth/login").send({
      email: "",
      password: "",
    });
    expect(response.statusCode).toEqual(400);
    expect(response.body).toHaveProperty("error");
  });

  it("Should not be able to login without a valid email", async () => {
    const response = await request(app).post("/api/auth/login").send({
      email: "testuser",
      password: "password",
    });
    expect(response.statusCode).toEqual(400);
    expect(response.body).toHaveProperty("error");
  });

  it("Should not be able to login without a valid email", async () => {
    const response = await request(app).post("/api/auth/login").send({
      email: "testuser",
      password: "password",
    });
    expect(response.statusCode).toEqual(400);
    expect(response.body).toHaveProperty("error");
  });

  it("Should not be able to login if user with email does not exist", async () => {
    const response = await request(app).post("/api/auth/login").send({
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
