import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_countdown_timer/index.dart';

import 'package:mobile/colors.dart';
import 'package:mobile/cubits/active_ride_cubit.dart';
import 'package:mobile/custom/cards/home_screen_card.dart';
import 'package:mobile/icons.dart';
import 'package:mobile/fonts.dart';
import 'package:mobile/screens/current-ride/final_ride_details.dart';
import 'package:mobile/screens/view-ride-requests/view_ride_requests_screen.dart';

class RideCountDown extends StatefulWidget {
  final int endTime;

  const RideCountDown(this.endTime, {Key? key}) : super(key: key);

  @override
  State<RideCountDown> createState() => _RideCountDownState();
}

class _RideCountDownState extends State<RideCountDown> {
  late CountdownTimerController controller;

  @override
  void initState() {
    super.initState();
    controller =
        CountdownTimerController(endTime: widget.endTime, onEnd: () => {});
  }

  @override
  Widget build(BuildContext context) {
    TextStyle whiteText = const TextStyle(color: BlipColors.white);
    final Size size = MediaQuery.of(context).size;

    return CountdownTimer(
      controller: controller,
      widgetBuilder: (_, CurrentRemainingTime? time) {
        if (time == null) {
          return HomeScreenCard(
              text: 'Trip In Progress', route: const ViewRideRequestsScreen());
        }
        return Container(
          width: size.width,
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
            top: 12,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: BlipColors.orange,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  text: '${time.days ?? 0}',
                  style: BlipFonts.display.merge(whiteText),
                  children: [
                    TextSpan(
                      text: (time.days == null || time.days! > 1)
                          ? ' days'
                          : ' day',
                      style: BlipFonts.labelBold,
                    ),
                    TextSpan(
                      text: ' ${time.hours ?? 0}',
                      style: BlipFonts.display,
                    ),
                    TextSpan(
                      text: (time.hours == null || time.hours! > 1)
                          ? ' hrs'
                          : ' hr',
                      style: BlipFonts.labelBold,
                    ),
                    TextSpan(
                      text: ' ${time.min ?? 0}',
                      style: BlipFonts.display,
                    ),
                    TextSpan(
                      text: (time.min == null || time.min! > 1)
                          ? ' mins'
                          : ' min',
                      style: BlipFonts.labelBold,
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'more for your next ride',
                    style: BlipFonts.outline
                        .merge(const TextStyle(color: BlipColors.white)),
                  ),
                  IconButton(
                    icon: const Icon(
                      BlipIcons.arrowRight,
                      size: 20,
                      color: BlipColors.white,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              // Show final ride details screen if there's less than 2hrs for the ride
                              // (time.hours == null || time.hours! < 2)
                              //     ? const ViewRideRequestsScreen()
                              //     : const FinalRideDetailsScreen(),
                              const ViewRideRequestsScreen()
                        ),
                      );
                    },
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
