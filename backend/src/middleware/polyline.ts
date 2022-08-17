const axios = require("axios");
const polyline = require("google-polyline");

export const getPolyline = async (start, end) => {
  const startPoint = [start.lat, start.long].join("%2C");
  const endPoint = [end.lat, end.long].join("%2C");

  const api_key = process.env.MAPS_API_KEY;

  const config = {
    method: "get",
    url: `${process.env.DIRECTIONS_API_URL}?origin=${startPoint}&destination=${endPoint}&key=${api_key}`,
    headers: {},
  };

  try {
    const response = await axios(config);
    const encodedString = response.data.routes[0].overview_polyline.points;
    const results = polyline.decode(encodedString);
    //remove 5 from start and and to prevent intersection of outside points
    //value 5 obtained by trial and error
    const restrictedResults = results.splice(5, -5);
    return restrictedResults;
  } catch (error) {
    console.log(error);
  }
};
