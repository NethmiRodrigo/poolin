import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:mobile/colors.dart';
import 'package:mobile/cubits/ride_request_cubit.dart';
import 'package:mobile/services/polyline_service.dart';
import 'package:mobile/utils/map_utils.dart';

import 'package:mobile/screens/request-ride/request_details_card.dart';

class RideRequestDetailsScreen extends StatefulWidget {
  const RideRequestDetailsScreen({super.key});

  @override
  RideRequestDetailsScreenState createState() {
    return RideRequestDetailsScreenState();
  }
}

class RideRequestDetailsScreenState extends State<RideRequestDetailsScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  Map<PolylineId, Polyline> polylines = {};
  BitmapDescriptor sourceMarker = BitmapDescriptor.defaultMarker;
  BitmapDescriptor destinationMarker = BitmapDescriptor.defaultMarker;
  String? apiKey = dotenv.env['MAPS_API_KEY'];
  final MapType _currentMapType = MapType.normal;

  @override
  void initState() {
    setCustomMarkers();
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    final RideRequestCubit reqCubit =
        BlocProvider.of<RideRequestCubit>(context);

    Set<Marker> markers = {
      Marker(
        markerId: const MarkerId('source'),
        position: LatLng(
          reqCubit.state.source.lat,
          reqCubit.state.source.lang,
        ),
        draggable: false,
        infoWindow: InfoWindow(
          title: "Start Location",
          snippet: reqCubit.state.source.name,
        ),
        icon: sourceMarker,
      ),
      Marker(
        markerId: const MarkerId('destination'),
        position: LatLng(
          reqCubit.state.destination.lat,
          reqCubit.state.destination.lang,
        ),
        draggable: false,
        infoWindow: InfoWindow(
          title: "End Location",
          snippet: reqCubit.state.destination.name,
        ),
        icon: destinationMarker,
      ),
    };

    _getPolyline() async {
      var result = await getPolyline(
          reqCubit.state.source.lat,
          reqCubit.state.source.lang,
          reqCubit.state.destination.lat,
          reqCubit.state.destination.lang);
      setState(() {
        polylines = result;
      });
    }

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
      body: Stack(
        children: [
          LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            return SizedBox(
              height: constraints.maxHeight / 2,
              child: GoogleMap(
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
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                    reqCubit.state.source.lat,
                    reqCubit.state.source.lang,
                  ),
                  zoom: 14.0,
                ),
                mapType: _currentMapType,
                markers: Set.from(markers),
                polylines: Set<Polyline>.of(polylines.values),
              ),
            );
          }),
          DraggableScrollableSheet(
            initialChildSize: 1 / 2,
            minChildSize: 1 / 2,
            maxChildSize: 1 / 2,
            builder: (BuildContext context, ScrollController scrollController) {
              return const RequestDetailsCard();
            },
          ),
        ],
      ),
    );
  }
}
