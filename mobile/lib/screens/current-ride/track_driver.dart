import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_map_polyline_new/google_map_polyline_new.dart';
import 'package:flutter_countdown_timer/index.dart';
import 'package:location/location.dart';
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
      const Duration(days: 1, hours: 2, minutes: 30).inMilliseconds;
  late CountdownTimerController timerController;
  final User currentUser = User(
    firstName: 'Nethmi',
    lastName: 'Doe',
    email: 'nethmi@gmail.com',
    gender: 'female',
  );

  final LatLng pickupLoc = const LatLng(6.9018871, 79.8604377);
  final LatLng startPoint = const LatLng(6.9018871, 79.8604377);
  final LatLng dropOffLoc = const LatLng(6.9037302, 79.8595853);
  late LatLng _driverLoc;
  LocationData? _currentLocation;
  final Completer<GoogleMapController> _controller = Completer();
  final MapType _currentMapType = MapType.normal;

  List<LatLng>? _coordinates;
  late GoogleMapPolyline googleMapPolyline;

  Set<Marker> _markers = {};
  BitmapDescriptor startPointMarker = BitmapDescriptor.defaultMarker;
  BitmapDescriptor pickupLocMarker = BitmapDescriptor.defaultMarker;
  BitmapDescriptor dropOffLocMarker = BitmapDescriptor.defaultMarker;
  BitmapDescriptor currentLocationMarker = BitmapDescriptor.defaultMarker;
  BitmapDescriptor driverMarker = BitmapDescriptor.defaultMarker;

  late IO.Socket socket;

  @override
  void initState() {
    super.initState();
    initSocket();
    getCurrentLocation();
    setCustomMarkers();
    getPolyPoints();
    timerController =
        CountdownTimerController(endTime: rideArrivalTime, onEnd: () => {});
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  Future<void> initSocket() async {
    try {
      socket = IO.io("http://${dotenv.env['SOCKET_SERVER']}", <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': true,
      });

      socket.connect();
      socket.on("position-change", (data) async {
        var latLng = jsonDecode(data);
        // final GoogleMapController controller = await _controller.future;
        // controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        //   target: LatLng(latLng["lat"], latLng["lng"]),
        //   zoom: 19,
        // )));
        setState(() {
          _driverLoc = LatLng(latLng["lat"], latLng["lng"]);
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
        _currentLocation = location;
      });
    });

    GoogleMapController googleMapController = await _controller.future;

    location.onLocationChanged.listen((newLocation) {
      setState(() {
        _currentLocation = newLocation;
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

  void setCustomMarkers() {
    // Create custom icons
    BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty,
      "assets/images/source_pin.png",
    ).then((icon) {
      setState(() {
        pickupLocMarker = icon;
      });
    });

    BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty,
      "assets/images/source_pin.png",
    ).then((icon) {
      setState(() {
        startPointMarker = icon;
      });
    });

    BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty,
      "assets/images/destination_pin.png",
    ).then((icon) {
      setState(() {
        dropOffLocMarker = icon;
      });
    });

    BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty,
      "assets/images/car_pin.png",
    ).then((icon) {
      setState(() {
        driverMarker = icon;
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
          _currentLocation!.latitude!,
          _currentLocation!.longitude!,
        ),
        icon: currentLocationMarker,
      ),
      Marker(
        markerId: const MarkerId('driver'),
        position: _driverLoc,
        icon: driverMarker,
      ),
      Marker(
        markerId: const MarkerId('source'),
        position: startPoint,
        icon: startPointMarker,
      ),
      Marker(
        markerId: const MarkerId('pickUp'),
        position: pickupLoc,
        icon: pickupLocMarker,
      ),
      Marker(
        markerId: const MarkerId('dropOff'),
        position: dropOffLoc,
        icon: dropOffLocMarker,
      ),
    };
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
      body: SingleChildScrollView(
        padding: sidePadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: size.height * 0.1),
            Text(
              'Hey ${currentUser.firstName}!\nYour ride will be here soon,',
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
                initialCameraPosition: CameraPosition(
                  target: pickupLoc,
                  zoom: 15.0,
                ),
                mapType: MapType.normal,
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
