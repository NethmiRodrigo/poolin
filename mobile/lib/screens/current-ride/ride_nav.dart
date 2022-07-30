import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_map_polyline_new/google_map_polyline_new.dart';
import 'package:flutter_countdown_timer/index.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

import 'package:mobile/colors.dart';
import 'package:mobile/custom/wide_button.dart';
import 'package:mobile/fonts.dart';
import 'package:mobile/models/user_model.dart';
import 'package:mobile/screens/current-ride/driver_nav.dart';
import 'package:mobile/utils/widget_functions.dart';

class RideNav extends StatefulWidget {
  const RideNav({Key? key}) : super(key: key);

  @override
  State<RideNav> createState() => _RideNavState();
}

class _RideNavState extends State<RideNav> {
  final LatLng startPoint = const LatLng(6.9020788145677, 79.86035186605507);
  final LatLng destination = const LatLng(6.901226727080122, 79.86455756968157);
  final Completer<GoogleMapController> _controller = Completer();
  late LatLng _center;
  Set<Marker> _markers = {};
  final MapType _currentMapType = MapType.normal;

  List<LatLng>? _coordinates;
  late GoogleMapPolyline googleMapPolyline;
  int _polylineCount = 1;
  final Map<PolylineId, Polyline> _polylines = <PolylineId, Polyline>{};

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  void _setMarkers() {
    setState(() {
      _markers = {
        Marker(markerId: const MarkerId('0'), position: startPoint),
        Marker(markerId: const MarkerId('1'), position: destination),
      };
    });
    _center = startPoint;
  }

  @override
  void initState() {
    super.initState();
    String? apiKey = dotenv.env['MAPS_API_KEY'];
    googleMapPolyline = GoogleMapPolyline(apiKey: apiKey!);
    generateRoute();
    _setMarkers();
  }

  void generateRoute() async {
    _coordinates = await googleMapPolyline.getCoordinatesWithLocation(
        origin: startPoint, destination: destination, mode: RouteMode.driving);

    setState(() {
      _polylines.clear();
    });
    _addPolyline(_coordinates);
  }

  void _mockMovement() async {
    if (_coordinates != null) {
      GoogleMapController controller = await _controller.future;
      _coordinates!.forEach((coord) {
        print(coord);
        controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: coord,
          zoom: 15,
        )));
        _updateMarker(coord);
      });
    }
  }

  void _updateMarker(LatLng coord) {
    Marker newMarker = Marker(
      markerId: const MarkerId('0'),
      position: coord,
    );

    if (_markers.elementAt(0).markerId == const MarkerId('0')) {
      _markers.remove(_markers.elementAt(0));
      setState(() {
        _markers.add(newMarker);
      });
    }
  }

  _addPolyline(List<LatLng>? _coordinates) {
    PolylineId id = PolylineId("poly$_polylineCount");
    Polyline polyline = Polyline(
        polylineId: id,
        patterns: patterns[0],
        color: BlipColors.blue,
        points: _coordinates!,
        width: 5,
        onTap: () {});

    setState(() {
      _polylines[id] = polyline;
      _polylineCount++;
    });
  }

  //Polyline patterns
  List<List<PatternItem>> patterns = <List<PatternItem>>[
    <PatternItem>[],
    <PatternItem>[PatternItem.dash(30.0), PatternItem.gap(20.0)],
    <PatternItem>[PatternItem.dot, PatternItem.gap(10.0)],
    <PatternItem>[
      PatternItem.dash(30.0),
      PatternItem.gap(20.0),
      PatternItem.dot,
      PatternItem.gap(20.0)
    ],
  ];

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    const double padding = 16;
    const sidePadding = EdgeInsets.symmetric(horizontal: padding);

    return Scaffold(
      body: SingleChildScrollView(
        padding: sidePadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            addVerticalSpace(24),
            Container(
                height: size.width * 0.8,
                color: BlipColors.lightGrey,
                child: GoogleMap(
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: _center,
                      zoom: 15.0,
                    ),
                    mapType: _currentMapType,
                    polylines: Set<Polyline>.of(_polylines.values),
                    markers: _markers)),
            addVerticalSpace(16),
            WideButton(
                text: 'Share my Location',
                onPressedAction: () {
                  _mockMovement();
                }),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
