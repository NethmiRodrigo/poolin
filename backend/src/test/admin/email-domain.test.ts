import app from "../../app";
import { EmailFormat } from "../../database/entity/EmailFormat";
import { isEmailDomainValid } from "../../util/auth-helper";
import TestConnection from "../util/connection";

let connection: TestConnection;

describe("Check email domains", () => {
  beforeAll(async () => {
    connection = await new TestConnection().initialize();
    const emailFormat = EmailFormat.create({
      emailFormat: "stu.ucsc.cmb.ac.lk",
    });
    await emailFormat.save();
  });

  it("Should confirm email '2022is099@stu.ucsc.cmb.ac.lk'", async () => {
    const email = "2022is099@stu.ucsc.cmb.ac.lk";
    const response = await isEmailDomainValid(email);
    expect(response).toBeTruthy();
  });

  it("Should deny email '2022is099@stu.ucsc.cmb.com'", async () => {
    const email = "2022is099@stu.ucsc.cmb.com";
    const response = await isEmailDomainValid(email);
    expect(response).toBeFalsy();
  });

  afterAll(async () => {
    await connection.clearDatabase();
    await connection.destroy();
    app.close();
  });
});
