import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:poolin/colors.dart';
import 'package:poolin/custom/dashed_line.dart';
import 'package:poolin/custom/outline_button.dart';
import 'package:poolin/fonts.dart';
import 'package:poolin/icons.dart';
import 'package:poolin/utils/widget_functions.dart';

class RideOfferTimeline extends StatelessWidget {
  const RideOfferTimeline({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                BlipIcons.destination,
              ),
              addHorizontalSpace(10.0),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('University of Colomo School of Computing',
                      style: BlipFonts.outline),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    decoration: BoxDecoration(
                      color: BlipColors.lightGrey,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      ('Yadeesha begins journey').toUpperCase(),
                      style: BlipFonts.taglineBold
                          .merge(const TextStyle(color: BlipColors.orange)),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              const Text(
                "07:00 AM",
                style: BlipFonts.outline,
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                child: CustomPaint(
                    size: const Size(1, 20),
                    painter: DashedLineVerticalPainter()),
              ),
            ],
          ),
          addVerticalSpace(5.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                BlipIcons.destination,
              ),
              addHorizontalSpace(10.0),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Town Hall', style: BlipFonts.outline),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    decoration: BoxDecoration(
                      color: BlipColors.lightGrey,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      ('You get picked up').toUpperCase(),
                      style: BlipFonts.taglineBold
                          .merge(const TextStyle(color: BlipColors.orange)),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              const Text(
                "07:00 AM",
                style: BlipFonts.outline,
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                child: CustomPaint(
                    size: const Size(1, 20),
                    painter: DashedLineVerticalPainter()),
              ),
            ],
          ),
          addVerticalSpace(5.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                BlipIcons.destination,
              ),
              addHorizontalSpace(10.0),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Mahabuthgamuwa Bus Stop',
                      style: BlipFonts.outline),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    decoration: BoxDecoration(
                      color: BlipColors.lightGrey,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      ('You get dropped off').toUpperCase(),
                      style: BlipFonts.taglineBold
                          .merge(const TextStyle(color: BlipColors.orange)),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              const Text(
                "07:00 AM",
                style: BlipFonts.outline,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlineButton(
                  text: "View Ride Details",
                  color: BlipColors.black,
                  onPressedAction: () {})
            ],
          ),
        ],
      ),
    );
  }
}
