import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/index.dart';

import 'package:mobile/colors.dart';
import 'package:mobile/icons.dart';
import 'package:mobile/fonts.dart';
import 'package:mobile/screens/shared/ride/destination_screen.dart';

class RideCountDown extends StatefulWidget {
  final int endTime;

  RideCountDown(this.endTime);

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
    final Size size = MediaQuery.of(context).size;

    return CountdownTimer(
      controller: controller,
      widgetBuilder: (_, CurrentRemainingTime? time) {
        if (time == null) {
          return const Text(
            'Trip in Progress',
            style: BlipFonts.labelBold,
          );
        }
        return Container(
          width: size.width,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          height: 100,
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
                  text: '${time.days}',
                  style: BlipFonts.display,
                  children: [
                    TextSpan(
                      text: time.days! > 1 ? ' days' : ' day',
                      style: BlipFonts.labelBold,
                    ),
                    TextSpan(
                      text: ' ${time.hours}',
                      style: BlipFonts.display,
                    ),
                    TextSpan(
                      text: time.hours! > 1 ? ' hrs' : ' hr',
                      style: BlipFonts.labelBold,
                    ),
                    TextSpan(
                      text: ' ${time.min}',
                      style: BlipFonts.display,
                    ),
                    TextSpan(
                      text: time.min! > 1 ? ' mins' : ' min',
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
                      BlipIcons.arrow_right,
                      size: 20,
                      color: BlipColors.white,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DestinationScreen(),
                          ));
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
