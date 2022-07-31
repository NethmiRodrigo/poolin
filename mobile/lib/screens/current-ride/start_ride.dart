import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_map_polyline_new/google_map_polyline_new.dart';
import 'package:flutter_countdown_timer/index.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'dart:async';

import 'package:mobile/colors.dart';
import 'package:mobile/custom/wide_button.dart';
import 'package:mobile/fonts.dart';
import 'package:mobile/models/user_model.dart';
import 'package:mobile/screens/current-ride/driver_nav.dart';
import 'package:mobile/screens/current-ride/driver_nav.dart';
import 'package:mobile/utils/widget_functions.dart';

class StartRide extends StatefulWidget {
  const StartRide({Key? key}) : super(key: key);

  @override
  State<StartRide> createState() => _StartRideState();
}

class _StartRideState extends State<StartRide> {
  int rideStartTime = DateTime.now().millisecondsSinceEpoch +
      const Duration(days: 1, hours: 2, minutes: 30).inMilliseconds;
  late CountdownTimerController timerController;
  final User currentUser = User(
    firstName: 'Yadeesha',
    lastName: 'Doe',
    email: 'yadeesha@gmail.com',
    gender: 'female',
  );

  final LatLng startPoint = const LatLng(6.9018871, 79.8604377);
  final LatLng destination = const LatLng(6.9037302, 79.8595853);
  final Completer<GoogleMapController> _controller = Completer();
  final MapType _currentMapType = MapType.normal;

  List<LatLng>? _coordinates;
  late GoogleMapPolyline googleMapPolyline;

  LocationData? currentLocation;

  Set<Marker> _markers = {};
  BitmapDescriptor startMarker = BitmapDescriptor.defaultMarker;
  BitmapDescriptor destinationMarker = BitmapDescriptor.defaultMarker;
  BitmapDescriptor currentLocationMarker = BitmapDescriptor.defaultMarker;

  @override
  void initState() {
    super.initState();
    String? apiKey = dotenv.env['MAPS_API_KEY'];
    googleMapPolyline = GoogleMapPolyline(apiKey: apiKey!);
    getPolyPoints();
    getCurrentLocation();
    timerController =
        CountdownTimerController(endTime: rideStartTime, onEnd: () => {});
    setCustomMarkers();
  }

  void getCurrentLocation() async {
    Location location = Location();

    location.getLocation().then((location) {
      setState(() {
        currentLocation = location;
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
      });
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
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
      "assets/images/source_pin.png",
    ).then((icon) {
      setState(() {
        startMarker = icon;
      });
    });

    BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty,
      "assets/images/destination_pin.png",
    ).then((icon) {
      setState(() {
        destinationMarker = icon;
      });
    });

    BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty,
      "assets/images/car_pin.png",
    ).then((icon) {
      setState(() {
        currentLocationMarker = icon;
      });
    });

    // Create markers
    _markers = {
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
    };
  }

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
            SizedBox(height: size.height * 0.1),
            Text(
              'Hey ${currentUser.firstName}!\nYour ride starts in,',
              style: BlipFonts.title,
              textAlign: TextAlign.center,
            ),
            CountdownTimer(
              controller: timerController,
              widgetBuilder: (_, CurrentRemainingTime? time) {
                if (time == null) {
                  return const Text(
                    'Start your ride',
                    style: BlipFonts.labelBold,
                    textAlign: TextAlign.center,
                  );
                }
                return Column(
                  children: [
                    addVerticalSpace(24),
                    Text(
                      '${time.min.toString().padLeft(2, '0')} : ${time.sec.toString().padLeft(2, '0')}',
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
                  target: startPoint,
                  zoom: 15.0,
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
                markers: _markers,
              ),
            ),
            addVerticalSpace(16),
            WideButton(
                text: 'Start',
                onPressedAction: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const DriverNav()),
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
