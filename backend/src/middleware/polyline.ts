const axios = require("axios");
const polyline = require("google-polyline");

export const getPolyline = async (start, end) => {
  const startPoint = [start.lat, start.long].join("%2C");
  const endPoint = [end.lat, end.long].join("%2C");

  const api_key = process.env.MAPS_API_KEY;
  let results = [];

  const config = {
    method: "get",
    url: `${process.env.DIRECTIONS_API_URL}?origin=${startPoint}&destination=${endPoint}&key=${api_key}`,
    headers: {},
  };

  await axios(config)
    .then(async function (response) {
      const encodedString = response.data.routes[0].overview_polyline.points;
      results = polyline.decode(encodedString);
      return results;
    })
    .catch(function (error) {
      console.log(error);
    });
  return results;
};
