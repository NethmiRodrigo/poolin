export const getDuration = async (start, end) => {
  var axios = require("axios");
  console.log(start["lat"]);
  const api_key = "AIzaSyB5PFapIypRNpwikmNQG3WNbi2JUHOpgoQ";
  var results = [];

  var config = {
    method: "get",
    url: `https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=${start.lat},${start.long}&destinations=${end.lat},${end.long}&key=${api_key}`,
    headers: {},
  };

  await axios(config)
    .then(async function (response) {
      console.log(config.url);
      var encodedString =
        response.data["rows"][0]["elements"][0]["duration"]["text"].split(
          " "
        )[0];
      results = encodedString;
      console.log(results);
      return results;
    })
    .catch(function (error) {
      console.log(error);
    });
  return results;
};
