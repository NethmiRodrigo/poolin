import request from "supertest";
import app from "../../../app";
import { TempUser } from "../../../database/entity/TempUser";
import { User } from "../../../database/entity/User";
import codeHandler from "../../../util/code-handler";
import TestConnection from "../../util/connection";

let connection: TestConnection;

const API_URL: string = "/api/auth/verify-mobile-num";

describe("Test verify-mobile-num endpoint", () => {
  beforeAll(async () => {
    connection = await new TestConnection().initialize();
    await User.clear();
    const tempUser = await TempUser.create({
      email: "2022is099@stu.ucsc.cmb.ac.lk",
      password: "2020Test@1234",
    }).save();
  });

  //*********** Commented so that the SMS API doesn't run out of free credit :) ************
  // it("Should confirm valid mobile number (+94...)", async () => {
  //  const mobile = '+94' + codeHandler(9, true);
  //  const response = await request(app).post(API_URL).send({
  //   email: "2022is099@stu.ucsc.cmb.ac.lk",
  //   mobile: mobile
  //  });
  //  expect(response.statusCode).toEqual(200);
  //  expect(response.body).toHaveProperty("success");
  // });

  it("Should deny for wrong mobile number format (077...)", async () => {
    const mobile = "07" + codeHandler(8, true);
    const response = await request(app).post(API_URL).send({
      email: "2022is099@stu.ucsc.cmb.ac.lk",
      mobile: mobile,
    });
    expect(response.statusCode).toEqual(401);
  });

  afterAll(async () => {
    await connection.dropTable("temp_user");
    await connection.destroy();
    app.close();
  });
});
