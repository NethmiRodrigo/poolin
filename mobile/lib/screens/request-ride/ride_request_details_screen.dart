import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:poolin/colors.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:poolin/services/polyline_service.dart';
import 'package:poolin/utils/map_utils.dart';

import 'package:poolin/screens/request-ride/request_details_card.dart';

class RideRequestDetailsScreen extends StatefulWidget {
  const RideRequestDetailsScreen({super.key});

  @override
  RideRequestDetailsScreenState createState() {
    return RideRequestDetailsScreenState();
  }
}

class RideRequestDetailsScreenState extends State<RideRequestDetailsScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  final _storage = const FlutterSecureStorage();
  late GooglePlace googlePlace;
  Map<PolylineId, Polyline> polylines = {};
  Set<Marker> _markers = {};
  late CameraPosition _initalPosition;
  String? apiKey = dotenv.env['MAPS_API_KEY'];

  static const LatLng _center = LatLng(6.9271, 79.8612);

  final MapType _currentMapType = MapType.normal;

  void _onCameraMove(CameraPosition position) {}

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

  @override
  void initState() {
    googlePlace = GooglePlace(apiKey!);
    super.initState();
  }

  _getPolyline() async {
    var sourceString = (await _storage.read(key: "SOURCE"));
    var sourceLocation = jsonDecode(sourceString!);
    var destinationString = (await _storage.read(key: "DESTINATION"));
    var destinationLocation = jsonDecode(destinationString!);
    //Set markers
    Set<Marker> markers = {
      Marker(
        markerId: const MarkerId('source'),
        position:
            LatLng(sourceLocation['latitude'], sourceLocation['longitude']),
        draggable: false,
      ),
      Marker(
        markerId: const MarkerId('destination'),
        position: LatLng(
            destinationLocation['latitude'], destinationLocation['longitude']),
        draggable: false,
      ),
    };
    setState(() {
      _markers = markers;
      _initalPosition = CameraPosition(
          target:
              LatLng(sourceLocation['latitude'], sourceLocation['longitude']),
          zoom: 20);
    });

    var result = await getPolyline(
        sourceLocation['latitude'],
        sourceLocation['longitude'],
        destinationLocation['latitude'],
        destinationLocation['longitude']);
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
              height: constraints.maxHeight / 2,
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: const CameraPosition(
                  target: _center,
                  zoom: 12.0,
                ),
                mapType: _currentMapType,
                markers: _markers,
                polylines: Set<Polyline>.of(polylines.values),
                onCameraMove: _onCameraMove,
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
