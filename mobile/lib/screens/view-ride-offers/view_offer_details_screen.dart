import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobile/colors.dart';
import 'package:mobile/cubits/ride_request_cubit.dart';
import 'package:mobile/custom/wide_button.dart';
import 'package:mobile/fonts.dart';
import 'package:mobile/models/ride_offer_search_result.dart';
import 'package:mobile/screens/request-ride/request_confirmation.dart';
import 'package:mobile/screens/view-ride-offers/timeline.dart';
import 'package:mobile/screens/view-ride-offers/user_card.dart';
import 'package:mobile/services/polyline_service.dart';
import 'package:mobile/utils/map_utils.dart';
import 'package:mobile/utils/widget_functions.dart';

class ViewRideOfferDetails extends StatefulWidget {
  final RideOfferSearchResult offer;

  const ViewRideOfferDetails(this.offer, {Key? key}) : super(key: key);

  @override
  State<ViewRideOfferDetails> createState() => _ViewRideOfferDetailsState();
}

class _ViewRideOfferDetailsState extends State<ViewRideOfferDetails> {
  final Completer<GoogleMapController> _controller = Completer();
  Map<PolylineId, Polyline> polylines = {};
  Set<Marker> _markers = {};
  BitmapDescriptor sourceMarker = BitmapDescriptor.defaultMarker;
  BitmapDescriptor destinationMarker = BitmapDescriptor.defaultMarker;
  late CameraPosition initalPosition;

  @override
  void initState() {
    setCustomMarkers();
    print(widget.offer.driver.firstName);
    super.initState();
  }

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
    _getPolyline();
    _controller.complete(controller);
  }

  _getPolyline() async {
    // Create markers
    Set<Marker> markers = {
      Marker(
        markerId: const MarkerId('source'),
        position: LatLng(
          widget.offer.source.lat,
          widget.offer.source.lang,
        ),
        draggable: false,
        icon: sourceMarker,
      ),
      Marker(
        markerId: const MarkerId('destination'),
        position: LatLng(
          widget.offer.destination.lat,
          widget.offer.destination.lang,
        ),
        draggable: false,
        icon: destinationMarker,
      ),
    };
    setState(() {
      _markers = markers;
      initalPosition = CameraPosition(
          target: LatLng(
            widget.offer.source.lat,
            widget.offer.source.lang,
          ),
          zoom: 20);
    });

    Map<PolylineId, Polyline> result = await getPolyline(
      widget.offer.source.lat,
      widget.offer.source.lang,
      widget.offer.destination.lat,
      widget.offer.destination.lang,
    );
    setState(() {
      polylines = result;
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

    setState(() {
      destinationMarker = destinationIcon;
      sourceMarker = startIcon;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final RideRequestCubit reqCubit =
        BlocProvider.of<RideRequestCubit>(context);

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
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                      widget.offer.source.lat,
                      widget.offer.source.lang,
                    ),
                    zoom: 14.0,
                  ),
                  mapType: MapType.normal,
                  markers: _markers,
                  polylines: Set<Polyline>.of(polylines.values),
                ),
              );
            },
          ),
          DraggableScrollableSheet(
            initialChildSize: 1 / 2,
            minChildSize: 1 / 2,
            maxChildSize: 1 / 2,
            builder: (context, scrollController) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                child: Column(
                  children: [
                    UserCard(widget.offer.driver),
                    const Divider(
                      color: BlipColors.grey,
                      indent: 8.0,
                      endIndent: 8.0,
                    ),
                    Expanded(child: RideOfferTimeline(widget.offer, reqCubit.state.source, reqCubit.state.destination)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          addHorizontalSpace(8.0),
                          Text(
                            "Rs. ${reqCubit.state.distance }",
                            style: BlipFonts.heading,
                          ),
                          const Spacer(),
                          SizedBox(
                            width: size.width * 0.5,
                            child: WideButton(
                              onPressedAction: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const RequestConfirmation()),
                                );
                              },
                              text: "Select Ride",
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
