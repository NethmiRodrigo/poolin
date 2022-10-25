import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:jiffy/jiffy.dart';

import 'package:poolin/colors.dart';
import 'package:poolin/cubits/matching_rides_cubit.dart';
import 'package:poolin/cubits/ride_request_cubit.dart';
import 'package:poolin/custom/dashed_line.dart';
import 'package:poolin/custom/outline_button.dart';
import 'package:poolin/fonts.dart';
import 'package:poolin/icons.dart';
import 'package:poolin/models/coordinate_model.dart';
import 'package:poolin/utils/widget_functions.dart';

class RideOfferTimeline extends StatefulWidget {
  final MatchedOffer offer;
  final Coordinate mySource;
  final Coordinate myDestination;
  const RideOfferTimeline(this.offer, this.mySource, this.myDestination,
      {Key? key})
      : super(key: key);

  @override
  State<RideOfferTimeline> createState() => _RideOfferTimelineState();
}

class _RideOfferTimelineState extends State<RideOfferTimeline> {
  String? apiKey = dotenv.env['MAPS_API_KEY'];

  @override
  void initState() {
    super.initState();
    calculatePickupTime();
  }

  Future<void> calculatePickupTime() async {
    Dio dio = Dio();
    String? apiURL = dotenv.env['DISTANCE_MATRIX_API_URL'];

    try {
      Response response = await dio.get(
          "$apiURL?origins=${widget.offer.source.lat}%2C${widget.offer.source.lang}&destinations=${widget.mySource.lat}%2C${widget.mySource.lang}&key=$apiKey&mode=driving");

      if (response.data["rows"][0]["elements"][0]["status"] == "OK") {
        int durationInSeconds =
            response.data["rows"][0]["elements"][0]["duration"]["value"];

        setState(() {
          DateTime driverStarts = widget.offer.startTime;
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> calculateDropOffTime() async {
    Dio dio = Dio();
    String? apiURL = dotenv.env['DISTANCE_MATRIX_API_URL'];

    try {
      Response response = await dio.get(
          "$apiURL?origins=${widget.mySource.lat}%2C${widget.mySource.lang}&destinations=${widget.myDestination.lat}%2C${widget.myDestination.lang}&key=$apiKey&mode=driving");

      if (response.data["rows"][0]["elements"][0]["status"] == "OK") {
        int durationInSeconds =
            response.data["rows"][0]["elements"][0]["duration"]["value"];
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final RideRequestCubit reqCubit =
        BlocProvider.of<RideRequestCubit>(context);

    return SingleChildScrollView(
      child: Padding(
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
                    Text(widget.offer.source.name, style: BlipFonts.outline),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 2),
                      decoration: BoxDecoration(
                        color: BlipColors.lightGrey,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        ('${widget.offer.driver.firstName} begins journey')
                            .toUpperCase(),
                        style: BlipFonts.taglineBold
                            .merge(const TextStyle(color: BlipColors.orange)),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 8.0),
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
                    Text(reqCubit.state.source.name, style: BlipFonts.outline),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 2),
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
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 8.0),
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
                    Text(reqCubit.state.destination.name,
                        style: BlipFonts.outline),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 2),
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
      ),
    );
  }
}
