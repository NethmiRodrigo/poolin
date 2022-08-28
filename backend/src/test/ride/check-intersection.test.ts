import request from "supertest";
import bcrypt from "bcrypt";
import app from "../../app";
import { User } from "../../database/entity/User";
import TestConnection from "../util/connection";
import { RideOffer } from "../../database/entity/RideOffer";
import { getOSRMPolyline } from "../../middleware/osrmpolyline";

let connection: TestConnection;

const API_URL: string = "/api/ride/get/matching-requests";

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

    const colomboOffer = RideOffer.create({
      user: testUser,
      from: "UCSC",
      fromGeom: {
        type: "Point",
        coordinates: [6.902233704462319, 79.86114900428167],
      },
      to: "Town Hall",
      toGeom: {
        type: "Point",
        coordinates: [6.915866890775015, 79.86378829780112],
      },
      polyline: {
        type: "LineString",
        coordinates: await getOSRMPolyline(
          {
            lat: 6.902233704462319,
            long: 79.86114900428167,
          },
          {
            lat: 6.915866890775015,
            long: 79.86378829780112,
          }
        ),
      },

      departureTime: "2014-06-23T00:00:00.000Z",
      arrivalTime: "2014-06-25T00:00:00.000Z",
      pricePerKm: 7,
      seats: 6,
      distance: 80,
    });
    await colomboOffer.save();

    const kandyOffer = RideOffer.create({
      user: testUser,
      from: "KCC",
      fromGeom: {
        type: "Point",
        coordinates: [7.292105818639732, 80.63715609091842],
      },
      to: "Peradeniya",
      toGeom: {
        type: "Point",
        coordinates: [7.2698846457356305, 80.59346827298681],
      },
      polyline: {
        type: "LineString",
        coordinates: await getOSRMPolyline(
          {
            lat: 7.292105818639732,
            long: 80.63715609091842,
          },
          {
            lat: 7.2698846457356305,
            long: 80.59346827298681,
          }
        ),
      },

      departureTime: "2014-06-23T00:00:00.000Z",
      arrivalTime: "2014-06-25T00:00:00.000Z",
      pricePerKm: 7,
      seats: 6,
      distance: 80,
    });

    await kandyOffer.save();
  });

  it("Should return single response as time and route intersect", async () => {
    const response = await request(app)
      .get(
        `${API_URL}?
        srcLat=6.907045432926681
        &srcLong=79.86056879490037
        &destLat=6.911133718778163
        &destLong=79.86466894132164
        &startTime=2014-06-24T00:00:00.000Z
        &window=30`
      )
      .send();
    expect(response.statusCode).toEqual(200);
    expect(response.body).toHaveProperty("offers");
    expect(response.body.offers.length).toEqual(1);
  });

  it("Should return empty result set if time doesn't fall inbetween", async () => {
    const response = await request(app)
      .get(
        `${API_URL}?
        srcLat=6.907045432926681
        &srcLong=79.86056879490037
        &destLat=6.911133718778163
        &destLong=79.86466894132164
        &startTime=2014-06-26T00:00:00.000Z
        &window=30`
      )
      .send();
    expect(response.statusCode).toEqual(200);
    expect(response.body).toHaveProperty("offers");
    expect(response.body.offers.length).toEqual(0);
  });

  it("Should return empty result set if routes don't intersect", async () => {
    const response = await request(app)
      .get(
        `${API_URL}?
        srcLat=7.094144558796502
        &srcLong=79.99441032930558
        &destLat=7.222971536496868
        &destLong=79.85151271660334
        &startTime=2014-06-24T00:00:00.000Z
        &window=30`
      )
      .send();
    expect(response.statusCode).toEqual(200);
    expect(response.body).toHaveProperty("offers");
    expect(response.body.offers.length).toEqual(0);
  });

  afterAll(async () => {
    await connection.clearDatabase();
    await connection.destroy();
    app.close();
  });
});
