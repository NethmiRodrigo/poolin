import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:poolin/colors.dart';
import 'package:poolin/custom/indicator.dart';
import 'package:poolin/custom/lists/ride_offer_result_list.dart';
import 'package:poolin/fonts.dart';
import 'package:poolin/utils/widget_functions.dart';

class RequestedTrips extends StatefulWidget {
  const RequestedTrips({Key? key}) : super(key: key);

  @override
  State<RequestedTrips> createState() => _RequestedTripsState();
}

class _RequestedTripsState extends State<RequestedTrips> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: BackButton(
          color: BlipColors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Requested Trips",
                style: BlipFonts.display,
              ),
              addVerticalSpace(10.0),
              const Text(
                "Monday, 23rd June",
                style: BlipFonts.heading,
              ),
              addVerticalSpace(8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "8.00 AM",
                    style: BlipFonts.outline,
                  ),
                  addHorizontalSpace(5.0),
                  const Icon(
                    CupertinoIcons.add,
                    size: 8.0,
                    color: BlipColors.grey,
                  ),
                  const Indicator(
                      icon: CupertinoIcons.minus,
                      text: "30 mins",
                      color: BlipColors.grey),
                ],
              ),
              addVerticalSpace(10.0),
              const Expanded(
                child: RideOfferResultList("requested"),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
