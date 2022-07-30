import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:mobile/colors.dart';
import 'package:mobile/fonts.dart';

import 'package:mobile/custom/wide_button.dart';
import 'package:mobile/models/ride_offer_search_result.dart';
import 'package:mobile/screens/request-ride/ride_request_details_screen.dart';
import 'package:mobile/utils/widget_functions.dart';

import 'package:mobile/custom/lists/ride_offer_result_list.dart';

import 'package:mobile/constants/search_offer_results.dart';

class RideOfferResultsScreen extends StatefulWidget {
  const RideOfferResultsScreen({Key? key}) : super(key: key);

  @override
  State<RideOfferResultsScreen> createState() => _RideOfferResultsScreenState();
}

class _RideOfferResultsScreenState extends State<RideOfferResultsScreen> {
  final _storage = const FlutterSecureStorage();
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
                  Row(
                    children: const [
                      Text(
                        "Monday, 23rd June",
                        style: BlipFonts.labelBold,
                      ),
                      Spacer(),
                      Text(
                        "07:00 AM",
                        style: BlipFonts.labelBold,
                      ),
                    ],
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
                    child: RideOfferResultList(_rideOffers),
                  ),
                  addVerticalSpace(10.0),
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
                    text: "Don't like any offers? Post a ride request",
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