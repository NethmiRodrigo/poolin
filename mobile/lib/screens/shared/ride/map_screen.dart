import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:mobile/colors.dart';
import 'package:mobile/custom/outline_button.dart';
import 'package:mobile/custom/wide_button.dart';
import 'package:mobile/fonts.dart';
import 'package:mobile/models/ride_type_model.dart';
import 'package:mobile/screens/offer-ride/ride_offer_details_screen.dart';
import 'package:mobile/screens/request-ride/ride_request_details_screen.dart';
import 'package:mobile/utils/map_utils.dart';
import 'package:mobile/utils/widget_functions.dart';

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
  String rideType = RideType.offer.name;
  late CameraPosition _initalPosition;
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();

  String? apiKey = dotenv.env['MAPS_API_KEY'];

  @override
  void initState() {
    __loadRideType();
    super.initState();
    _initalPosition = CameraPosition(
        target: LatLng(widget.sourcePosition!.geometry!.location!.lat!,
            widget.sourcePosition!.geometry!.location!.lng!),
        zoom: 20);
  }

  __loadRideType() async {
    final rideTypeFromStorage = (await _storage.read(key: "RIDE_TYPE"))!;
    if (rideTypeFromStorage != null) {
      rideType = rideTypeFromStorage;
    }
  }

  _addPolyLine() {
    PolylineId id = const PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id,
        color: BlipColors.orange,
        points: polylineCoordinates,
        width: 2);
    polylines[id] = polyline;
    setState(() {});
  }

  _getPolyline() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        apiKey!,
        PointLatLng(widget.sourcePosition!.geometry!.location!.lat!,
            widget.sourcePosition!.geometry!.location!.lng!),
        PointLatLng(widget.destinationPosition!.geometry!.location!.lat!,
            widget.destinationPosition!.geometry!.location!.lng!),
        travelMode: TravelMode.driving);
    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    }
    _addPolyLine();
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
        prefixIcon: const Icon(Icons.location_on_outlined),
        prefixIconColor: BlipColors.orange,
        hintText: type == "source"
            ? widget.sourcePosition!.name
            : widget.destinationPosition!.name,
        hintStyle: BlipFonts.label,
        filled: true,
        fillColor: BlipColors.lightGrey,
        contentPadding: const EdgeInsets.all(8.0),
      ),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Set<Marker> _markers = {
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
              height: constraints.maxHeight / 3 * 2,
              child: GoogleMap(
                initialCameraPosition: _initalPosition,
                markers: Set.from(_markers),
                polylines: Set<Polyline>.of(polylines.values),
                onMapCreated: (GoogleMapController controller) {
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
                },
              ),
            );
          },
        ),
        DraggableScrollableSheet(
            initialChildSize: 1 / 3,
            minChildSize: 1 / 3,
            maxChildSize: 1 / 3,
            builder: (BuildContext context, ScrollController scrollController) {
              return Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    const Text(
                      "Your Trip Details",
                      style: BlipFonts.heading,
                    ),
                    addVerticalSpace(5.0),
                    const Divider(
                      thickness: 1,
                      color: BlipColors.orange,
                    ),
                    addVerticalSpace(10.0),
                    _addLocationSearchField("source"),
                    addVerticalSpace(10.0),
                    _addLocationSearchField("destination"),
                    addVerticalSpace(10.0),
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
                                  : const RideRequestDetailsScreen(),
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
