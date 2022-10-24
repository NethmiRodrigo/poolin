import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_countdown_timer/index.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'dart:async';

import 'package:poolin/colors.dart';
import 'package:poolin/cubits/active_ride_cubit.dart';
import 'package:poolin/cubits/current_user_cubit.dart';
import 'package:poolin/custom/wide_button.dart';
import 'package:poolin/fonts.dart';
import 'package:poolin/screens/current-ride/driver_nav.dart';
import 'package:poolin/services/distance_duration_service.dart';
import 'package:poolin/utils/widget_functions.dart';

class StartRide extends StatefulWidget {
  const StartRide({Key? key}) : super(key: key);

  @override
  State<StartRide> createState() => _StartRideState();
}

class _StartRideState extends State<StartRide> {
  late CountdownTimerController timerController;
  late ActiveRideCubit activeRideCubit;
  late CurrentUserCubit currentUserCubit;

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

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
    activeRideCubit = BlocProvider.of<ActiveRideCubit>(context);
    currentUserCubit = BlocProvider.of<CurrentUserCubit>(context);
    startPoint = LatLng(
        activeRideCubit.state.source.lat, activeRideCubit.state.source.lang);
    destination = LatLng(activeRideCubit.state.destination.lat,
        activeRideCubit.state.destination.lang);
    setCustomMarkers();
    setRouteCheckPoints();
    getPolyPoints();
    timerController = CountdownTimerController(
        endTime: activeRideCubit.state.departureTime!.millisecondsSinceEpoch);
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

  void getCurrentLocation() async {
    Location location = Location();
    LocationData? result = await location.getLocation();

    setState(() {
      currentLocation = result;
    });

    location.onLocationChanged.listen((newLocation) {
      setState(() {
        currentLocation = newLocation;
      });
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
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

  void setCustomMarkers() async {
    //Create custom icons
    BitmapDescriptor startIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty,
      "assets/images/source-pin-black.png",
    );

    BitmapDescriptor destinationIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty,
      "assets/images/location-pin-orange.png",
    );

    BitmapDescriptor currentLocIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty,
      "assets/images/car-pin-black.png",
    );

    setState(() {
      currentLocationMarker = currentLocIcon;
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

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    const double padding = 16;
    const sidePadding = EdgeInsets.symmetric(horizontal: padding);

    return Scaffold(
      body: (currentLocation == null || polylines.isEmpty)
          ? const Center(
              child: CircularProgressIndicator(
                color: BlipColors.orange,
              ),
            )
          : SingleChildScrollView(
              padding: sidePadding,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: size.height * 0.1),
                  CountdownTimer(
                    controller: timerController,
                    widgetBuilder: (_, CurrentRemainingTime? time) {
                      if (time == null) {
                        return const Text(
                          'Time for your ride!\nStart now',
                          style: BlipFonts.title,
                          textAlign: TextAlign.center,
                        );
                      }
                      return Column(
                        children: [
                          Text(
                            'Hey ${currentUserCubit.state.firstName}!\nYour ride starts in,',
                            style: BlipFonts.title,
                            textAlign: TextAlign.center,
                          ),
                          addVerticalSpace(24),
                          Text(
                            '${time.min == null ? '00' : time.min.toString().padLeft(2, '0')} : ${time.sec == null ? '00' : time.sec.toString().padLeft(2, '0')}',
                            style: BlipFonts.display,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      );
                    },
                  ),
                  addVerticalSpace(24),
                  Container(
                    height: size.width * 0.8,
                    color: BlipColors.lightGrey,
                    child: GoogleMap(
                      onMapCreated: _onMapCreated,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(
                          currentLocation!.latitude!,
                          currentLocation!.longitude!,
                        ),
                        zoom: 14.0,
                      ),
                      mapType: _currentMapType,
                      polylines: Set<Polyline>.of(polylines.values),
                      markers: {
                        ..._markers,
                        Marker(
                          markerId: const MarkerId('currentLocation'),
                          position: LatLng(
                            currentLocation!.latitude!,
                            currentLocation!.longitude!,
                          ),
                          icon: currentLocationMarker,
                        ),
                      },
                      myLocationButtonEnabled: true,
                      myLocationEnabled: false,
                    ),
                  ),
                  addVerticalSpace(16),
                  WideButton(
                      text: 'Start',
                      onPressedAction: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const DriverNav()),
                        );
                      }),
                  addVerticalSpace(8),
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(
                          text: 'Any problems? ',
                          style: BlipFonts.outline
                              .merge(const TextStyle(color: BlipColors.black))),
                      TextSpan(
                          text: 'Tell the riders',
                          style: BlipFonts.outlineBold
                              .merge(const TextStyle(color: BlipColors.orange)),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const DriverNav()),
                              );
                            }),
                    ]),
                  )
                ],
              ),
            ),
    );
  }

  @override
  void dispose() {
    timerController.dispose();
    super.dispose();
  }
}
