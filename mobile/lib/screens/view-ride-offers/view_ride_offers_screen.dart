import 'dart:convert';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jiffy/jiffy.dart';

import 'package:mobile/colors.dart';
import 'package:mobile/fonts.dart';

import 'package:mobile/custom/wide_button.dart';
import 'package:mobile/models/ride_offer_search_result.dart';
import 'package:mobile/screens/request-ride/ride_request_details_screen.dart';
import 'package:mobile/utils/widget_functions.dart';

import 'package:mobile/custom/lists/ride_offer_result_list.dart';

import 'package:mobile/constants/search_offer_results.dart';

class ViewRideOffersScreen extends StatefulWidget {
  const ViewRideOffersScreen({Key? key}) : super(key: key);

  @override
  State<ViewRideOffersScreen> createState() => _ViewRideOffersScreenState();
}

class _ViewRideOffersScreenState extends State<ViewRideOffersScreen> {
  final _storage = const FlutterSecureStorage();
  DateTime startTime = DateTime.now().add(const Duration(days: 1));
  var sourceLocation = {};
  var destinationLocation = {};

  final List<RideOfferSearchResult> _rideOffers = results;

  _getLocation() async {
    var sourceString = (await _storage.read(key: "SOURCE"));
    var destinationString = (await _storage.read(key: "DESTINATION"));

    setState(() {
      sourceLocation = jsonDecode(sourceString!);
      destinationLocation = jsonDecode(destinationString!);
    });
  }

  @override
  void initState() {
    _getLocation();
    super.initState();
  }

  Future<DateTime?> showDatePicker() {
    return DatePicker.showDateTimePicker(context,
        showTitleActions: true,
        minTime: DateTime.now().add(const Duration(days: 1)),
        maxTime: DateTime.now().add(const Duration(days: 7)),
        onChanged: (date) {}, onConfirm: (date) {
      setState(() {
        startTime = date;
      });
    }, currentTime: startTime, locale: LocaleType.en);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: BlipColors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.filter_list),
            color: BlipColors.black,
          )
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 25.0),
            child: Expanded(
              child: Column(
                children: [
                  TextButton(
                    onPressed: () {
                      showDatePicker();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${Jiffy(startTime).yMMMd} ${Jiffy(startTime).format("h:mm a")} ',
                          style: BlipFonts.labelBold
                              .merge(const TextStyle(color: BlipColors.black)),
                          textAlign: TextAlign.start,
                        ),
                        const Icon(
                          FluentIcons.edit_16_regular,
                          color: BlipColors.orange,
                          size: 14,
                        )
                      ],
                    ),
                  ),
                  addVerticalSpace(10.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "From",
                        style: BlipFonts.outline,
                      ),
                      const Spacer(
                        flex: 1,
                      ),
                      Expanded(
                        child: Text(
                          sourceLocation['name'] ?? "Loading...",
                          style: BlipFonts.label,
                          textAlign: TextAlign.end,
                          overflow: TextOverflow.clip,
                        ),
                      ),
                    ],
                  ),
                  addVerticalSpace(10.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "To",
                        style: BlipFonts.outline,
                      ),
                      addHorizontalSpace(8.0),
                      const Spacer(
                        flex: 1,
                      ),
                      Expanded(
                        child: Text(
                          destinationLocation['name'] ?? "Loading...",
                          style: BlipFonts.label,
                          textAlign: TextAlign.end,
                          overflow: TextOverflow.clip,
                        ),
                      ),
                    ],
                  ),
                  addVerticalSpace(20.0),
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        child: const Text(
                          "Browse through available rides",
                          style: BlipFonts.heading,
                        ),
                      )
                    ],
                  ),
                  addVerticalSpace(20.0),
                  Expanded(
                    child: RideOfferResultList(_rideOffers, "view"),
                  ),
                  addVerticalSpace(30.0),
                  WideButton(
                    onPressedAction: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: ((context) =>
                              const RideRequestDetailsScreen()),
                        ),
                      );
                    },
                    text: "Proceed",
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
