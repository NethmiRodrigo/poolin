import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_map_polyline_new/google_map_polyline_new.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:mobile/colors.dart';
import 'package:mobile/custom/wide_button.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class DriverNav extends StatefulWidget {
  const DriverNav({Key? key}) : super(key: key);

  @override
  State<DriverNav> createState() => _DriverNavState();
}

class _DriverNavState extends State<DriverNav> {
  late IO.Socket socket;
  double? latitude = 3.33;
  double? longitude = 0.111;

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

  @override
  void initState() {
    super.initState();
    String? apiKey = dotenv.env['MAPS_API_KEY'];
    googleMapPolyline = GoogleMapPolyline(apiKey: apiKey!);
    generateRoute();
    _setMarkers();
    initSocket();
  }

  void _onCameraMove(CameraPosition position) {
    _sendLocation();
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  void _setMarkers() {
    _markers = {
      Marker(markerId: const MarkerId('0'), position: startPoint),
      Marker(markerId: const MarkerId('1'), position: destination),
    };
    _center = startPoint;
  }

  void _mockMovement() {
    if (_coordinates != null) {
      print('traversing list');
      _coordinates!.forEach((coord) => print(coord));
    }
  }

  Future<void> initSocket() async {
    try {
      socket = IO.io("http://3.1.170.150:3700", <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': true,
      });

      socket.connect();

      socket.onConnect((data) => {print('Connect: ${socket.id}')});
    } catch (e) {
      print(e.toString());
    }
  }

  void generateRoute() async {
    List<LatLng>? _coordinates =
        await googleMapPolyline.getCoordinatesWithLocation(
            origin: startPoint,
            destination: destination,
            mode: RouteMode.driving);

    setState(() {
      _polylines.clear();
    });
    _addPolyline(_coordinates);
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

  void _sendLocation() {
    var coords = {'lat': latitude, 'lng': longitude};
    socket.emit('position-change', jsonEncode(coords));
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    const double padding = 16;
    const sidePadding = EdgeInsets.symmetric(horizontal: padding);

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: size.width,
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 15.0,
              ),
              mapType: _currentMapType,
              
              markers: _markers,
              onCameraMove: _onCameraMove,
            ),
          ),
          WideButton(
              text: 'Share my Location',
              onPressedAction: () {
                _mockMovement();
              }),
        ],
      ),
    );
  }

  @override
  void dispose() {
    socket.disconnect();
    super.dispose();
  }
}
