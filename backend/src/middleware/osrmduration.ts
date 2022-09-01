import { AppError } from "../util/error-handler";

const axios = require("axios");

export const getOSRMDuration = async (start, end) => {
  const startPoint = [start.long, start.lat].join(",");
  const endPoint = [end.long, end.lat].join(",");

  const url = `http://router.project-osrm.org/route/v1/driving/${startPoint};${endPoint}?overview=full`;

  try {
    const response = await axios.get(url);
    const duration = response.data.routes[0].duration / 60;
    return duration;
  } catch (error) {
    throw new AppError(401, {}, "Bad request");
  }
};
