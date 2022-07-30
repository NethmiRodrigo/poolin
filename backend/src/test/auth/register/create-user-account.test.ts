import app from "../../../app";
import {
  TempUser,
  VerificationStatus,
} from "../../../database/entity/TempUser";
import { createUserAccount } from "../../../util/auth-helper";
import codeHandler from "../../../util/code-handler";
import TestConnection from "../../util/connection";

let connection: TestConnection;
let tempUser;

describe("Check if user account is created", () => {
  beforeAll(async () => {
    connection = await new TestConnection().initialize();
  });

  it("Should create account when mobile and email is verified", async () => {
    const email = codeHandler(4, true) + "test000@stu.ucsc.lk";
    tempUser = await TempUser.create({
      email: email,
      password: "2020Test@1234",
      emailStatus: VerificationStatus.VERIFIED,
      mobileStatus: VerificationStatus.VERIFIED,
    }).save();

    const response = await createUserAccount(tempUser.id);
    expect(response).toBeDefined();
    expect(response).toBeInstanceOf(Object);
    expect(response.email).toEqual(email);
  });

  afterAll(async () => {
    await connection.clearDatabase();
    await connection.destroy();
    app.close();
  });
});
