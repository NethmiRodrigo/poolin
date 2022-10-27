import 'dart:async';
import 'package:dio/dio.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_map_polyline_new/google_map_polyline_new.dart';
import 'package:jiffy/jiffy.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:poolin/cubits/active_ride_cubit.dart';
import 'package:poolin/cubits/ride_request_cubit.dart';
import 'package:poolin/custom/backward_button.dart';
import 'package:poolin/custom/wide_button.dart';
import 'package:poolin/screens/view-profile/driver_profile_screen.dart';
import 'package:poolin/screens/view-profile/rider_profile_screen.dart';
import 'package:poolin/screens/view-ride-requests/accept_request_confirmation_screen.dart';
import 'package:poolin/services/ride_offer_service.dart';
import 'package:poolin/services/ride_request_service.dart';
import 'package:poolin/utils/map_utils.dart';

import 'package:poolin/utils/widget_functions.dart';

import '../../colors.dart';
import '../../custom/dashed_line.dart';
import '../../custom/indicator.dart';
import '../../custom/outline_button.dart';
import '../../fonts.dart';

class ReserveRequestScreen extends StatefulWidget {
  final request;

  const ReserveRequestScreen({super.key, required this.request});

  @override
  ReserveRequestScreenState createState() {
    return ReserveRequestScreenState();
  }
}

class ReserveRequestScreenState extends State<ReserveRequestScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  String? apiKey;

  late ActiveRideCubit activeRideCubit;
  late RideRequestCubit rideReqCubit;
  Map<String, dynamic> requestDetails = {};

  Set<Marker> _markers = {};
  List<LatLng> coords = [];
  late GoogleMapPolyline googleMapPolyline;

  late LatLng passPickup;
  late LatLng passDrop;

  BitmapDescriptor startMarker = BitmapDescriptor.defaultMarker;
  BitmapDescriptor dropoffMarker = BitmapDescriptor.defaultMarker;
  BitmapDescriptor pickupMarker = BitmapDescriptor.defaultMarker;

  bool isLoading = false;

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  void initState() {
    super.initState();
    getRequest();
    apiKey = dotenv.env['MAPS_API_KEY'];
    googleMapPolyline = GoogleMapPolyline(apiKey: apiKey!);
    rideReqCubit = BlocProvider.of<RideRequestCubit>(context);
    activeRideCubit = BlocProvider.of<ActiveRideCubit>(context);
  }

  void getRequest() async {
    setState(() {
      isLoading = true;
    });

    var id = widget.request["requestid"];
    Response response = await getRequestDetails(id);
    if (response.data['request'] != null) {
      setState(() {
        requestDetails = response.data['request'];
        passPickup = LatLng(requestDetails['source']['coordinates'][0],
            requestDetails['source']['coordinates'][1]);
        passDrop = LatLng(
          requestDetails['destination']['coordinates'][0],
          requestDetails['destination']['coordinates'][1],
        );
        isLoading = false;
      });
      getPolyPoints();
      setCustomMarkers();
    }
  }

  void setCustomMarkers() async {
    //Create custom icons
    BitmapDescriptor startIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty,
      "assets/images/source-pin-grey.png",
    );

    BitmapDescriptor dropOffIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty,
      "assets/images/location-pin-orange.png",
    );

    BitmapDescriptor pickupIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty,
      "assets/images/source-pin-black.png",
    );

    setState(() {
      pickupMarker = pickupIcon;
      dropoffMarker = dropOffIcon;
      startMarker = startIcon;
    });

    // Create markers
    Set<Marker> markers = {
      Marker(
        markerId: const MarkerId('pickup'),
        position: passPickup,
        icon: pickupMarker,
        infoWindow: const InfoWindow(title: 'You start here'),
      ),
      Marker(
        markerId: const MarkerId('start'),
        position: LatLng(
          activeRideCubit.state.source.lat,
          activeRideCubit.state.source.lang,
        ),
        icon: startMarker,
      ),
      Marker(
        markerId: const MarkerId('dropoff'),
        position: passDrop,
        icon: dropoffMarker,
        infoWindow: const InfoWindow(title: 'You finish here'),
      ),
    };
    setState(() {
      _markers = markers;
    });
  }

  void getPolyPoints() async {
    List<LatLng>? results = await googleMapPolyline.getCoordinatesWithLocation(
        origin: passPickup, destination: passDrop, mode: RouteMode.driving);
    setState(() {
      if (results != null) {
        coords = results;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ActiveRideCubit offerCubit = BlocProvider.of<ActiveRideCubit>(context);
    final Size size = MediaQuery.of(context).size;
    const double padding = 16;
    const sidePadding = EdgeInsets.symmetric(horizontal: padding);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: const BackwardButton(),
      ),
      body: (requestDetails.isEmpty ||
              isLoading ||
              coords.isEmpty ||
              _markers.isEmpty)
          ? const Center(
              child: CircularProgressIndicator(
                color: BlipColors.orange,
              ),
            )
          : SizedBox(
              width: size.width,
              height: size.height,
              child: SingleChildScrollView(
                child: Padding(
                  padding: sidePadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Reservation Request',
                        style: BlipFonts.title,
                      ),
                      addVerticalSpace(16),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: SizedBox(
                          height: 160,
                          child: GoogleMap(
                              onMapCreated: _onMapCreated,
                              initialCameraPosition: CameraPosition(
                                target: passDrop,
                                zoom: 12.0,
                              ),
                              mapType: MapType.normal,
                              markers: _markers,
                              polylines: {
                                Polyline(
                                  polylineId: const PolylineId("route"),
                                  color: BlipColors.blue,
                                  points: coords,
                                  width: 3,
                                ),
                              }),
                        ),
                      ),
                      addVerticalSpace(24),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          Jiffy(requestDetails['startTime'])
                              .format("EEEE, do MMMM, yyyy"),
                          style: BlipFonts.outline,
                        ),
                      ),
                      addVerticalSpace(32),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Text(
                                  Jiffy(DateTime.parse(
                                          requestDetails['startTime']))
                                      .format("hh:mm a"),
                                  style: BlipFonts.outlineBold),
                              addVerticalSpace(32),
                              const Text("02.30 PM",
                                  style: BlipFonts.outlineBold),
                            ],
                          ),
                          Column(
                            children: [
                              const Icon(
                                Icons.check_box_outline_blank_rounded,
                                color: BlipColors.orange,
                                size: 16,
                              ),
                              CustomPaint(
                                  size: const Size(1, 18),
                                  painter: DashedLineVerticalPainter()),
                              const Icon(EvaIcons.arrowIosDownward,
                                  color: BlipColors.orange),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(requestDetails['source']['name'],
                                  style: BlipFonts.labelBold.merge(
                                      const TextStyle(
                                          color: BlipColors.orange))),
                              addVerticalSpace(24),
                              Text(requestDetails['destination']['name'],
                                  style: BlipFonts.labelBold.merge(
                                      const TextStyle(
                                          color: BlipColors.orange))),
                            ],
                          )
                        ],
                      ),
                      addVerticalSpace(40),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text(
                                  ("total trip fare").toUpperCase(),
                                  style: BlipFonts.outlineBold,
                                ),
                                addVerticalSpace(16),
                                Row(
                                  children: [
                                    Text(
                                      'Rs. ${activeRideCubit.getPrice().toString()}',
                                      style: BlipFonts.labelBold,
                                    ),
                                    addHorizontalSpace(8),
                                    Indicator(
                                        icon: Icons.arrow_upward,
                                        text:
                                            '+ Rs. ${requestDetails["price"]}',
                                        color: BlipColors.green),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  ("room availible").toUpperCase(),
                                  style: BlipFonts.outlineBold,
                                ),
                                addVerticalSpace(16),
                                Row(
                                  children: [
                                    Text(
                                      activeRideCubit.getSeats().toString(),
                                      style: BlipFonts.labelBold,
                                    ),
                                    addHorizontalSpace(8),
                                    const Indicator(
                                        icon: Icons.arrow_downward,
                                        text: "-1",
                                        color: BlipColors.red),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      addVerticalSpace(32),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: BlipColors.lightGrey,
                                foregroundImage:
                                    NetworkImage(widget.request["avatar"]),
                              ),
                              addHorizontalSpace(8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.request["fname"] +
                                        " " +
                                        widget.request["lname"],
                                    style: BlipFonts.outline,
                                  ),
                                ],
                              )
                            ],
                          ),
                          OutlineButton(
                            onPressedAction: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DriverProfileScreen(
                                        requestDetails["id"])),
                              );
                            },
                            text: "See Profile",
                            color: BlipColors.black,
                          )
                        ],
                      ),
                      addVerticalSpace(40),
                      WideButton(
                          text: 'Reserve a Seat',
                          onPressedAction: () async {
                            Response postResponse = await acceptRequest(
                                offerCubit.getId(),
                                widget.request['requestid']);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const AcceptRequestConfirmation()),
                            );
                          })
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
