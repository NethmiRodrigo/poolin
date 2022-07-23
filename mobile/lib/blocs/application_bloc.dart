import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';
import 'package:mobile/colors.dart';
import 'package:mobile/services/geolocator-service.dart';
import 'package:mobile/services/marker_service.dart';
import 'package:mobile/services/places_service.dart';

class ApplicationBloc with ChangeNotifier {
  final geolocatorService = GeolocatorService();
  final placesService = PlacesService();
  final markerService = MarkerService();

  //Variables
  Position? currentLocation;
  late List<AutocompletePrediction> results = [];
  String? apiKey = dotenv.env['MAPS_API_KEY'];
  late GooglePlace googlePlace = GooglePlace(apiKey!);
  StreamController<DetailsResult?> selectedLocation =
      StreamController<DetailsResult>();
  StreamController<LatLngBounds> bounds = StreamController<LatLngBounds>();
  List<Marker> markers = <Marker>[];
  PolylinePoints polylinePoints = PolylinePoints();
  Map<PolylineId, Polyline> polylines = {};
  StreamController<Map<PolylineId, Polyline>> polylineStream =
      StreamController();

  ApplicationBloc() {
    setCurrentLocation();
  }

  setCurrentLocation() async {
    currentLocation = await geolocatorService.getCurrentLocation();
    notifyListeners();
  }

  searchPlaces(String search) async {
    if (search.isNotEmpty) {
      results = await placesService.getAutoComplete(search);
    }
    notifyListeners();
  }

  _addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = const PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: BlipColors.red,
      points: polylineCoordinates,
      width: 5,
    );
    polylineStream.add({id: polyline});
    polylines[id] = polyline;
  }

  addPolylinePoints(double originLatitude, double originLongitude,
      double destLatitude, double destLongitude) async {
    List<LatLng> polylineCoordinates = [];

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      apiKey!,
      PointLatLng(originLatitude, originLongitude),
      PointLatLng(destLatitude, destLongitude),
      travelMode: TravelMode.driving,
    );
    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    }
    _addPolyLine(polylineCoordinates);
    notifyListeners();
  }

  setSelectedLocation(String placeId,
      [double startLat = 6.9157, double startLng = 79.8636]) async {
    markers = [];
    polylines = {};
    final result = await placesService.getPlace(placeId);
    if (result != null) {
      selectedLocation.add(result);
      Marker startMarker = Marker(
          markerId: const MarkerId("destination"),
          draggable: false,
          visible: true,
          position: LatLng(startLat, startLng),
          icon: BitmapDescriptor.defaultMarkerWithHue(90));
      var newMarker = markerService.createMarkerFromPlace(result, false);
      markers.add(newMarker);
      markers.add(startMarker);
      addPolylinePoints(6.9157, 79.8636, result.geometry!.location!.lat!,
          result.geometry!.location!.lng!);

      var _bounds = markerService.bounds(Set<Marker>.of(markers));
      bounds.add(_bounds!);
    }
    results = [];
    notifyListeners();
  }

  clearSelectedLocation() {
    markers = [];
    selectedLocation = StreamController<DetailsResult>();
    results = [];
    notifyListeners();
  }

  @override
  void dispose() {
    selectedLocation.close();
    bounds.close();
    polylineStream.close();
    super.dispose();
  }
}
