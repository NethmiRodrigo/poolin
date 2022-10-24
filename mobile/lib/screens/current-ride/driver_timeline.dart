import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';

import 'package:poolin/colors.dart';

class DriverTimeline extends StatelessWidget {
  const DriverTimeline({Key? key}) : super(key: key);

  takeImage(context) {
    return showDialog(
        context: context,
        builder: (con) {
          return SimpleDialog(
            title: const Text(
              "Receipt image",
            ),
            children: [
              SimpleDialogOption(
                child: const Text(
                  "Capture image with camera",
                ),
                onPressed: () {},
              ),
              SimpleDialogOption(
                child: const Text(
                  "Select image from gallery",
                ),
                onPressed: () {},
              ),
              SimpleDialogOption(
                child: const Text(
                  "Cancel",
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: FixedTimeline.tileBuilder(
        direction: Axis.horizontal,
        builder: TimelineTileBuilder.connectedFromStyle(
          contentsAlign: ContentsAlign.basic,
          contentsBuilder: (context, index) => TextButton(
            child: const Text('Event'),
            onPressed: () => takeImage(context),
          ),
          connectorStyleBuilder: (context, index) => ConnectorStyle.solidLine,
          indicatorStyleBuilder: (context, index) => IndicatorStyle.dot,
          itemExtent: 80.0,
          itemCount: 5,
        ),
      ),
    );
  }
}
