import { AppError } from "../util/error-handler";

const axios = require("axios");
const polyline = require("google-polyline");

export const getPolyline = async (start, end) => {
  const startPoint = [start.lat, start.long].join("%2C");
  const endPoint = [end.lat, end.long].join("%2C");

  const api_key = process.env.MAPS_API_KEY;

  const url = `${process.env.DIRECTIONS_API_URL}?origin=${startPoint}&destination=${endPoint}&key=${api_key}`;

  try {
    const response = await axios.get(url);
    const encodedString = response.data.routes[0].overview_polyline.points;
    const results = polyline.decode(encodedString);
    return results;
  } catch (error) {
    throw new AppError(401, {}, "Bad request");
  }
};
