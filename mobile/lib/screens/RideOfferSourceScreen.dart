import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobile/utils/widget_functions.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class RideOfferSourceScreen extends StatefulWidget {
  const RideOfferSourceScreen({super.key});

  @override
  RideOfferSourceScreenState createState() {
    return RideOfferSourceScreenState();
  }
}

class RideOfferSourceScreenState extends State<RideOfferSourceScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();
  final _storage = const FlutterSecureStorage();
  final Completer<GoogleMapController> _controller = Completer();
  late GooglePlace googlePlace;
  List<AutocompletePrediction> predictions = [];

  static const LatLng _center = LatLng(6.9271, 79.8612);

  final Set<Marker> _markers = {};

  LatLng _lastMapPosition = _center;

  final MapType _currentMapType = MapType.normal;

  // void _onMapTypeButtonPressed() {
  //   setState(() {
  //     _currentMapType = _currentMapType == MapType.normal
  //         ? MapType.satellite
  //         : MapType.normal;
  //   });
  // }

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
      bottomSheet: Container(
        padding: sidePadding,
        height: size.height * 0.5,
        width: size.width,
        child: Stack(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              addVerticalSpace(24),
              Text(
                'Good morning, Dulaj',
                style: Theme.of(context).textTheme.headline5,
              ),
              addVerticalSpace(72),
              Row(
                children: [
                  const Icon(Icons.location_pin),
                  addHorizontalSpace(16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'University of Colombo',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      Text(
                        '206/A, Reid Avenue, Colombo 07',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ],
                  )
                ],
              ),
              addVerticalSpace(16),
              Row(
                children: [
                  const Icon(Icons.location_pin),
                  addHorizontalSpace(16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'University of Colombo',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      Text(
                        '206/A, Reid Avenue, Colombo 07',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ],
                  )
                ],
              ),
              addVerticalSpace(16),
              Row(
                children: [
                  const Icon(Icons.location_pin),
                  addHorizontalSpace(16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'University of Colombo',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      Text(
                        '206/A, Reid Avenue, Colombo 07',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
          Column(
            children: [
              addVerticalSpace(72),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      key: const Key('password-field'),
                      controller: _pass,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.search_outlined),
                        isDense: true,
                        border: OutlineInputBorder(),
                        hintText: "Where do you start from?",
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          autoCompleteSearch(value);
                        } else {
                          if (predictions.isNotEmpty && mounted) {
                            setState(() {
                              predictions = [];
                            });
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: ListView.builder(
                    itemCount: predictions.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: const CircleAvatar(
                          child: Icon(
                            Icons.pin_drop,
                            color: Colors.white,
                          ),
                        ),
                        title: Text(predictions[index].description ?? ""),
                        onTap: () {},
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ]),
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: const CameraPosition(
          target: _center,
          zoom: 12.0,
        ),
        mapType: _currentMapType,
        markers: _markers,
        onCameraMove: _onCameraMove,
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
