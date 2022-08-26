const axios = require("axios");
const polyline = require("google-polyline");

export const getOSRMPolyline = async (start, end) => {
  const startPoint = [start.long, start.lat].join(",");
  const endPoint = [end.long, end.lat].join(",");

  const config = {
    method: "get",
    url: `http://router.project-osrm.org/route/v1/driving/${startPoint};${endPoint}?overview=full`,
    headers: {},
  };
  console.log(startPoint);
  console.log(endPoint);
  console.log(config);
  try {
    const response = await axios(config);
    const encodedString = response.data.routes[0].geometry;
    const results = polyline.decode(encodedString);
    return results;
  } catch (error) {
    console.log(error);
  }
};
