import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';
import 'package:mobile/cubits/ride_request_cubit.dart';
import 'package:mobile/models/coordinate_model.dart';

import 'package:mobile/screens/offer-ride/ride_offer_details_screen.dart';
import 'package:mobile/screens/view-ride-offers/view_ride_offers_screen.dart';
import 'package:mobile/services/polyline_service.dart';
import 'package:mobile/utils/map_utils.dart';
import 'package:mobile/utils/widget_functions.dart';

import 'package:mobile/models/ride_type_model.dart';

import 'package:mobile/colors.dart';
import 'package:mobile/custom/wide_button.dart';
import 'package:mobile/fonts.dart';
import 'package:mobile/icons.dart';

import '../../../cubits/ride_offer_cubit.dart';

class MapScreen extends StatefulWidget {
  final DetailsResult? sourcePosition;
  final DetailsResult? destinationPosition;
  const MapScreen({Key? key, this.sourcePosition, this.destinationPosition})
      : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final _storage = const FlutterSecureStorage();
  String rideType = RideType.request.name;
  late CameraPosition _initalPosition;
  Map<PolylineId, Polyline> polylines = {};

  String? apiKey = dotenv.env['MAPS_API_KEY'];

  BitmapDescriptor sourceMarker = BitmapDescriptor.defaultMarker;
  BitmapDescriptor destinationMarker = BitmapDescriptor.defaultMarker;

  @override
  void initState() {
    __loadRideType();
    setCustomMarkers();

    _initalPosition = CameraPosition(
        target: LatLng(
          widget.sourcePosition!.geometry!.location!.lat!,
          widget.sourcePosition!.geometry!.location!.lng!,
        ),
        zoom: 20);
    super.initState();
  }

  __loadRideType() async {
    final rideTypeFromStorage = (await _storage.read(key: "RIDE_TYPE"))!;
    if (rideTypeFromStorage != null) {
      rideType = rideTypeFromStorage;
    }
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

    setState(() {
      destinationMarker = destinationIcon;
      sourceMarker = startIcon;
    });
  }

  _getPolyline() async {
    var result = await getPolyline(
        widget.sourcePosition!.geometry!.location!.lat!,
        widget.sourcePosition!.geometry!.location!.lng!,
        widget.destinationPosition!.geometry!.location!.lat!,
        widget.destinationPosition!.geometry!.location!.lng!);
    setState(() {
      polylines = result;
    });
  }

  Widget _addLocationSearchField(String type) {
    return TextField(
      autofocus: false,
      showCursor: false,
      readOnly: true,
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: const BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        prefixIcon:
            Icon(type == "source" ? BlipIcons.source : BlipIcons.destination),
        prefixIconColor: BlipColors.orange,
        hintText: type == "source"
            ? widget.sourcePosition!.name
            : widget.destinationPosition!.name,
      ),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final RideOfferCubit offerCubit = BlocProvider.of<RideOfferCubit>(context);
    final RideRequestCubit reqCubit =
        BlocProvider.of<RideRequestCubit>(context);

    if (rideType == "offer") {
      offerCubit.setSource(Coordinate(
          lat: widget.sourcePosition!.geometry!.location!.lat!,
          lang: widget.sourcePosition!.geometry!.location!.lng!,
          name: widget.sourcePosition!.name!));
      offerCubit.setDestination(Coordinate(
          lat: widget.destinationPosition!.geometry!.location!.lat!,
          lang: widget.destinationPosition!.geometry!.location!.lng!,
          name: widget.destinationPosition!.name!));
    } else {
      reqCubit.setSource(Coordinate(
          lat: widget.sourcePosition!.geometry!.location!.lat!,
          lang: widget.sourcePosition!.geometry!.location!.lng!,
          name: widget.sourcePosition!.name!));
      reqCubit.setDestination(Coordinate(
          lat: widget.destinationPosition!.geometry!.location!.lat!,
          lang: widget.destinationPosition!.geometry!.location!.lng!,
          name: widget.destinationPosition!.name!));
    }

    Future<bool> saveDistanceDuration() async {
      Dio dio = Dio();

      String? apiURL = dotenv.env['DISTANCE_MATRIX_API_URL'];

      try {
        Response response;

        if (rideType == "offer") {
          response = await dio.get(
              "$apiURL?origins=${offerCubit.state.source.lat}%2C${offerCubit.state.source.lang}&destinations=${offerCubit.state.destination.lat}%2C${offerCubit.state.destination.lang}&key=$apiKey&mode=driving");
        } else {
          response = await dio.get(
              "$apiURL?origins=${reqCubit.state.source.lat}%2C${reqCubit.state.source.lang}&destinations=${reqCubit.state.destination.lat}%2C${reqCubit.state.destination.lang}&key=$apiKey&mode=driving");
        }

        if (response.data["rows"][0]["elements"][0]["status"] == "OK") {
          int durationInSeconds =
              response.data["rows"][0]["elements"][0]["duration"]["value"];
          int distanceInMeters =
              response.data["rows"][0]["elements"][0]['distance']["value"];

          setState(() {
            if (rideType == "offer") {
              offerCubit.setDuration(durationInSeconds ~/ 60);
              offerCubit.setDistance(distanceInMeters / 1000);
            } else {
              reqCubit.setDistance(distanceInMeters / 1000);
              reqCubit.setDuration(durationInSeconds ~/ 60);
            }
          });
          return true;
        }
      } catch (e) {
        print(e.toString());
      }
      return false;
    }

    Set<Marker> markers = {
      Marker(
        markerId: const MarkerId('source'),
        position: LatLng(
          widget.sourcePosition!.geometry!.location!.lat!,
          widget.sourcePosition!.geometry!.location!.lng!,
        ),
        draggable: false,
        infoWindow: InfoWindow(
          title: "Start Location",
          snippet: widget.sourcePosition!.name!,
        ),
        icon: sourceMarker,
      ),
      Marker(
        markerId: const MarkerId('destination'),
        position: LatLng(
          widget.destinationPosition!.geometry!.location!.lat!,
          widget.destinationPosition!.geometry!.location!.lng!,
        ),
        draggable: false,
        infoWindow: InfoWindow(
          title: "End Location",
          snippet: widget.destinationPosition!.name!,
        ),
        icon: destinationMarker,
      ),
    };

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
      body: Stack(children: [
        LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return SizedBox(
              height: constraints.maxHeight / 2 * 1,
              child: GoogleMap(
                initialCameraPosition: _initalPosition,
                markers: Set.from(markers),
                polylines: Set<Polyline>.of(polylines.values),
                onMapCreated: (GoogleMapController controller) {
                  Future.delayed(
                    const Duration(milliseconds: 200),
                    () => controller.animateCamera(
                      CameraUpdate.newLatLngBounds(
                          MapUtils.boundsFromLatLngList(
                              markers.map((loc) => loc.position).toList()),
                          1),
                    ),
                  );
                  _getPolyline();
                },
              ),
            );
          },
        ),
        DraggableScrollableSheet(
            initialChildSize: 1 / 2,
            minChildSize: 1 / 2,
            maxChildSize: 1 / 2,
            builder: (BuildContext context, ScrollController scrollController) {
              return Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Your Trip Details",
                        style: BlipFonts.title,
                      ),
                    ),
                    addVerticalSpace(24),
                    addVerticalSpace(10.0),
                    _addLocationSearchField("source"),
                    addVerticalSpace(10.0),
                    _addLocationSearchField("destination"),
                    addVerticalSpace(48),
                    WideButton(
                      text: rideType == "offer"
                          ? 'Post an offer'
                          : "Look for ride offers",
                      onPressedAction: () async {
                        bool result = await saveDistanceDuration();
                        if (result) {
                          // ignore: use_build_context_synchronously
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => rideType == "offer"
                                  ? const RideOfferDetailsScreen()
                                  : const ViewRideOffersScreen(),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              );
            }),
      ]),
    );
  }
}
