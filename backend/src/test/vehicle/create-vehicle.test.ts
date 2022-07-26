import request from "supertest";
import bcrypt from "bcrypt";
import app from "../../app";
import { User } from "../../database/entity/User";
import TestConnection from "../util/connection";

let connection: TestConnection;

const API_URL: string = "/api/vehicle/create";
let testUser: User;

describe(API_URL, () => {
  beforeAll(async () => {
    connection = await new TestConnection().initialize();
    const password = await bcrypt.hash("password", 8);
    testUser = User.create({
      email: "test@email.com",
      password,
    });
    await testUser.save();
  });

  it("Should be able to create a vehicle entity", async () => {
    const response = await request(app).post(API_URL).send({
      numberPlate: "KV-1234",
      type: "sedan",
      numberOfSeats: 4,
      ownerId: testUser.id,
    });
    expect(response.statusCode).toEqual(201);
    expect(response.body).toHaveProperty("vehicle");
  });

  it("Should throw error when invalid vehicle type is given", async () => {
    const response = await request(app).post(API_URL).send({
      numberPlate: "KV-1234",
      type: "invalid",
      numberOfSeats: 4,
      ownerId: testUser.id,
    });
    expect(response.statusCode).toEqual(400);
    expect(response.body).toHaveProperty("error");
  });

  it("Should throw error when invalid number of seats", async () => {
    const response = await request(app).post(API_URL).send({
      numberPlate: "KV-1234",
      type: "sedan",
      numberOfSeats: "none",
      ownerId: testUser.id,
    });
    expect(response.statusCode).toEqual(400);
    expect(response.body).toHaveProperty("error");
  });

  it("Should throw error when invalid user id is given", async () => {
    const response = await request(app).post(API_URL).send({
      numberPlate: "KV-1234",
      type: "sedan",
      numberOfSeats: 3,
      ownerId: 69,
    });
    expect(response.statusCode).toEqual(404);
    expect(response.body).toHaveProperty("error");
  });

  it("Should throw error when number plate is missing", async () => {
    const response = await request(app).post(API_URL).send({
      type: "sedan",
      numberOfSeats: 3,
      ownerId: 69,
    });
    expect(response.statusCode).toEqual(400);
    expect(response.body).toHaveProperty("error");
  });

  afterAll(async () => {
    await connection.clearDatabase();
    await connection.destroy();
    app.close();
  });
});
