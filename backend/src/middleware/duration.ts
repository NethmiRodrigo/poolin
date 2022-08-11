export const getDuration = async (start, end) => {
  var axios = require("axios");
  console.log(start["lat"]);
  const api_key = "AIzaSyB5PFapIypRNpwikmNQG3WNbi2JUHOpgoQ";
  var duration = 0;

  var config = {
    method: "get",
    url: `https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=${start.lat},${start.long}&destinations=${end.lat},${end.long}&key=${api_key}`,
    headers: {},
  };

  await axios(config)
    .then(async function (response) {
      var encodedString =
        response.data["rows"][0]["elements"][0]["duration"]["text"].split(" ");

      if (encodedString[2]) {
        duration =
          parseInt(encodedString[0]) * 60 + parseInt(encodedString[2]) * 1;
      } else {
        duration = encodedString[0];
      }

      return duration;
    })
    .catch(function (error) {
      console.log(error);
    });
  return duration;
};
