import { AppError } from "../util/error-handler";

const axios = require("axios");
const polyline = require("google-polyline");

export const getOSRMPolyline = async (start, end) => {
  const startPoint = [start.long, start.lat].join(",");
  const endPoint = [end.long, end.lat].join(",");

  const url = `http://router.project-osrm.org/route/v1/driving/${startPoint};${endPoint}?overview=full`;

  try {
    const response = await axios.get(url);
    const encodedString = response.data.routes[0].geometry;

    const results = polyline.decode(encodedString);

    //take portion of route to account for points outside route
    const trimmedResults = results.splice(20, results.length - 20);
    console.log("got here");
    return trimmedResults;
  } catch (error) {
    throw new AppError(401, {}, "Bad request");
  }
};
