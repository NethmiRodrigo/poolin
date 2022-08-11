const axios = require("axios");

export const getDuration = async (start, end) => {
  const api_key = process.env.MAPS_API_KEY;

  const config = {
    method: "get",
    url: `${process.env.DISTANCE_MATRIX_API_URL}?units=imperial&origins=${start.lat},${start.long}&destinations=${end.lat},${end.long}&key=${api_key}`,
    headers: {},
  };

  try {
    const response = await axios(config);
    const duration = response.data.rows[0].elements[0].duration.value;
    return duration;
  } catch (error) {
    console.log(error);
  }
};
