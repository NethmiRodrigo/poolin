import 'dart:async';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:mobile/custom/wide_button.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import 'package:mobile/services/register_service.dart';
import 'package:mobile/utils/widget_functions.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class RideRequestDetailsScreen extends StatefulWidget {
  const RideRequestDetailsScreen({super.key});

  @override
  RideRequestDetailsScreenState createState() {
    return RideRequestDetailsScreenState();
  }
}

class RideRequestDetailsScreenState extends State<RideRequestDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();
  final _storage = const FlutterSecureStorage();
  Completer<GoogleMapController> _controller = Completer();
  late GooglePlace googlePlace;
  List<AutocompletePrediction> predictions = [];
  double _value = 40.0;

  static const LatLng _center = const LatLng(6.9271, 79.8612);

  final Set<Marker> _markers = {};

  LatLng _lastMapPosition = _center;

  MapType _currentMapType = MapType.normal;

  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  void initState() {
    String? apiKey = dotenv.env['MAPS_API_KEY'];
    googlePlace = GooglePlace(apiKey!);
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _pass.dispose();
    _confirmPass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    const double padding = 16;
    const sidePadding = EdgeInsets.symmetric(horizontal: padding);

    return Scaffold(
      bottomSheet: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          padding: sidePadding,
          height: size.height * 0.5,
          width: size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              addVerticalSpace(24),
              Text(
                'Confirm your Request',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              addVerticalSpace(40),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(("offer".toUpperCase()),
                                style:
                                    Theme.of(context).textTheme.headlineSmall),
                            addVerticalSpace(20),
                            Row(
                              children: [
                                Text("Rs. 5000",
                                    style:
                                        Theme.of(context).textTheme.labelLarge),
                                Icon(FluentIcons.edit_16_regular)
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(("expiry time".toUpperCase()),
                                style:
                                    Theme.of(context).textTheme.headlineSmall),
                            addVerticalSpace(8),
                            SfSlider(
                              min: 0.0,
                              max: 100.0,
                              value: _value,
                              interval: 20,
                              showTicks: false,
                              showLabels: false,
                              enableTooltip: true,
                              minorTicksPerInterval: 1,
                              onChanged: (dynamic value) {
                                setState(() {
                                  _value = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(("date and time".toUpperCase()),
                                style:
                                    Theme.of(context).textTheme.headlineSmall),
                            addVerticalSpace(20),
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
                                  style: Theme.of(context).textTheme.labelLarge,
                                ))
                          ],
                        ),
                        Column(
                          children: [
                            Text(("visibility".toUpperCase()),
                                style:
                                    Theme.of(context).textTheme.headlineSmall),
                            addVerticalSpace(20),
                            Row(
                              children: [
                                Icon(FluentIcons.eye_16_filled, size: 18),
                                addHorizontalSpace(8),
                                Text("Public",
                                    style:
                                        Theme.of(context).textTheme.labelLarge),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              addVerticalSpace(20),
              WideButton(
                  text: "I'll arrive at 4.30PM in 2 days",
                  onPressedAction: () {})
            ],
          ),
        ),
      ),
      body: Container(
        child: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 12.0,
          ),
          mapType: _currentMapType,
          markers: _markers,
          onCameraMove: _onCameraMove,
        ),
      ),
    );
  }

  void autoCompleteSearch(String value) async {
    var result = await googlePlace.autocomplete.get(value);
    if (result != null && result.predictions != null && mounted) {
      setState(() {
        predictions = result.predictions!;
      });
    }
  }
}
