import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:poolin/colors.dart';
import 'package:poolin/cubits/active_ride_cubit.dart';
import 'package:poolin/fonts.dart';
import 'package:poolin/models/user_location.dart';
import 'package:poolin/screens/rate_users/rate_passengers_screen.dart';
import 'package:poolin/utils/widget_functions.dart';
import 'package:timelines/timelines.dart';

class DriverTimeline extends StatefulWidget {
  const DriverTimeline({Key? key}) : super(key: key);

  @override
  State<DriverTimeline> createState() => _DriverTimelineState();
}

class _DriverTimelineState extends State<DriverTimeline> {
  late ActiveRideCubit activeRideCubit;
  late List<RideParticipant> party;
  List<UserLocation> checkpoints = [];
  late LatLng driverStart;
  String? apiKey;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    activeRideCubit = BlocProvider.of<ActiveRideCubit>(context);
    apiKey = dotenv.env['MAPS_API_KEY'];
    party = activeRideCubit.state.partyData;
    driverStart = LatLng(
      activeRideCubit.state.source.lat,
      activeRideCubit.state.source.lang,
    );
    evaluateCheckpoints();
  }

  void evaluateCheckpoints() {
    setState(() {
      isLoading = true;
    });

    for (var pass in party) {
      checkpoints.add(UserLocation(
        lat: pass.pickupLocation.lat,
        long: pass.pickupLocation.lang,
        username: pass.firstname,
        type: LocType.pickup,
      ));
      checkpoints.add(UserLocation(
        lat: pass.dropoffLocation.lat,
        long: pass.dropoffLocation.lang,
        username: pass.firstname,
        type: LocType.dropoff,
      ));
    }
    organizeCheckpoints();
  }

  void organizeCheckpoints() async {
    Dio dio = Dio();
    String? apiURL = dotenv.env['DISTANCE_MATRIX_API_URL'];

    String url = '';

    for (var point in checkpoints) {
      url = '$url${point.lat}%2C${point.long}%7C';
    }

    try {
      Response response = await dio.get(
          "$apiURL?origins=${driverStart.latitude}%2C${driverStart.longitude}&destinations=$url&key=$apiKey&mode=driving");

      var elements = response.data["rows"][0]["elements"];

      for (int i = 0; i < elements.length; i++) {
        if (elements[i]["status"] == "OK") {
          checkpoints[i].distance = elements[i]["distance"]["value"];
        }
      }
    } catch (e) {
      print(e.toString());
    }

    // sort array of checkpoints from closest to farthest
    checkpoints.sort((a, b) => a.distance.compareTo(b.distance));

    // add driver start and end to the checkpoints
    checkpoints.insert(
        0,
        UserLocation(
          lat: driverStart.latitude,
          long: driverStart.longitude,
          username: 'You',
          type: LocType.start,
          isReached: true,
        ));
    checkpoints.add(UserLocation(
      lat: activeRideCubit.state.destination.lat,
      long: activeRideCubit.state.destination.lang,
      username: 'You',
      type: LocType.end,
    ));
    setState(() {
      isLoading = false;
    });
  }

  confirmArrival(context, int index) {
    return showDialog(
        context: context,
        builder: (con) {
          return SimpleDialog(
            title: Text(
              "Have you ${checkpoints[index].type == LocType.pickup ? 'picked up' : 'droped off'} ${checkpoints[index].username}?",
              style: BlipFonts.labelBold,
            ),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SimpleDialogOption(
                    child: const Text(
                      "Not yet",
                      style: BlipFonts.label,
                    ),
                    onPressed: () {},
                  ),
                  SimpleDialogOption(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 4.0,
                        horizontal: 12.0,
                      ),
                      decoration: BoxDecoration(
                        color: BlipColors.orange,
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Text(
                        "Yes",
                        style: BlipFonts.label
                            .merge(const TextStyle(color: BlipColors.white)),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        checkpoints[index].isReached = true;
                      });
                    },
                  ),
                ],
              )
            ],
          );
        });
  }

  handleRideEnd(context) {
    return showDialog(
        context: context,
        builder: (con) {
          return SimpleDialog(
            title: Text(
              "Congratulations! \nyou've earned Rs.${activeRideCubit.state.price} \nfrom this ride",
              style: BlipFonts.labelBold,
              textAlign: TextAlign.center,
            ),
            children: [
              addVerticalSpace(24),
              SimpleDialogOption(
                child: Text(
                  "Rate passengers",
                  style: BlipFonts.label
                      .merge(const TextStyle(color: BlipColors.orange)),
                  textAlign: TextAlign.center,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RatePassengersScreen()),
                  );
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return !isLoading
        ? SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: FixedTimeline.tileBuilder(
              theme: TimelineThemeData(
                direction: Axis.horizontal,
                indicatorTheme: const IndicatorThemeData(
                  size: 20.0,
                  color: BlipColors.orange,
                ),
                connectorTheme: const ConnectorThemeData(
                  thickness: 2.0,
                  space: 16.0,
                  color: BlipColors.orange,
                ),
              ),
              builder: TimelineTileBuilder.connectedFromStyle(
                contentsAlign: ContentsAlign.basic,
                contentsBuilder: (context, index) => checkpoints[index].type ==
                        LocType.start
                    ? const Text(
                        'Ride \nstart',
                        style: BlipFonts.outline,
                      )
                    : TextButton(
                        child: checkpoints[index].type == LocType.end
                            ? Text('Ride \nend',
                                style: BlipFonts.outline.merge(
                                    const TextStyle(color: BlipColors.black)))
                            : checkpoints[index].type == LocType.pickup
                                ? Text(
                                    'Pickup ${checkpoints[index].username}',
                                    style: BlipFonts.outline.merge(
                                        const TextStyle(
                                            color: BlipColors.black)),
                                  )
                                : Text(
                                    'Dropoff ${checkpoints[index].username}',
                                    style: BlipFonts.outline.merge(
                                        const TextStyle(
                                            color: BlipColors.black)),
                                  ),
                        onPressed: () => checkpoints[index].type != LocType.end
                            ? confirmArrival(context, index)
                            : handleRideEnd(context),
                      ),
                connectorStyleBuilder: (context, index) =>
                    ConnectorStyle.solidLine,
                indicatorStyleBuilder: (context, index) =>
                    checkpoints[index].isReached
                        ? IndicatorStyle.dot
                        : IndicatorStyle.outlined,
                itemExtent: 80.0,
                itemCount: checkpoints.length,
              ),
            ),
          )
        : Container();
  }
}
