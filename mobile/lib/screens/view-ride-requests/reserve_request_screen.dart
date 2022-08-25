import 'dart:async';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jiffy/jiffy.dart';
import 'package:mobile/custom/backward_button.dart';

import 'package:mobile/custom/wide_button.dart';

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
  final request;

  const ReserveRequestScreen({super.key, required this.request});

  @override
  ReserveRequestScreenState createState() {
    return ReserveRequestScreenState();
  }
}

class ReserveRequestScreenState extends State<ReserveRequestScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();
  final Completer<GoogleMapController> _controller = Completer();
  late GooglePlace googlePlace;
  List<AutocompletePrediction> predictions = [];

  static const LatLng _center = LatLng(6.9271, 79.8612);

  final Set<Marker> _markers = {};

  LatLng _lastMapPosition = _center;

  final MapType _currentMapType = MapType.normal;

  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  void initState() {
    String? apiKey = dotenv.env['MAPS_API_KEY'];
    googlePlace = GooglePlace(apiKey!);
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _pass.dispose();
    _confirmPass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    const double padding = 16;
    const sidePadding = EdgeInsets.symmetric(horizontal: padding);

    return Scaffold(
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Padding(
          padding: sidePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              addVerticalSpace(44),
              // Text(widget.request["fname"]),
              const BackwardButton(),
              addVerticalSpace(16),
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
                    mapType: _currentMapType,
                    markers: _markers,
                    onCameraMove: _onCameraMove,
                  ),
                ),
              ),
              addVerticalSpace(24),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  Jiffy(widget.request["date"]).format("EEEE, do MMMM, yyyy"),
                  style: BlipFonts.outline,
                ),
              ),
              addVerticalSpace(32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      const Text("11.30 AM", style: BlipFonts.outlineBold),
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
                      const Icon(EvaIcons.arrowIosDownward, color: BlipColors.orange),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.request["start"],
                          style: BlipFonts.labelBold
                              .merge(const TextStyle(color: BlipColors.orange))),
                      addVerticalSpace(24),
                      Text(widget.request["end"],
                          style: BlipFonts.labelBold
                              .merge(const TextStyle(color: BlipColors.orange))),
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
                            const Text(
                              "Rs. 5500",
                              style: BlipFonts.labelBold,
                            ),
                            addHorizontalSpace(8),
                            Indicator(
                                icon: Icons.arrow_upward,
                                text: "+ Rs. " + widget.request["price"],
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
                            const Text(
                              "0",
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
                        backgroundImage: NetworkImage(widget.request["avatar"]),
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
                              const Text("250 ratings", style: BlipFonts.tagline),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                  OutlineButton(
                    onPressedAction: () {},
                    text: "See Profile",
                    color: BlipColors.black,
                  )
                ],
              ),
              addVerticalSpace(40),
              WideButton(text: 'Reserve a Seat', onPressedAction: () {})
            ],
          ),
        ),
      ),
    );
  }
}
