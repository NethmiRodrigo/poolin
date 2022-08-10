import { OfferRoute } from "../database/entity/OfferRoute";

export const getPolyline = () => {
  var axios = require("axios");

  const api_key = "AIzaSyB5PFapIypRNpwikmNQG3WNbi2JUHOpgoQ";

  /**
   * refer to https://developers.google.com/maps/documentation/directions/get-directions#DirectionsRequests for more info
   */

  // coordinates of start point appended with '%2C'
  const startPoint = "University of Colombo School of Computing, Colombo";

  // coordinates of end point appended with '%2C'
  const endPoint = "Nugegoda";

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
      const middleIndex = Math.ceil(results.length / 2);

      const firstHalf = results.slice().splice(0, middleIndex);
      const secondHalf = results.slice().splice(-middleIndex);

      const offerRoute = new OfferRoute({
        polylineStart: {
          type: "LineString",
          coordinates: firstHalf,
        },
        polylineEnd: {
          type: "LineString",
          coordinates: secondHalf,
        },
        from: startPoint,
        to: endPoint,
      });

      offerRoute.save();
      console.log(secondHalf);
      console.log(results);
    })
    .catch(function (error) {
      console.log(error);
    });
};
