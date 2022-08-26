const axios = require("axios");

export const getOSRMDuration = async (start, end) => {
  const startPoint = [start.long, start.lat].join(",");
  const endPoint = [end.long, end.lat].join(",");
  const config = {
    method: "get",
    url: `http://router.project-osrm.org/route/v1/driving/${startPoint};${endPoint}?overview=full`,
    headers: {},
  };

  try {
    const response = await axios(config);
    const duration = response.data.routes[0].distance / 60;
    return duration;
  } catch (error) {
    console.log(error);
  }
};
