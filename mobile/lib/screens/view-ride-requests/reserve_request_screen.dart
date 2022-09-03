import 'dart:async';

import 'package:dio/dio.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';
import 'package:mobile/cubits/active_ride_cubit.dart';
import 'package:mobile/custom/backward_button.dart';

import 'package:mobile/custom/wide_button.dart';
import 'package:mobile/screens/view-profile/rider_profile_screen.dart';
import 'package:mobile/screens/view-ride-requests/accept_request_confirmation_screen.dart';
import 'package:mobile/services/ride_offer_service.dart';
import 'package:mobile/services/ride_request_service.dart';

import 'package:mobile/utils/widget_functions.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../colors.dart';
import '../../custom/dashed_line.dart';
import '../../custom/indicator.dart';
import '../../custom/outline_button.dart';
import '../../fonts.dart';

class ReserveRequestScreen extends StatefulWidget {
  const ReserveRequestScreen({super.key, required this.request});

  final request;

  @override
  ReserveRequestScreenState createState() {
    return ReserveRequestScreenState();
  }
}

class ReserveRequestScreenState extends State<ReserveRequestScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  late GooglePlace googlePlace;
  List<AutocompletePrediction> predictions = [];
  Map<String, dynamic> requestDetails = {};

  static const LatLng _center = LatLng(6.9271, 79.8612);

  final Set<Marker> _markers = {};

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  void initState() {
    String? apiKey = dotenv.env['MAPS_API_KEY'];
    googlePlace = GooglePlace(apiKey!);
    getRequest();
    super.initState();
  }

  void getRequest() async {
    var id = widget.request["requestid"];
    Response response = await getRequestDetails(id);
    if (response.data['request'] != null) {
      setState(() {
        requestDetails = response.data['request'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ActiveRideCubit offerCubit = BlocProvider.of<ActiveRideCubit>(context);
    final Size size = MediaQuery.of(context).size;
    const double padding = 16;
    const sidePadding = EdgeInsets.symmetric(horizontal: padding);
    ActiveRideCubit activeRideCubit = BlocProvider.of<ActiveRideCubit>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: const BackwardButton(),
      ),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Padding(
          padding: sidePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Reservation Request',
                style: BlipFonts.title,
              ),
              addVerticalSpace(32),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  height: 160,
                  child: GoogleMap(
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: const CameraPosition(
                      target: _center,
                      zoom: 12.0,
                    ),
                    markers: _markers,
                  ),
                ),
              ),
              addVerticalSpace(24),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  Jiffy(requestDetails['starttime'])
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
                      Text(Jiffy(requestDetails['starttime']).format("hh:mm a"),
                          style: BlipFonts.outlineBold),
                      addVerticalSpace(32),
                      const Text("12.30 AM", style: BlipFonts.outlineBold),
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
                      Text(widget.request["start"],
                          style: BlipFonts.labelBold.merge(
                              const TextStyle(color: BlipColors.orange))),
                      addVerticalSpace(24),
                      Text(widget.request["end"],
                          style: BlipFonts.labelBold.merge(
                              const TextStyle(color: BlipColors.orange))),
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
                                text: '+ Rs. ${requestDetails["price"]}',
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
                      if (widget.request["avatar"] != null)
                        CircleAvatar(
                          backgroundImage:
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
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  //star icon
                                  const Icon(EvaIcons.star,
                                      color: BlipColors.gold, size: 8),
                                  addHorizontalSpace(4),
                                  const Text(
                                    "4.5",
                                    style: BlipFonts.tagline,
                                  ),
                                ],
                              ),
                              addHorizontalSpace(8),
                              const Icon(
                                Icons.circle,
                                size: 2,
                              ),
                              addHorizontalSpace(8),
                              const Text("250 ratings",
                                  style: BlipFonts.tagline),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                  OutlineButton(
                    onPressedAction: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              RiderProfileScreen(id: requestDetails['id']),
                        ),
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
                        offerCubit.getId(), widget.request['requestid']);
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
    );
  }
}
