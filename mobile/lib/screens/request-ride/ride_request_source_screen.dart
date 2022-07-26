import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';
import 'package:mobile/blocs/application_bloc.dart';
import 'package:mobile/fonts.dart';
import 'package:mobile/utils/widget_functions.dart';
import 'package:provider/provider.dart';

class RideRequestSourceScreen extends StatefulWidget {
  @override
  _RideRequestSourceState createState() => _RideRequestSourceState();
}

class _RideRequestSourceState extends State<RideRequestSourceScreen> {
  final Completer<GoogleMapController> _mapController = Completer();
  late StreamSubscription locationSubscription;
  late StreamSubscription boundsSubscription;
  late StreamSubscription polylinesSubscription;
  final _locationContoller = TextEditingController();
  late Map<PolylineId, Polyline> polylines = {};

  @override
  void initState() {
    if (defaultTargetPlatform == TargetPlatform.android) {
      AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
    }
    final applicationBloc =
        Provider.of<ApplicationBloc>(context, listen: false);

    //Listen for selected location
    locationSubscription =
        applicationBloc.selectedLocation.stream.listen((place) {
      if (place != null) {
        _locationContoller.text = place.name!;
        polylines = applicationBloc.polylines;
        _goToPlace(place);
      } else {
        _locationContoller.text = "";
      }
    });

    applicationBloc.bounds.stream.listen((bounds) async {
      final GoogleMapController controller = await _mapController.future;
      controller.animateCamera(CameraUpdate.newLatLngBounds(bounds, 100));
    });

    polylinesSubscription =
        applicationBloc.polylineStream.stream.listen((polylineResult) async {
      if (polylineResult.values.isNotEmpty)
        polylines = applicationBloc.polylines;
    });
    super.initState();
  }

  @override
  void dispose() {
    final applicationBloc =
        Provider.of<ApplicationBloc>(context, listen: false);
    locationSubscription.cancel();
    applicationBloc.dispose();
    _locationContoller.dispose();
    locationSubscription.cancel();
    boundsSubscription.cancel();
    polylinesSubscription.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final applicationBloc = Provider.of<ApplicationBloc>(context);
    var startLocation = LatLng(
        applicationBloc.currentLocation?.latitude ?? 6.92,
        applicationBloc.currentLocation?.longitude ?? 79.86);

    return Scaffold(
      body: applicationBloc.currentLocation == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              children: [
                Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height,
                      child: GoogleMap(
                        mapType: MapType.normal,
                        myLocationButtonEnabled: true,
                        myLocationEnabled: true,
                        zoomControlsEnabled: true,
                        tiltGesturesEnabled: true,
                        compassEnabled: true,
                        scrollGesturesEnabled: true,
                        zoomGesturesEnabled: true,
                        mapToolbarEnabled: true,
                        initialCameraPosition:
                            CameraPosition(target: startLocation, zoom: 12),
                        markers: Set<Marker>.of(applicationBloc.markers),
                        polylines: Set<Polyline>.of(polylines.values),
                        onMapCreated: (GoogleMapController controller) {
                          _mapController.complete(controller);
                        },
                        onCameraMove: (CameraPosition position) {
                          startLocation = position.target;
                        },
                      ),
                    ),
                    if (applicationBloc.results != null &&
                        applicationBloc.results.isNotEmpty)
                      Container(
                        height: 300.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(.6),
                          backgroundBlendMode: BlendMode.darken,
                        ),
                      ),
                    if (applicationBloc.results != null &&
                        applicationBloc.results.isNotEmpty)
                      SizedBox(
                        height: 300.0,
                        child: ListView.builder(
                          itemCount: applicationBloc.results.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(
                                applicationBloc.results[index].description ??
                                    "description",
                                style: const TextStyle(color: Colors.white),
                              ),
                              onTap: () {
                                FocusManager.instance.primaryFocus?.unfocus();
                                applicationBloc.setSelectedLocation(
                                    applicationBloc.results[index].placeId ??
                                        "");
                              },
                            );
                          },
                        ),
                      ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  height: 220.0,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            addVerticalSpace(30.0),
                            const Text(
                              "Good Morning, Jane Doe",
                              style: BlipFonts.labelBold,
                            ),
                            addVerticalSpace(10.0),
                            const Text(
                              'Where are you starting from?',
                              style: BlipFonts.title,
                            ),
                            addVerticalSpace(20.0),
                            TextField(
                              controller: _locationContoller,
                              decoration: const InputDecoration(
                                hintText: "Search starting location",
                                prefixIcon: Icon(Icons.search),
                              ),
                              style: BlipFonts.label,
                              onChanged: (value) {
                                if (value.isNotEmpty)
                                  applicationBloc.searchPlaces(value);
                              },
                              onTap: () {
                                if (_locationContoller.text.isNotEmpty) {
                                  _locationContoller.text = "";
                                }
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Future<void> _goToPlace(DetailsResult place) async {
    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(place.geometry!.location!.lat ?? 6.92,
                place.geometry!.location!.lng ?? 79.86),
            zoom: 4.0),
      ),
    );
  }
}
