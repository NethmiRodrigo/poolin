import 'dart:async';
import 'dart:convert';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobile/colors.dart';
import 'package:mobile/custom/wide_button.dart';
import 'package:mobile/fonts.dart';
import 'package:mobile/utils/map_utils.dart';

import 'package:mobile/utils/widget_functions.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class RideOfferDetailsScreen extends StatefulWidget {
  const RideOfferDetailsScreen({super.key});

  @override
  RideOfferDetailsScreenState createState() {
    return RideOfferDetailsScreenState();
  }
}

class RideOfferDetailsScreenState extends State<RideOfferDetailsScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();
  late CameraPosition _initalPosition;
  final _storage = const FlutterSecureStorage();
  final Completer<GoogleMapController> _controller = Completer();
  late GooglePlace googlePlace;
  Set<Marker> _markers = {};
  final MapType _currentMapType = MapType.normal;

  List<AutocompletePrediction> predictions = [];
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();

  static const LatLng _center = LatLng(6.9271, 79.8612);

  String? apiKey = dotenv.env['MAPS_API_KEY'];

  void _onMapCreated(GoogleMapController controller) {
    Future.delayed(
      const Duration(milliseconds: 200),
      () => controller.animateCamera(
        CameraUpdate.newLatLngBounds(
            MapUtils.boundsFromLatLngList(
                _markers.map((loc) => loc.position).toList()),
            1),
      ),
    );
    _controller.complete(controller);
  }

  @override
  void initState() {
    googlePlace = GooglePlace(apiKey!);
    _getPolyline();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _pass.dispose();
    _confirmPass.dispose();
    super.dispose();
  }

  _addPolyLine() {
    Map<PolylineId, Polyline> polylineResult = {};
    PolylineId id = const PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id,
        color: BlipColors.orange,
        points: polylineCoordinates,
        width: 2);
    polylineResult[id] = polyline;
    setState(() {
      polylines = polylineResult;
    });
  }

  _getPolyline() async {
    var sourceString = (await _storage.read(key: "SOURCE"));
    var sourceLocation = jsonDecode(sourceString!);
    var destinationString = (await _storage.read(key: "DESTINATION"));
    var destinationLocation = jsonDecode(destinationString!);

    //Set markers
    Set<Marker> markers = {
      Marker(
        markerId: const MarkerId('source'),
        position:
            LatLng(sourceLocation['latitude'], sourceLocation['longitude']),
        draggable: false,
      ),
      Marker(
        markerId: const MarkerId('destination'),
        position: LatLng(
            destinationLocation['latitude'], destinationLocation['longitude']),
        draggable: false,
      ),
    };
    setState(() {
      _markers = markers;
      _initalPosition = CameraPosition(
          target:
              LatLng(sourceLocation['latitude'], sourceLocation['longitude']),
          zoom: 20);
    });

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        apiKey!,
        PointLatLng(sourceLocation['latitude'], sourceLocation['longitude']),
        PointLatLng(
            destinationLocation['latitude'], destinationLocation['longitude']),
        travelMode: TravelMode.driving);
    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    }
    _addPolyLine();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    const double padding = 16;
    const sidePadding = EdgeInsets.symmetric(horizontal: padding);

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
            Navigator.pop(context);
          },
        ),
      ),
      bottomSheet: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          padding: sidePadding,
          height: size.height * 0.5,
          width: size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              addVerticalSpace(24),
              const Text(
                'Confirm your Offer',
                style: BlipFonts.title,
              ),
              addVerticalSpace(40),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Column(
                              children: [
                                Text(("fare per rider".toUpperCase()),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall),
                                addVerticalSpace(20),
                                Row(
                                  children: [
                                    Text("Rs. 5000",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge),
                                    const Icon(
                                      FluentIcons.edit_16_regular,
                                      size: 14,
                                      color: BlipColors.orange,
                                    ),
                                  ],
                                ),
                                addVerticalSpace(16),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Text(("date and time".toUpperCase()),
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineSmall),
                                        addVerticalSpace(8),
                                        TextButton(
                                            onPressed: () {
                                              DatePicker.showDatePicker(context,
                                                  showTitleActions: true,
                                                  minTime: DateTime(2018, 3, 5),
                                                  maxTime: DateTime(2019, 6, 7),
                                                  onChanged: (date) {
                                                print('change $date');
                                              }, onConfirm: (date) {
                                                print('confirm $date');
                                              },
                                                  currentTime: DateTime.now(),
                                                  locale: LocaleType.en);
                                            },
                                            child: Text(
                                              '26 Oct, 2022',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelLarge,
                                            ))
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Column(
                              children: [
                                Text(("visibility".toUpperCase()),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall),
                                addVerticalSpace(20),
                                Row(
                                  children: [
                                    const Icon(FluentIcons.eye_16_filled,
                                        size: 18),
                                    addHorizontalSpace(8),
                                    Text("Public",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge),
                                  ],
                                ),
                              ],
                            ),
                            addVerticalSpace(16),
                            Column(
                              children: [
                                Text(("empty seats".toUpperCase()),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall),
                                addVerticalSpace(16),
                                Container(
                                  width: 140,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40),
                                    border: Border.all(
                                      color: BlipColors.orange,
                                      width: 1,
                                    ),
                                  ),
                                  child: SpinBox(
                                    iconColor:
                                        MaterialStateProperty.all(Colors.black),
                                    textStyle:
                                        Theme.of(context).textTheme.labelLarge,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding:
                                          EdgeInsets.fromLTRB(0, 0, 0, 12),
                                    ),
                                    min: 1,
                                    max: 100,
                                    value: 50,
                                    onChanged: (value) => print(value),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              addVerticalSpace(32),
              WideButton(
                  text: "I'll arrive at 4.30PM in 2 days",
                  onPressedAction: () {})
            ],
          ),
        ),
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        polylines: Set<Polyline>.of(polylines.values),
        initialCameraPosition: const CameraPosition(
          target: _center,
          zoom: 12.0,
        ),
        mapType: _currentMapType,
        markers: _markers,
      ),
    );
  }
}
