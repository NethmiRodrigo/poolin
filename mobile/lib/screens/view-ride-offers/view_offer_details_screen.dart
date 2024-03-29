import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_map_polyline_new/google_map_polyline_new.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:poolin/colors.dart';
import 'package:poolin/cubits/matching_rides_cubit.dart';
import 'package:poolin/cubits/ride_request_cubit.dart';
import 'package:poolin/custom/wide_button.dart';
import 'package:poolin/fonts.dart';
import 'package:poolin/screens/view-ride-offers/timeline.dart';
import 'package:poolin/screens/view-ride-offers/user_card.dart';
import 'package:poolin/screens/view-ride-offers/view_ride_offers_screen.dart';
import 'package:poolin/utils/map_utils.dart';
import 'package:poolin/utils/widget_functions.dart';

class ViewRideOfferDetails extends StatefulWidget {
  final int offerIndex;

  const ViewRideOfferDetails(this.offerIndex, {Key? key}) : super(key: key);

  @override
  State<ViewRideOfferDetails> createState() => _ViewRideOfferDetailsState();
}

class _ViewRideOfferDetailsState extends State<ViewRideOfferDetails> {
  final Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = {};
  late RideRequestCubit reqCubit;
  late MatchingOffersCubit matchingOffersCubit;
  late MatchedOffer offer;

  BitmapDescriptor driverSourceMarker = BitmapDescriptor.defaultMarker;
  BitmapDescriptor riderSourceMarker = BitmapDescriptor.defaultMarker;
  BitmapDescriptor riderDestinationMarker = BitmapDescriptor.defaultMarker;

  List<LatLng> driverCoords = [];
  List<LatLng> riderCoords = [];
  late GoogleMapPolyline googleMapPolyline;

  @override
  void initState() {
    reqCubit = BlocProvider.of(context);
    matchingOffersCubit = BlocProvider.of(context);
    offer = matchingOffersCubit.state.offers[widget.offerIndex];

    String? apiKey = dotenv.env['MAPS_API_KEY'];
    googleMapPolyline = GoogleMapPolyline(apiKey: apiKey!);

    setCustomMarkers();
    setDriverPath();
    setRiderPath();
    super.initState();
  }

  void setCustomMarkers() async {
    // Create custom icons
    BitmapDescriptor startIconBlack = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty,
      "assets/images/source-pin-black.png",
    );

    BitmapDescriptor startIconGrey = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty,
      "assets/images/source-pin-grey.png",
    );

    BitmapDescriptor destinationIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty,
      "assets/images/location-pin-orange.png",
    );

    setState(() {
      riderDestinationMarker = destinationIcon;
      riderSourceMarker = startIconBlack;
      driverSourceMarker = startIconGrey;
    });

    // Create markers
    Set<Marker> markers = {
      Marker(
        markerId: const MarkerId('rider-source'),
        position: LatLng(
          reqCubit.state.source.lat,
          reqCubit.state.source.lang,
        ),
        icon: riderSourceMarker,
        infoWindow: const InfoWindow(title: 'You start here'),
      ),
      Marker(
        markerId: const MarkerId('driver-source'),
        position: LatLng(
          offer.source.lat,
          offer.source.lang,
        ),
        icon: driverSourceMarker,
      ),
      Marker(
        markerId: const MarkerId('destination'),
        position: LatLng(
          reqCubit.state.destination.lat,
          reqCubit.state.destination.lang,
        ),
        icon: riderDestinationMarker,
        infoWindow: const InfoWindow(title: 'You finish here'),
      ),
    };
    setState(() {
      _markers = markers;
    });
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
    _controller.complete(controller);
  }

  void setDriverPath() async {
    List<LatLng>? coords = await googleMapPolyline.getCoordinatesWithLocation(
        origin: LatLng(
          offer.source.lat,
          offer.source.lang,
        ),
        destination: LatLng(
          reqCubit.state.destination.lat,
          reqCubit.state.destination.lang,
        ),
        mode: RouteMode.driving);
    setState(() {
      if (coords != null) {
        driverCoords = coords;
      }
    });
  }

  void setRiderPath() async {
    List<LatLng>? coords = await googleMapPolyline.getCoordinatesWithLocation(
        origin: LatLng(
          reqCubit.state.source.lat,
          reqCubit.state.source.lang,
        ),
        destination: LatLng(
          reqCubit.state.destination.lat,
          reqCubit.state.destination.lang,
        ),
        mode: RouteMode.driving);
    setState(() {
      if (coords != null) {
        riderCoords = coords;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

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
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const ViewRideOffersScreen()),
            );
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
                      offer.source.lat,
                      offer.source.lang,
                    ),
                    zoom: 14.0,
                  ),
                  mapType: MapType.normal,
                  markers: _markers,
                  polylines: {
                    Polyline(
                      polylineId: const PolylineId("driver-route"),
                      color: BlipColors.black,
                      points: driverCoords,
                      width: 2,
                    ),
                    Polyline(
                      polylineId: const PolylineId("rider-route"),
                      color: BlipColors.orange,
                      points: riderCoords,
                      width: 3,
                    ),
                  },
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
                    UserCard(offer.driver, offer.id),
                    const Divider(
                      color: BlipColors.grey,
                      indent: 8.0,
                      endIndent: 8.0,
                    ),
                    Expanded(
                        child: RideOfferTimeline(offer, reqCubit.state.source,
                            reqCubit.state.destination)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          addHorizontalSpace(8.0),
                          Text(
                            "Rs. ${reqCubit.state.distance * offer.pricePerKM}",
                            style: BlipFonts.heading,
                          ),
                          const Spacer(),
                          SizedBox(
                            width: size.width * 0.5,
                            child: reqCubit.state.offerIDs.contains(offer.id)
                                ? WideButton(
                                    onPressedAction: () {
                                      reqCubit.removeOffer(offer.id);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const ViewRideOffersScreen()),
                                      );
                                    },
                                    text: "Remove Ride",
                                  )
                                : WideButton(
                                    onPressedAction: () {
                                      reqCubit.addOffer(offer.id);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const ViewRideOffersScreen()),
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
