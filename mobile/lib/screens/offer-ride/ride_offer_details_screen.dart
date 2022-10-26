import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:poolin/colors.dart';
import 'package:poolin/cubits/ride_offer_cubit.dart';
import 'package:poolin/models/coordinate_model.dart';
import 'package:poolin/screens/offer-ride/offer_details_card.dart';
import 'package:poolin/services/polyline_service.dart';

import 'package:poolin/utils/map_utils.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class RideOfferDetailsScreen extends StatefulWidget {
  const RideOfferDetailsScreen({super.key});

  @override
  RideOfferDetailsScreenState createState() {
    return RideOfferDetailsScreenState();
  }
}

class RideOfferDetailsScreenState extends State<RideOfferDetailsScreen> {
  final _storage = const FlutterSecureStorage();
  final Completer<GoogleMapController> _controller = Completer();
  late GooglePlace googlePlace;
  Set<Marker> _markers = {};
  BitmapDescriptor sourceMarker = BitmapDescriptor.defaultMarker;
  BitmapDescriptor destinationMarker = BitmapDescriptor.defaultMarker;
  final MapType _currentMapType = MapType.normal;
  late RideOfferCubit offerCubit;

  Map<PolylineId, Polyline> polylines = {};

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
    offerCubit = BlocProvider.of<RideOfferCubit>(context);
    setCustomMarkers();
    googlePlace = GooglePlace(apiKey!);
    _getPolyline();
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

  _getPolyline() async {
    final Coordinate source = offerCubit.state.source;
    final Coordinate destination = offerCubit.state.destination;

    BitmapDescriptor startIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty,
      "assets/images/source-pin-black.png",
    );

    BitmapDescriptor destinationIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty,
      "assets/images/location-pin-orange.png",
    );
    //Set markers
    Set<Marker> markers = {
      Marker(
        markerId: const MarkerId('source'),
        position: LatLng(source.lat, source.lang),
        draggable: false,
        icon: startIcon,
      ),
      Marker(
        markerId: const MarkerId('destination'),
        position: LatLng(destination.lat, destination.lang),
        draggable: false,
        icon: destinationIcon,
      ),
    };
    setState(() {
      _markers = markers;
    });

    var result = await getPolyline(
        source.lat, source.lang, destination.lat, destination.lang);
    setState(() {
      polylines = result;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                height: constraints.maxHeight * 1 / 2,
                child: GoogleMap(
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
            },
          ),
          DraggableScrollableSheet(
              initialChildSize: 1 / 2,
              minChildSize: 1 / 2,
              maxChildSize: 1 / 2,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return const OfferDetailsCard();
              })
        ],
      ),
    );
  }
}
