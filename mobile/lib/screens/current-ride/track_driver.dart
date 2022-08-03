import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_map_polyline_new/google_map_polyline_new.dart';
import 'package:flutter_countdown_timer/index.dart';
import 'package:location/location.dart';
import 'package:mobile/screens/home/rider_home.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

import 'package:mobile/colors.dart';
import 'package:mobile/custom/wide_button.dart';
import 'package:mobile/fonts.dart';
import 'package:mobile/models/user_model.dart';
import 'package:mobile/screens/current-ride/driver_nav.dart';
import 'package:mobile/utils/widget_functions.dart';

class TrackDriver extends StatefulWidget {
  const TrackDriver({Key? key}) : super(key: key);

  @override
  State<TrackDriver> createState() => _TrackDriverState();
}

class _TrackDriverState extends State<TrackDriver> {
  int rideArrivalTime = DateTime.now().millisecondsSinceEpoch +
      const Duration(minutes: 30).inMilliseconds;
  late CountdownTimerController timerController;
  final User currentUser = User(
    firstName: 'Nethmi',
    lastName: 'Doe',
    email: 'nethmi@gmail.com',
    gender: 'female',
  );

  final LatLng pickupLoc = const LatLng(6.881727666204392, 79.8696165771317);
  final LatLng startPoint = const LatLng(6.858241522234863, 79.87051579562947);
  final LatLng dropOffLoc = const LatLng(6.9037311247468995, 79.8611484867312);
  LatLng driverLoc = const LatLng(0.0, 0.0);
  LocationData? currentLocation;
  final Completer<GoogleMapController> _controller = Completer();
  final MapType _currentMapType = MapType.normal;

  List<LatLng>? _coordinates;
  late GoogleMapPolyline googleMapPolyline;

  BitmapDescriptor startPointMarker = BitmapDescriptor.defaultMarker;
  BitmapDescriptor pickupLocMarker = BitmapDescriptor.defaultMarker;
  BitmapDescriptor dropOffLocMarker = BitmapDescriptor.defaultMarker;
  BitmapDescriptor currentLocationMarker = BitmapDescriptor.defaultMarker;
  BitmapDescriptor driverMarker = BitmapDescriptor.defaultMarker;
  String? apiKey;

  LatLng camPosition = const LatLng(0, 0);
  bool isDriverAvailable = false;
  bool driverArrived = false;

  late IO.Socket socket;

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
    initSocket();
    apiKey = dotenv.env['MAPS_API_KEY'];
    googleMapPolyline = GoogleMapPolyline(apiKey: apiKey!);
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
    try {
      socket = IO.io("http://3.1.170.150:3700", <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': true,
      });

      socket.connect();
      socket.on("position-change", (data) async {
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
            zoom: 12,
          )));
        });
      });
    } catch (e) {
      print(e.toString());
    }
  }

  void getCurrentLocation() async {
    Location location = Location();

    location.getLocation().then((location) {
      setState(() {
        currentLocation = location;
      });
    });

    location.onLocationChanged.listen((newLocation) {
      setState(() {
        currentLocation = newLocation;
      });
    });
  }

  void getEstimatedArivalTime() async {
    Dio dio = new Dio();

    try {
      Response response = await dio.get(
          "https://maps.googleapis.com/maps/api/distancematrix/json?origins=6.857870456227357%2C79.87058268465782&destinations=6.029392%2C80.215113&key=$apiKey&mode=driving");

      print(response.data);

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

  void _whenDriverArrived() {
    setState(() {
      driverArrived = true;
      print('Driver arrived');
    });
  }

  void setCustomMarkers() {
    // Create custom icons
    BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty,
      "assets/images/source-pin-black.png",
    ).then((icon) {
      setState(() {
        pickupLocMarker = icon;
      });
    });

    BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty,
      "assets/images/source-pin-grey.png",
    ).then((icon) {
      setState(() {
        startPointMarker = icon;
      });
    });

    BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty,
      "assets/images/location-pin-orange.png",
    ).then((icon) {
      setState(() {
        dropOffLocMarker = icon;
      });
    });

    BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty,
      "assets/images/car-pin-black.png",
    ).then((icon) {
      setState(() {
        driverMarker = icon;
      });
    });

    BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty,
      "assets/images/radio-blue.png",
    ).then((icon) {
      setState(() {
        currentLocationMarker = icon;
      });
    });
  }

  void getPolyPoints() async {
    List<LatLng>? coords = await googleMapPolyline.getCoordinatesWithLocation(
        origin: startPoint, destination: dropOffLoc, mode: RouteMode.driving);
    setState(() {
      _coordinates = coords;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    const double padding = 16;
    const sidePadding = EdgeInsets.symmetric(horizontal: padding);

    return Scaffold(
      body: (currentLocation == null || _coordinates == null)
          ? const Center(
            child: CircularProgressIndicator(
                value: null,
                semanticsLabel: 'Please wait',
                color: BlipColors.grey,
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
                          'Hey ${currentUser.firstName}!\nYour ride will be here in',
                          style: BlipFonts.title,
                          textAlign: TextAlign.center,
                        ),
                  CountdownTimer(
                    controller: timerController,
                    widgetBuilder: (_, CurrentRemainingTime? time) {
                      if (time == null) {
                        return const Text(
                          'Your ride is here!',
                          style: BlipFonts.labelBold,
                          textAlign: TextAlign.center,
                        );
                      }
                      return Column(
                        children: [
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
                      myLocationEnabled: true,
                      initialCameraPosition: CameraPosition(
                        target: pickupLoc,
                        zoom: 13.0,
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
                          markerId: const MarkerId('source'),
                          position: startPoint,
                          icon: startPointMarker,
                        ),
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
