const axios = require("axios");

export const getDuration = async (start, end) => {
  const api_key = process.env.MAPS_API_KEY;
  let duration = 0;

  const config = {
    method: "get",
    url: `${process.env.DISTANCE_MATRIX_API_URL}?units=imperial&origins=${start.lat},${start.long}&destinations=${end.lat},${end.long}&key=${api_key}`,
    headers: {},
  };

  try {
    const response = await axios(config);
    console.log(response.data.rows[0].elements[0].duration.text);
    const encodedString =
      response.data.rows[0].elements[0].duration.text.split(" ");
    if (encodedString[2]) {
      duration =
        parseInt(encodedString[0]) * 60 + parseInt(encodedString[2]) * 1;
    } else {
      duration = encodedString[0];
    }
    return duration;
  } catch (error) {
    console.log(error);
  }
};
