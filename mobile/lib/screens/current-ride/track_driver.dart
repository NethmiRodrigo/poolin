import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_map_polyline_new/google_map_polyline_new.dart';
import 'package:flutter_countdown_timer/index.dart';
import 'package:location/location.dart';
import 'package:poolin/cubits/active_ride_cubit.dart';
import 'package:poolin/cubits/current_user_cubit.dart';
import 'package:poolin/screens/home/rider_home.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

import 'package:poolin/colors.dart';
import 'package:poolin/custom/wide_button.dart';
import 'package:poolin/fonts.dart';
import 'package:poolin/screens/current-ride/driver_nav.dart';
import 'package:poolin/utils/widget_functions.dart';

class TrackDriver extends StatefulWidget {
  const TrackDriver({Key? key}) : super(key: key);

  @override
  State<TrackDriver> createState() => _TrackDriverState();
}

class _TrackDriverState extends State<TrackDriver> {
  int rideArrivalTime = DateTime.now().millisecondsSinceEpoch +
      const Duration(minutes: 15).inMilliseconds;
  late CountdownTimerController timerController;
  late ActiveRideCubit activeRideCubit;

  late LatLng pickupLoc;
  late LatLng dropOffLoc;
  LatLng driverLoc = const LatLng(6.806744952118697, 79.92244836145672);

  LocationData? currentLocation;

  final Completer<GoogleMapController> _controller = Completer();
  final MapType _currentMapType = MapType.normal;

  List<LatLng>? _coordinates;
  late GoogleMapPolyline googleMapPolyline;

  BitmapDescriptor pickupLocMarker = BitmapDescriptor.defaultMarker;
  BitmapDescriptor dropOffLocMarker = BitmapDescriptor.defaultMarker;
  BitmapDescriptor currentLocationMarker = BitmapDescriptor.defaultMarker;
  BitmapDescriptor driverMarker = BitmapDescriptor.defaultMarker;
  String? apiKey;

  LatLng camPosition = const LatLng(0, 0);
  bool isDriverAvailable = false;
  bool driverArrived = false;
  bool isLoading = false;

  late io.Socket socket;

  @override
  void initState() {
    super.initState();
    isLoading = true;
    apiKey = dotenv.env['MAPS_API_KEY'];
    activeRideCubit = BlocProvider.of<ActiveRideCubit>(context);
    googleMapPolyline = GoogleMapPolyline(apiKey: apiKey!);
    pickupLoc = LatLng(
      activeRideCubit.state.source.lat,
      activeRideCubit.state.source.lang,
    );
    dropOffLoc = LatLng(
      activeRideCubit.state.destination.lat,
      activeRideCubit.state.destination.lang,
    );
    getCurrentLocation();
    initSocket();
    setCustomMarkers();
    getPolyPoints();
    timerController =
        CountdownTimerController(endTime: rideArrivalTime, onEnd: () => {});
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  void _onCameraMove(CameraPosition position) {
    setState(() {
      camPosition = position.target;
    });
  }

  Future<void> initSocket() async {
    String? socketServer = dotenv.env['LOCATION_SERVER'];

    try {
      socket = io.io(socketServer, <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': true,
      });

      socket.connect();
      socket.on("position-change", (data) async {
        setState(() {
          isLoading = false;
        });
        var latLng = jsonDecode(data);

        final GoogleMapController controller = await _controller.future;

        setState(() {
          driverLoc = LatLng(latLng["lat"], latLng["lng"]);
          if (isDriverAvailable == false) {
            getEstimatedArivalTime();
            isDriverAvailable = true;
          }
          controller
              .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
            target: driverLoc,
            zoom: 14,
          )));
        });
      });
    } catch (e) {
      print(e.toString());
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

  void getEstimatedArivalTime() async {
    Dio dio = Dio();
    String? apiURL = dotenv.env['DISTANCE_MATRIX_API_URL'];

    try {
      Response response = await dio.get(
          "$apiURL?origins=${driverLoc.latitude}%2C${driverLoc.longitude}&destinations=${pickupLoc.latitude}%2C${pickupLoc.longitude}&key=$apiKey&mode=driving");

      if (response.data["rows"][0]["elements"][0]["status"] == "OK") {
        int seconds =
            response.data["rows"][0]["elements"][0]["duration"]["value"];

        setState(() {
          rideArrivalTime =
              DateTime.now().millisecondsSinceEpoch + seconds * 1000;
          timerController = CountdownTimerController(
              endTime: rideArrivalTime, onEnd: () => {});
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> setCustomMarkers() async {
    BitmapDescriptor blackSourceIcon = await BitmapDescriptor.fromAssetImage(
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

    BitmapDescriptor blueIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty,
      "assets/images/radio-blue.png",
    );

    setState(() {
      currentLocationMarker = blueIcon;
      pickupLocMarker = blackSourceIcon;
      dropOffLocMarker = destinationIcon;
      driverMarker = carIcon;
    });
  }

  void getPolyPoints() async {
    List<LatLng>? coords = await googleMapPolyline.getCoordinatesWithLocation(
        origin: pickupLoc, destination: dropOffLoc, mode: RouteMode.driving);
    setState(() {
      _coordinates = coords;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    const double padding = 16;
    const sidePadding = EdgeInsets.symmetric(horizontal: padding);
    final CurrentUserCubit currentUser =
        BlocProvider.of<CurrentUserCubit>(context);

    return Scaffold(
      body: (isLoading || currentLocation == null || _coordinates == null)
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
                  driverArrived
                      ? const Text(
                          'Your ride is here!\nCheck in soon',
                          style: BlipFonts.title,
                          textAlign: TextAlign.center,
                        )
                      : Text(
                          'Hey ${currentUser.state.firstName}!\nYour ride will be here in',
                          style: BlipFonts.title,
                          textAlign: TextAlign.center,
                        ),
                  addVerticalSpace(24),
                  !driverArrived
                      ? CountdownTimer(
                          controller: timerController,
                          widgetBuilder: (_, CurrentRemainingTime? time) {
                            if (time == null) {
                              return const Text(
                                '00 : 00',
                                style: BlipFonts.display,
                                textAlign: TextAlign.center,
                              );
                            }
                            return Text(
                              '${time.min == null ? '00' : time.min.toString().padLeft(2, '0')} : ${time.sec == null ? '00' : time.sec.toString().padLeft(2, '0')}',
                              style: BlipFonts.display,
                              textAlign: TextAlign.center,
                            );
                          },
                        )
                      : Container(),
                  addVerticalSpace(24),
                  Container(
                    height: size.width * 0.8,
                    color: BlipColors.lightGrey,
                    child: GoogleMap(
                      myLocationEnabled: true,
                      initialCameraPosition: CameraPosition(
                        target: pickupLoc,
                        zoom: 15.0,
                      ),
                      mapType: _currentMapType,
                      onMapCreated: _onMapCreated,
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
                          infoWindow: const InfoWindow(
                            title: 'You are here',
                          ),
                        ),
                        (driverLoc != const LatLng(0, 0))
                            ? Marker(
                                markerId: const MarkerId('driver'),
                                position: driverLoc,
                                icon: driverMarker,
                                infoWindow: const InfoWindow(
                                  title: 'Driver is here',
                                ),
                              )
                            : const Marker(markerId: MarkerId('NA')),
                        Marker(
                          markerId: const MarkerId('pickUp'),
                          position: pickupLoc,
                          icon: pickupLocMarker,
                          infoWindow: const InfoWindow(
                            title: 'Pickup Location',
                          ),
                        ),
                        Marker(
                          markerId: const MarkerId('dropOff'),
                          position: dropOffLoc,
                          icon: dropOffLocMarker,
                          infoWindow: const InfoWindow(
                            title: 'Your stop',
                          ),
                        ),
                      },
                      onCameraMove: _onCameraMove,
                    ),
                  ),
                  addVerticalSpace(16),
                  driverArrived
                      ? WideButton(
                          text: 'Check in',
                          onPressedAction: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const RiderHomeScreen()),
                            );
                          })
                      : WideButton(
                          text: 'Cancel Ride',
                          onPressedAction: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const RiderHomeScreen()),
                            );
                          }),
                  addVerticalSpace(8),
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(
                          text: 'Any problems? ',
                          style: BlipFonts.label
                              .merge(const TextStyle(color: BlipColors.black))),
                      TextSpan(
                          text: 'Tell the driver',
                          style: BlipFonts.label
                              .merge(const TextStyle(color: BlipColors.black)),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const DriverNav()),
                              );
                            }),
                    ]),
                  ),
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
