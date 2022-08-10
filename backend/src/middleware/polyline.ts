import { OfferRoute } from "../database/entity/OfferRoute";

export const getPolyline = () => {
  var axios = require("axios");

  const api_key = "AIzaSyB5PFapIypRNpwikmNQG3WNbi2JUHOpgoQ";

  /**
   * refer to https://developers.google.com/maps/documentation/directions/get-directions#DirectionsRequests for more info
   */

  // coordinates of start point appended with '%2C'
  const startPoint = "6.891910722041444%2C79.85974075584645";

  // coordinates of end point appended with '%2C'
  const endPoint = "6.8916558905925065%2C79.85739109069216";

  var config = {
    method: "get",
    url: `https://maps.googleapis.com/maps/api/directions/json?origin=${startPoint}&destination=${endPoint}&key=${api_key}`,
    headers: {},
  };

  var polyline = require("google-polyline");

  axios(config)
    .then(function (response) {
      var encodedString = response.data.routes[0].overview_polyline.points;
      var results = polyline.decode(encodedString);

      const offerRoute = new OfferRoute({
        polylineStart: {
          type: "LineString",
          coordinates: results,
        },

        polylineEnd: {
          type: "LineString",
          coordinates: results,
        },

        from: startPoint,
        to: endPoint,
      });

      offerRoute.save();
      //   console.log(secondHalf);
      console.log(results);
    })
    .catch(function (error) {
      console.log(error);
    });
};
