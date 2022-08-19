import 'package:flutter/material.dart';
import 'package:poolin/colors.dart';
import 'package:poolin/screens/request-ride/view_requested_rides.dart';
import 'package:poolin/screens/view-ride-requests/view_ride_requests_screen.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

import 'package:poolin/custom/wide_button.dart';
import 'package:poolin/utils/widget_functions.dart';

import 'package:poolin/fonts.dart';

class RequestDetailsCard extends StatefulWidget {
  const RequestDetailsCard({Key? key}) : super(key: key);

  @override
  State<RequestDetailsCard> createState() => _RequestDetailsCardState();
}

class _RequestDetailsCardState extends State<RequestDetailsCard> {
  bool isChecked = false;

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.black;
    }
    return Colors.black;
  }

  double _value = 1200.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Confirm your Ride Requests",
            style: BlipFonts.title,
          ),
          addVerticalSpace(20.0),
          const Text(
            "Monday, 23rd June",
            style: BlipFonts.labelBold,
          ),
          addVerticalSpace(5.0),
          const Text(
            "8.00 AM +- 45 mins",
            style: BlipFonts.label,
          ),
          addVerticalSpace(20.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              children: [
                SizedBox(
                  height: 70,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return const Align(
                        widthFactor: 0.6,
                        child: CircleAvatar(
                          radius: 30,
                          backgroundImage:
                              NetworkImage('https://i.pravatar.cc/300'),
                        ),
                      );
                    },
                  ),
                ),
                addHorizontalSpace(25.0),
                const Text(
                  "+7 requests",
                  style: BlipFonts.labelBold,
                )
              ],
            ),
          ),
          addVerticalSpace(20.0),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 20,
                height: 20,
                child: Checkbox(
                  checkColor: BlipColors.white,
                  fillColor: MaterialStateProperty.resolveWith(getColor),
                  value: isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      isChecked = value!;
                    });
                  },
                ),
              ),
              addHorizontalSpace(10.0),
              const Text(
                "I want to set my own price",
                style: BlipFonts.label,
              ),
            ],
          ),
          addVerticalSpace(45.0),
          SfSlider(
            min: 1000.0,
            max: 5000.0,
            value: _value,
            interval: 10,
            enableTooltip: true,
            shouldAlwaysShowTooltip: true,
            activeColor: BlipColors.black,
            inactiveColor: BlipColors.grey,
            onChanged: isChecked
                ? (dynamic value) {
                    setState(() {
                      _value = value;
                    });
                  }
                : null,
          ),
          addVerticalSpace(20.0),
          WideButton(
            text: "I'll depart at around 8 AM in 2 days",
            onPressedAction: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((context) => const RequestedTrips()),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
