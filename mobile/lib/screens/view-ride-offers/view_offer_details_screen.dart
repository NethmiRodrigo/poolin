import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_map_polyline_new/google_map_polyline_new.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobile/colors.dart';
import 'package:mobile/cubits/ride_request_cubit.dart';
import 'package:mobile/custom/wide_button.dart';
import 'package:mobile/fonts.dart';
import 'package:mobile/models/ride_offer_search_result.dart';
import 'package:mobile/screens/view-ride-offers/timeline.dart';
import 'package:mobile/screens/view-ride-offers/user_card.dart';
import 'package:mobile/screens/view-ride-offers/view_ride_offers_screen.dart';
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
  Set<Marker> _markers = {};
  BitmapDescriptor driverSourceMarker = BitmapDescriptor.defaultMarker;
  BitmapDescriptor riderSourceMarker = BitmapDescriptor.defaultMarker;
  BitmapDescriptor riderDestinationMarker = BitmapDescriptor.defaultMarker;

  List<LatLng> driverCoords = [];
  List<LatLng> riderCoords = [];
  late GoogleMapPolyline googleMapPolyline;

  @override
  void initState() {
    String? apiKey = dotenv.env['MAPS_API_KEY'];
    googleMapPolyline = GoogleMapPolyline(apiKey: apiKey!);
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
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final RideRequestCubit reqCubit =
        BlocProvider.of<RideRequestCubit>(context);

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
            widget.offer.source.lat,
            widget.offer.source.lang,
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

    setCustomMarkers();

    void setDriverPath() async {
      List<LatLng>? coords = await googleMapPolyline.getCoordinatesWithLocation(
          origin: LatLng(
            widget.offer.source.lat,
            widget.offer.source.lang,
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

    setDriverPath();

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

    setRiderPath();

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
                  polylines: {
                    Polyline(
                      polylineId: const PolylineId("driver-route"),
                      color: BlipColors.black,
                      points: driverCoords,
                      width: 2,
                      onTap: () {},
                    ),
                    Polyline(
                      polylineId: const PolylineId("rider-route"),
                      color: BlipColors.orange,
                      points: riderCoords,
                      width: 3,
                      onTap: () {},
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
                    UserCard(widget.offer.driver),
                    const Divider(
                      color: BlipColors.grey,
                      indent: 8.0,
                      endIndent: 8.0,
                    ),
                    Expanded(
                        child: RideOfferTimeline(widget.offer,
                            reqCubit.state.source, reqCubit.state.destination)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          addHorizontalSpace(8.0),
                          Text(
                            "Rs. ${reqCubit.state.distance}",
                            style: BlipFonts.heading,
                          ),
                          const Spacer(),
                          SizedBox(
                            width: size.width * 0.5,
                            child: reqCubit.state.offerIDs
                                    .contains(widget.offer.id)
                                ? WideButton(
                                    onPressedAction: () {
                                      reqCubit.removeOffer(widget.offer.id);
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
                                      reqCubit.addOffer(widget.offer.id);
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
