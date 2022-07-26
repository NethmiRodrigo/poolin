import request from "supertest";
import bcrypt from "bcrypt";
import app from "../../app";
import { User } from "../../database/entity/User";
import TestConnection from "../util/connection";
import tearDownTests from "../util/tearDown";

let connection: TestConnection;

const API_URL: string = "/api/user/get";

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

  it("Should be able to login with email and password", async () => {
    const response = await request(app).get(`${API_URL}/${testUser.id}`).send();
    expect(response.statusCode).toEqual(200);
    expect(response.body).toHaveProperty("user");
    expect(response.body.user.email).toEqual(testUser.email);
  });

  it("Should throw error if user does not exist", async () => {
    const response = await request(app).get(`${API_URL}/69`).send();
    expect(response.statusCode).toEqual(404);
    expect(response.body).toHaveProperty("error");
  });

  afterAll(async () => {
    await tearDownTests();
  });
});
