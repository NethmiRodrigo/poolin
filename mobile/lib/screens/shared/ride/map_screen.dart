import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';
import 'package:poolin/models/coordinate_model.dart';

import 'package:poolin/screens/offer-ride/ride_offer_details_screen.dart';
import 'package:poolin/screens/view-ride-offers/view_ride_offers_screen.dart';
import 'package:poolin/services/polyline_service.dart';
import 'package:poolin/utils/map_utils.dart';
import 'package:poolin/utils/widget_functions.dart';

import 'package:poolin/models/ride_type_model.dart';

import 'package:poolin/colors.dart';
import 'package:poolin/custom/wide_button.dart';
import 'package:poolin/fonts.dart';
import 'package:poolin/icons.dart';

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

  @override
  void initState() {
    __loadRideType();
    __saveLocations();

    _initalPosition = CameraPosition(
        target: LatLng(widget.sourcePosition!.geometry!.location!.lat!,
            widget.sourcePosition!.geometry!.location!.lng!),
        zoom: 20);
    super.initState();
  }

  __loadRideType() async {
    final rideTypeFromStorage = (await _storage.read(key: "RIDE_TYPE"))!;
    if (rideTypeFromStorage != null) {
      rideType = rideTypeFromStorage;
    }
  }

  __saveLocations() async {
    Map source = {
      "latitude": widget.sourcePosition!.geometry!.location!.lat,
      "longitude": widget.sourcePosition!.geometry!.location!.lng,
      "name": widget.sourcePosition!.name
    };
    Map destination = {
      "latitude": widget.destinationPosition!.geometry!.location!.lat,
      "longitude": widget.destinationPosition!.geometry!.location!.lng,
      "name": widget.destinationPosition!.name,
    };
    await _storage.write(key: "SOURCE", value: jsonEncode(source));
    await _storage.write(key: "DESTINATION", value: jsonEncode(destination));
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
    offerCubit.setSource(Coordinate(
        lat: widget.sourcePosition!.geometry!.location!.lat!,
        lang: widget.sourcePosition!.geometry!.location!.lng!,
        name: widget.sourcePosition!.name!));
    offerCubit.setDestination(Coordinate(
        lat: widget.destinationPosition!.geometry!.location!.lat!,
        lang: widget.destinationPosition!.geometry!.location!.lng!,
        name: widget.destinationPosition!.name!));

    Set<Marker> markers = {
      Marker(
        markerId: const MarkerId('source'),
        position: LatLng(widget.sourcePosition!.geometry!.location!.lat!,
            widget.sourcePosition!.geometry!.location!.lng!),
        draggable: false,
        infoWindow: InfoWindow(
            title: "Start Location", snippet: widget.sourcePosition!.name!),
      ),
      Marker(
        markerId: const MarkerId('destination'),
        position: LatLng(widget.destinationPosition!.geometry!.location!.lat!,
            widget.destinationPosition!.geometry!.location!.lng!),
        draggable: false,
        infoWindow: InfoWindow(
            title: "End Location", snippet: widget.destinationPosition!.name!),
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
                      onPressedAction: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => rideType == "offer"
                                  ? const RideOfferDetailsScreen()
                                  : const ViewRideOffersScreen(),
                            ));
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
