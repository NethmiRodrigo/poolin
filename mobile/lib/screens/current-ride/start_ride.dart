import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_map_polyline_new/google_map_polyline_new.dart';
import 'package:flutter_countdown_timer/index.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:ui' as ui;
import 'dart:typed_data';

import 'package:mobile/colors.dart';
import 'package:mobile/cubits/current_user_cubit.dart';
import 'package:mobile/custom/wide_button.dart';
import 'package:mobile/fonts.dart';
import 'package:mobile/screens/current-ride/driver_nav.dart';
import 'package:mobile/utils/widget_functions.dart';

class StartRide extends StatefulWidget {
  const StartRide({Key? key}) : super(key: key);

  @override
  State<StartRide> createState() => _StartRideState();
}

class _StartRideState extends State<StartRide> {
  int rideStartTime = DateTime.now().millisecondsSinceEpoch +
      const Duration(minutes: 15).inMilliseconds;
  late CountdownTimerController timerController;

  final LatLng startPoint = const LatLng(6.9063474012458, 79.86057108194697);
  final LatLng destination = const LatLng(6.916662437771989, 79.86387932108144);
  final Completer<GoogleMapController> _controller = Completer();
  final MapType _currentMapType = MapType.normal;

  List<LatLng>? _coordinates;
  late GoogleMapPolyline googleMapPolyline;

  LocationData? currentLocation;

  BitmapDescriptor startMarker = BitmapDescriptor.defaultMarker;
  BitmapDescriptor destinationMarker = BitmapDescriptor.defaultMarker;
  BitmapDescriptor currentLocationMarker = BitmapDescriptor.defaultMarker;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    setCustomMarkers();
    String? apiKey = dotenv.env['MAPS_API_KEY'];
    googleMapPolyline = GoogleMapPolyline(apiKey: apiKey!);
    getPolyPoints();
    getCurrentLocation();
    timerController =
        CountdownTimerController(endTime: rideStartTime, onEnd: () => {});
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
    List<LatLng>? coords = await googleMapPolyline.getCoordinatesWithLocation(
        origin: startPoint, destination: destination, mode: RouteMode.driving);
    setState(() {
      if (coords != null) {
        _coordinates = coords;
      }
    });
  }

  void setCustomMarkers() async {
    // Create custom icons

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
      "assets/images/radio-blue.png",
    );

    setState(() {
      currentLocationMarker = currentLocIcon;
      destinationMarker = destinationIcon;
      startMarker = startIcon;
    });
  }

  Future<Uint8List> getBytesFromAsset(
      {String? path, required int width}) async {
    ByteData data = await rootBundle.load(path!);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    const double padding = 16;
    const sidePadding = EdgeInsets.symmetric(horizontal: padding);
    final CurrentUserCubit currentUser =
        BlocProvider.of<CurrentUserCubit>(context);

    return Scaffold(
      body: (currentLocation == null || _coordinates == null)
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
                            'Hey ${currentUser.state.firstName}!\nYour ride starts in,',
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
                      myLocationButtonEnabled: true,
                      myLocationEnabled: true,
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
