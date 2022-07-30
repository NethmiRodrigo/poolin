import app from "../../../app";
import { User } from "../../../database/entity/User";
import { isEmailRegistered } from "../../../util/auth-helper";
import TestConnection from "../../util/connection";

let connection: TestConnection;

describe("Check if an email is already registered", () => {
  beforeAll(async () => {
    connection = await new TestConnection().initialize();
    const user = await User.create({
      email: "2020test000@stu.ucsc.lk",
      password: "2020Test@1234",
      mobile: "+94770000001",
    }).save();
  });

  it("Should deny a registered email (2020test000@stu.ucsc.lk)'", async () => {
    const email = "2020test000@stu.ucsc.lk";
    const response = await isEmailRegistered(email);
    expect(response).toBeTruthy();
  });

  it("Should accept an unregistered email (2020test111@stu.ucsc.lk)'", async () => {
    const email = "2020test111@stu.ucsc.lk";
    const response = await isEmailRegistered(email);
    expect(response).toBeFalsy();
  });

  afterAll(async () => {
    await connection.clearDatabase();
    await connection.destroy();
    app.close();
  });
});
