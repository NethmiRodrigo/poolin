import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_map_polyline_new/google_map_polyline_new.dart';
import 'package:flutter_countdown_timer/index.dart';
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

  late IO.Socket socket;

  // final LatLng pickupLocation = const LatLng(6.9020788145677, 79.86035186605507);
  // final LatLng dropOffLocation = const LatLng(6.901226727080122, 79.86455756968157);
  Completer<GoogleMapController> _controller = Completer();
  late Map<MarkerId, Marker> _markers;
  static const CameraPosition _cameraPosition = CameraPosition(target: LatLng(0.11, 1.00), zoom: 14,);

  @override
  void initState() {
    super.initState();
    _markers = <MarkerId, Marker>{};
    _markers.clear();
    initSocket();
    timerController =
        CountdownTimerController(endTime: rideArrivalTime, onEnd: () => {});
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
        controller.animateCamera(
          CameraUpdate.newCameraPosition(CameraPosition(
            target: LatLng(latLng["lat"], latLng["lng"]), 
            zoom: 19,
          ))
        );

        Marker marker = Marker(
          markerId: const MarkerId("ID"), 
          position: LatLng(latLng["lat"], latLng["lng"])
        );

        setState(() {
          _markers[MarkerId("ID")] = marker;
        });

      });
    } catch (e) {
      print(e.toString());
    }
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
                  initialCameraPosition: _cameraPosition,
                  mapType: MapType.normal,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  markers: Set<Marker>.of(_markers.values),
                )),
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
