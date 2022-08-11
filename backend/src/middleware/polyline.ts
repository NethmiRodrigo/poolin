export const getPolyline = async (start, end) => {
  const startPoint = [start.lat, start.long].join("%2C");
  const endPoint = [end.lat, end.long].join("%2C");
  var axios = require("axios");
  console.log(startPoint);
  console.log(endPoint);

  const api_key = "AIzaSyB5PFapIypRNpwikmNQG3WNbi2JUHOpgoQ";
  var results = [];

  var config = {
    method: "get",
    url: `https://maps.googleapis.com/maps/api/directions/json?origin=${startPoint}&destination=${endPoint}&key=${api_key}`,
    headers: {},
  };

  var polyline = require("google-polyline");

  await axios(config)
    .then(async function (response) {
      var encodedString = response.data.routes[0].overview_polyline.points;
      results = polyline.decode(encodedString);
      console.log(results);
      return results;
    })
    .catch(function (error) {
      console.log(error);
    });
  return results;
};
