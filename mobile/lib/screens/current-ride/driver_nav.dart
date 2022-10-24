import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:poolin/cubits/active_ride_cubit.dart';
import 'package:poolin/screens/current-ride/driver_timeline.dart';
import 'package:poolin/screens/current-ride/final_ride_details.dart';
import 'package:poolin/services/polyline_service.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:location/location.dart';

import 'package:poolin/colors.dart';

class DriverNav extends StatefulWidget {
  const DriverNav({Key? key}) : super(key: key);

  @override
  State<DriverNav> createState() => _DriverNavState();
}

class _DriverNavState extends State<DriverNav> {
  late ActiveRideCubit activeRideCubit;

  late LatLng startPoint;
  late LatLng destination;
  LocationData? currentLocation;

  final Completer<GoogleMapController> _controller = Completer();
  final MapType _currentMapType = MapType.normal;

  // all the pickups and dropoffs
  List<PolylineWayPoint> routeCheckpoints = [];
  final Set<Marker> _markers = {};
  Map<PolylineId, Polyline> polylines = {};
  PolylinePoints polylinePoints = PolylinePoints();

  BitmapDescriptor startMarker = BitmapDescriptor.defaultMarker;
  BitmapDescriptor destinationMarker = BitmapDescriptor.defaultMarker;
  BitmapDescriptor currentLocationMarker = BitmapDescriptor.defaultMarker;

  bool isLoading = false;

  late io.Socket socket;

  @override
  void initState() {
    super.initState();
     activeRideCubit = BlocProvider.of<ActiveRideCubit>(context);
    startPoint = LatLng(
        activeRideCubit.state.source.lat, activeRideCubit.state.source.lang);
    destination = LatLng(activeRideCubit.state.destination.lat,
        activeRideCubit.state.destination.lang);
    setCustomMarkers();
    getCurrentLocation();
    setRouteCheckPoints();
    getPolyPoints();
    initSocket();
  }
  
  void setRouteCheckPoints() {
    for (var pass in activeRideCubit.state.partyData) {
      // passenger's pickup
      routeCheckpoints.add(PolylineWayPoint(
          location: "${pass.pickupLocation.lat},${pass.pickupLocation.lang}"));
      // passenger's dropoff
      routeCheckpoints.add(PolylineWayPoint(
          location:
              "${pass.dropoffLocation.lat},${pass.dropoffLocation.lang}"));
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  void _onCameraMove(CameraPosition position) {}

  void getCurrentLocation() async {
    Location location = Location();
    LocationData? result = await location.getLocation();

    setState(() {
      currentLocation = result;
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
    List<LatLng> coordinates = [];
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        apiKey!,
        PointLatLng(startPoint.latitude, startPoint.longitude),
        PointLatLng(destination.latitude, destination.longitude),
        wayPoints: routeCheckpoints);

    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        coordinates.add(LatLng(point.latitude, point.longitude));
      }
    } else {
      print(result.errorMessage);
    }
    _addPolyLine(coordinates);
  }

  _addPolyLine(List<LatLng> polylineCoords) {
    PolylineId id = const PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: BlipColors.blue,
      points: polylineCoords,
      width: 5,
    );
    polylines[id] = polyline;
    setState(() {});
  }

  Future<void> setCustomMarkers() async {
    BitmapDescriptor startIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty,
      "assets/images/source-pin-black.png",
    );

    BitmapDescriptor destinationIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty,
      "assets/images/location-pin-orange.png",
    );

    BitmapDescriptor carIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty,
      "assets/images/car-pin-black.png",
    );

    setState(() {
      currentLocationMarker = carIcon;
      destinationMarker = destinationIcon;
      startMarker = startIcon;
    });

    // driver's start
    _markers.add(
      Marker(
        markerId: const MarkerId('Your start'),
        position: startPoint,
        infoWindow: InfoWindow(
          title: 'Your start here',
          snippet: activeRideCubit.state.source.name,
        ),
        icon: startMarker,
      ),
    );

    // driver's destination
    _markers.add(
      Marker(
        markerId: const MarkerId('Your destination'),
        position: destination,
        infoWindow: InfoWindow(
          title: 'Your end here',
          snippet: activeRideCubit.state.destination.name,
        ),
        icon: destinationMarker,
      ),
    );

    for (var pass in activeRideCubit.state.partyData) {
      // passenger's pickup
      _markers.add(
        Marker(
          markerId: MarkerId('Pickup ${pass.firstname}'),
          position: LatLng(pass.pickupLocation.lat, pass.pickupLocation.lang),
          infoWindow: InfoWindow(
            title: pass.firstname,
            snippet: 'Pickup at ${pass.pickupLocation.name}',
          ),
          icon: startMarker,
        ),
      );

      // passenger's dropoff
      _markers.add(
        Marker(
          markerId: MarkerId('Dropoff ${pass.firstname}'),
          position: LatLng(pass.dropoffLocation.lat, pass.dropoffLocation.lang),
          infoWindow: InfoWindow(
            title: pass.firstname,
            snippet: 'Dropoff at ${pass.dropoffLocation.name}',
          ),
          icon: destinationMarker,
        ),
      );
    }
  }

  Future<void> initSocket() async {
    String? socketServer = dotenv.env['LOCATION_SERVER'];

    try {
      socket = io.io(socketServer, <String, dynamic>{
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
      'lng': currentLocation!.longitude!
    };
    socket.emit('position-change', jsonEncode(coords));
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const CircleAvatar(
            backgroundColor: BlipColors.white,
            child: Icon(Icons.arrow_back, color: BlipColors.black),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const FinalRideDetailsScreen()),
            );
          },
        ),
      ),
      body: (currentLocation == null)
          ? const Center(
              child: CircularProgressIndicator(
                color: BlipColors.orange,
              ),
            )
          : Stack(
              children: [
                LayoutBuilder(builder:
                    (BuildContext context, BoxConstraints constraints) {
                  return SizedBox(
                    height: constraints.maxHeight * 0.75,
                    child: GoogleMap(
                      onMapCreated: _onMapCreated,
                      initialCameraPosition: CameraPosition(
                        target: startPoint,
                        zoom: 13.0,
                      ),
                      mapType: _currentMapType,
                      polylines: Set<Polyline>.of(polylines.values),
                      markers: _markers,
                      myLocationButtonEnabled: true,
                      myLocationEnabled: true,
                      onCameraMove: _onCameraMove,
                    ),
                  );
                }),
                DraggableScrollableSheet(
                  initialChildSize: 0.25,
                  minChildSize: 0.25,
                  maxChildSize: 0.25,
                  builder: (context, scrollController) {
                    return Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0),
                        ),
                      ),
                      child: DriverTimeline(),
                    );
                  },
                ),
              ],
            ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    socket.disconnect();
  }
}
