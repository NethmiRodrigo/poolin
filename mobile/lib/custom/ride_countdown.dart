import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/index.dart';

import 'package:poolin/colors.dart';
import 'package:poolin/custom/cards/home_screen_card.dart';
import 'package:poolin/icons.dart';
import 'package:poolin/fonts.dart';
import 'package:poolin/screens/current-ride/driver_nav.dart';
import 'package:poolin/screens/current-ride/final_ride_details.dart';
import 'package:poolin/screens/view-ride-requests/view_ride_requests_screen.dart';

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
                      // Show final ride details screen if there's less than 2hrs for the ride
                      // (time.days == null && time.hours! < 2)
                      //     ? Navigator.push(
                      //         context,
                      //         MaterialPageRoute(
                      //           builder: (context) =>
                      //               const FinalRideDetailsScreen(),
                      //         ),
                      //       )
                      //     : Navigator.push(
                      //         context,
                      //         MaterialPageRoute(
                      //           builder: (context) =>
                      //               const ViewRideRequestsScreen(),
                      //         ),
                      //       );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ViewRideRequestsScreen(),
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
