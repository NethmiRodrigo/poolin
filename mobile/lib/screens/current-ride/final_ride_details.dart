import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_countdown_timer/index.dart';
import 'package:jiffy/jiffy.dart';

import 'package:poolin/colors.dart';
import 'package:poolin/custom/wide_button.dart';
import 'package:poolin/fonts.dart';
import 'package:poolin/screens/chat/group_chat.dart';
import 'package:poolin/screens/current-ride/start_ride.dart';
import 'package:poolin/screens/view-ride-requests/confirmed_requests_list.dart';
import 'package:poolin/services/ride_offer_service.dart';
import 'package:poolin/utils/widget_functions.dart';

import '../../cubits/active_ride_cubit.dart';
import '../../custom/backward_button.dart';

class FinalRideDetailsScreen extends StatefulWidget {
  const FinalRideDetailsScreen({super.key});

  @override
  FinalRideDetailsScreenState createState() {
    return FinalRideDetailsScreenState();
  }
}

class FinalRideDetailsScreenState extends State<FinalRideDetailsScreen> {
  late ActiveRideCubit activeRideCubit;
  late CountdownTimerController controller;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    activeRideCubit = BlocProvider.of<ActiveRideCubit>(context);
    controller = CountdownTimerController(
      endTime: activeRideCubit
          .getDepartureTime()
          .subtract(const Duration(minutes: 5))
          .millisecondsSinceEpoch,
    );
    getRideDetails();
  }

  getRideDetails() async {
    int offerID = activeRideCubit.state.id!;
    final List<RideParticipant> partyData = await getConfirmedRequests(offerID);
    activeRideCubit.setParty(partyData);

    if (activeRideCubit.state.partyData.isNotEmpty) {
      double price = 0;
      for (var req in activeRideCubit.state.partyData) {
        price = price + req.price;
      }
      activeRideCubit.setPrice(price);
    }
  }

  @override
  Widget build(BuildContext context) {
    const double padding = 16;
    const sidePadding = EdgeInsets.symmetric(horizontal: padding);

    return BlocBuilder<ActiveRideCubit, ActiveRide>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: const BackwardButton(),
          ),
          body: isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: BlipColors.orange,
                  ),
                )
              : Padding(
                  padding: sidePadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'It’s almost \ntime for your \nRide!',
                        style: BlipFonts.displayBlack,
                        textAlign: TextAlign.left,
                      ),
                      addVerticalSpace(24),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '${Jiffy(activeRideCubit.state.departureTime).yMMMEd} (Today)',
                            style: BlipFonts.labelBold,
                          ),
                          const Spacer(),
                          Expanded(
                            child: Text(
                              Jiffy(activeRideCubit.state.departureTime)
                                  .format("h:mm a"),
                              style: BlipFonts.labelBold,
                              textAlign: TextAlign.end,
                              overflow: TextOverflow.clip,
                            ),
                          ),
                        ],
                      ),
                      addVerticalSpace(24),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            "From",
                            style: BlipFonts.outline,
                          ),
                          const Spacer(),
                          Expanded(
                            child: Text(
                              activeRideCubit.state.source,
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
                          const Spacer(),
                          Expanded(
                            child: Text(
                              activeRideCubit.state.destination,
                              style: BlipFonts.label,
                              textAlign: TextAlign.end,
                              overflow: TextOverflow.clip,
                            ),
                          ),
                        ],
                      ),
                      addVerticalSpace(24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Joining you',
                            style: BlipFonts.heading,
                            textAlign: TextAlign.left,
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const GroupChat()),
                              );
                            },
                            icon: const Icon(
                              EvaIcons.messageSquareOutline,
                              color: BlipColors.black,
                              size: 24.0,
                            ),
                            padding: EdgeInsets.zero,
                          )
                        ],
                      ),
                      if (activeRideCubit.state.partyData.isNotEmpty)
                        ConfirmedRequestsList(
                          confirmedRequests: activeRideCubit.state.partyData,
                        ),
                      const Spacer(),
                      CountdownTimer(
                        controller: controller,
                        widgetBuilder: (_, CurrentRemainingTime? time) {
                          if (time == null) {
                            return WideButton(
                              text: 'Start ride now',
                              onPressedAction: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const StartRide()),
                                );
                              },
                              isDisabled: false,
                            );
                          }
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "You can start in ${time.min == null ? '00' : time.min.toString().padLeft(2, '0')}:${time.sec.toString().padLeft(2, '0')}",
                                style: BlipFonts.outline.merge(const TextStyle(
                                  color: BlipColors.red,
                                )),
                              ),
                              addVerticalSpace(12),
                              WideButton(
                                text: 'Start ride now',
                                onPressedAction: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const StartRide()),
                                  );
                                },
                                isDisabled: false,
                              )
                            ],
                          );
                        },
                      ),
                      addVerticalSpace(24),
                    ],
                  ),
                ),
        );
      },
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
