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
      email: "dulaj@email.com",
      password,
    });
    await testUser.save();

    const colomboOffer = RideOffer.create({
      user: testUser,
      from: "UCSC",
      fromGeom: {
        type: "Point",
        coordinates: [6.902157834737093, 79.86087019369945],
      },
      to: "Town Hall",
      toGeom: {
        type: "Point",
        coordinates: [6.9159491250786855, 79.86377232821592],
      },
      polyline: {
        type: "LineString",
        coordinates: await getOSRMPolyline(
          {
            lat: 6.902157834737093,
            long: 79.86087019369945,
          },
          {
            lat: 6.9159491250786855,
            long: 79.86377232821592,
          }
        ),
      },

      departureTime: "2014-06-25 05:30:00.000",
      arrivalTime: "2014-06-25 05:30:00.000",
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
        coordinates: [7.29218960094139, 80.63702666439019],
      },
      to: "Peradeniya",
      toGeom: {
        type: "Point",
        coordinates: [7.293772886086029, 80.64097205055545],
      },
      polyline: {
        type: "LineString",
        coordinates: await getOSRMPolyline(
          {
            lat: 7.29218960094139,
            long: 80.63702666439019,
          },
          {
            lat: 7.293772886086029,
            long: 80.64097205055545,
          }
        ),
      },

      departureTime: "2014-06-25 05:30:00.000",
      arrivalTime: "2014-06-25 05:30:00.000",
      pricePerKm: 7,
      seats: 6,
      distance: 80,
    });

    await kandyOffer.save();
  });

  it("Should return single response as time and route intersect", async () => {
    console.log(await RideOffer.count());
    const response = await request(app)
      .get(
        `${API_URL}?srcLat=6.907045432926681&srcLong=79.86056879490037&destLat=6.911133718778163&destLong=79.86466894132164&startTime=2014-06-25T00:00:00.000Z&window=30`
      )
      .send();
    expect(response.statusCode).toEqual(200);
    expect(response.body).toHaveProperty("offers");
    expect(response.body.offers.length).toEqual(1);
  });

  it("Should return empty result set if time doesn't fall inbetween", async () => {
    const response = await request(app)
      .get(
        `${API_URL}?srcLat=6.907045432926681&srcLong=79.86056879490037&destLat=6.911133718778163&destLong=79.86466894132164&startTime=2014-06-26T00:00:00.000Z&window=30`
      )
      .send();
    expect(response.statusCode).toEqual(200);
    expect(response.body).toHaveProperty("offers");
    expect(response.body.offers.length).toEqual(0);
  });

  it("Should return empty result set if routes don't intersect", async () => {
    const response = await request(app)
      .get(
        `${API_URL}?srcLat=7.094144558796502&srcLong=79.99441032930558&destLat=7.222971536496868&destLong=79.85151271660334&startTime=2014-06-25T00:00:00.000Z&window=30`
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
