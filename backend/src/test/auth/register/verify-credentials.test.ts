import request from "supertest";
import app from "../../../app";
import codeHandler from "../../../util/code-handler";
import TestConnection from "../../util/connection";
import tearDownTests from "../../util/tearDown";

let connection: TestConnection;

const API_URL: string = "/api/auth/verify-credentials";

describe("Test verify-credentials endpoint", () => {
  beforeAll(async () => {
    connection = await new TestConnection().initialize();
  });

  it("Should confirm valid email and strong password", async () => {
    const email = codeHandler(4, true) + "test000@stu.ucsc.lk";
    const response = await request(app).post(API_URL).send({
      email: email,
      password: "Test@1234",
      confirmPassword: "Test@1234",
    });
    expect(response.statusCode).toEqual(200);
    expect(response.body).toHaveProperty("success");
  });

  it("Should deny when invalid email passed", async () => {
    const response = await request(app).post(API_URL).send({
      email: "not an email",
      password: "Test@1234",
      confirmPassword: "Test@1234",
    });
    expect(response.statusCode).toEqual(401);
    expect(response.body).toHaveProperty("error");
  });

  it("Should deny when passwords don't match", async () => {
    const email = codeHandler(4, true) + "test000@stu.ucsc.lk";
    const response = await request(app).post(API_URL).send({
      email: email,
      password: "Test@1234",
      confirmPassword: "Testing@1234",
    });
    expect(response.statusCode).toEqual(401);
  });

  afterAll(async () => {
    await tearDownTests();
  });
});
