import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_map_polyline_new/google_map_polyline_new.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:location/location.dart';

import 'package:mobile/colors.dart';

class DriverNav extends StatefulWidget {
  const DriverNav({Key? key}) : super(key: key);

  @override
  State<DriverNav> createState() => _DriverNavState();
}

class _DriverNavState extends State<DriverNav> {
  final LatLng startPoint = const LatLng(6.858241522234863, 79.87051579562947);
  final LatLng destination = const LatLng(6.9037311247468995, 79.8611484867312);
  final Completer<GoogleMapController> _controller = Completer();
  final MapType _currentMapType = MapType.normal;
  GoogleMapController? mapController;

  List<LatLng>? _coordinates;
  late GoogleMapPolyline googleMapPolyline;

  LocationData? currentLocation;

  Set<Marker> _markers = {};
  BitmapDescriptor startMarker = BitmapDescriptor.defaultMarker;
  BitmapDescriptor destinationMarker = BitmapDescriptor.defaultMarker;
  BitmapDescriptor currentLocationMarker = BitmapDescriptor.defaultMarker;

  late IO.Socket socket;

  @override
  void initState() {
    super.initState();
    initSocket();
    String? apiKey = dotenv.env['MAPS_API_KEY'];
    googleMapPolyline = GoogleMapPolyline(apiKey: apiKey!);
    getPolyPoints();
    getCurrentLocation();
    setCustomMarkers();
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  void _onCameraMove(CameraPosition position) {}

  void getCurrentLocation() async {
    Location location = Location();

    location.getLocation().then((location) {
      setState(() {
        currentLocation = location;
        sendLocation();
      });
    });

    GoogleMapController googleMapController = await _controller.future;

    location.onLocationChanged.listen((newLocation) {
      setState(() {
        currentLocation = newLocation;
        googleMapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(newLocation.latitude!, newLocation.longitude!),
              zoom: 18,
            ),
          ),
        );
        sendLocation();
      });
    });
  }

  void getPolyPoints() async {
    List<LatLng>? coords = await googleMapPolyline.getCoordinatesWithLocation(
        origin: startPoint, destination: destination, mode: RouteMode.driving);
    setState(() {
      _coordinates = coords;
    });
  }

  void setCustomMarkers() {
    // Create custom icons
    BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty,
      "assets/images/source-pin-black.png",
    ).then((icon) {
      setState(() {
        startMarker = icon;
      });
    });

    BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty,
      "assets/images/location-pin-orange.png",
    ).then((icon) {
      setState(() {
        destinationMarker = icon;
      });
    });

    BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty,
      "assets/images/car-pin-black.png",
    ).then((icon) {
      setState(() {
        currentLocationMarker = icon;
      });
    });
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

  void sendLocation() {
    var coords = {
      'lat': currentLocation!.latitude!,
      'lng': currentLocation!.latitude!
    };
    socket.emit('position-change', jsonEncode(coords));
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: (currentLocation == null || _coordinates == null)
          ? const Center(
            child: CircularProgressIndicator(
                value: null,
                semanticsLabel: 'Please wait',
                color: BlipColors.grey,
              ),
          )
          : Container(
              height: size.height,
              color: BlipColors.lightGrey,
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: startPoint,
                  zoom: 13.0,
                ),
                mapType: _currentMapType,
                polylines: {
                  Polyline(
                    polylineId: const PolylineId("route"),
                    color: BlipColors.blue,
                    points: _coordinates!,
                    width: 5,
                    onTap: () {},
                  )
                },
                markers: {
                  Marker(
                    markerId: const MarkerId('currentLocation'),
                    position: LatLng(
                      currentLocation!.latitude!,
                      currentLocation!.longitude!,
                    ),
                    icon: currentLocationMarker,
                  ),
                  Marker(
                    markerId: const MarkerId('source'),
                    position: startPoint,
                    icon: startMarker,
                  ),
                  Marker(
                    markerId: const MarkerId('destination'),
                    position: destination,
                    icon: destinationMarker,
                  ),
                },
                onCameraMove: _onCameraMove,
              ),
            ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    socket.disconnect();
  }
}
