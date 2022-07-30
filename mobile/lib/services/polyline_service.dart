import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobile/colors.dart';

String? apiKey = dotenv.env['MAPS_API_KEY'];

Map<PolylineId, Polyline> polylines = {};
List<LatLng> polylineCoordinates = [];
PolylinePoints polylinePoints = PolylinePoints();

_addPolyLine() {
  polylines = {};
  PolylineId id = const PolylineId("poly");
  Polyline polyline = Polyline(
      polylineId: id,
      color: BlipColors.orange,
      points: polylineCoordinates,
      width: 2);
  polylines[id] = polyline;
}

getPolyline(sourceLatitude, sourceLongitude, destinationLatitude,
    destinationLongitude) async {
  polylineCoordinates = [];
  PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      apiKey!,
      PointLatLng(sourceLatitude, sourceLongitude),
      PointLatLng(destinationLatitude, destinationLongitude),
      travelMode: TravelMode.driving);
  if (result.points.isNotEmpty) {
    for (var point in result.points) {
      polylineCoordinates.add(LatLng(point.latitude, point.longitude));
    }
  }
  _addPolyLine();
  return polylines;
}
