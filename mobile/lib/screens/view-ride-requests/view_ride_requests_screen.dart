import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';

import 'package:mobile/colors.dart';
import 'package:mobile/fonts.dart';
import 'package:mobile/screens/ride-details/ride_details_screen.dart';
import 'package:mobile/screens/view-ride-requests/confirmed_requests_list.dart';
import 'package:mobile/screens/view-ride-requests/countdown_label.dart';

import 'package:mobile/screens/view-ride-requests/ride_requests_list.dart';
import 'package:mobile/utils/widget_functions.dart';

import '../../cubits/active_ride_cubit.dart';
import '../../custom/backward_button.dart';
import '../../custom/indicator.dart';
import '../../custom/outline_button.dart';
import '../../services/ride_offer_service.dart';

class ViewRideRequestsScreen extends StatefulWidget {
  const ViewRideRequestsScreen({super.key});

  @override
  ViewRideRequestsScreenState createState() {
    return ViewRideRequestsScreenState();
  }
}

class ViewRideRequestsScreenState extends State<ViewRideRequestsScreen> {
  late ActiveRideCubit offerCubit;
  late CountdownTimerController controller;
  var isVisible = false;
  List<dynamic>? pendingRequests;
  List<dynamic>? confirmedRequests;

  @override
  void initState() {
    super.initState();
    offerCubit = BlocProvider.of<ActiveRideCubit>(context);
    controller = CountdownTimerController(
        endTime: offerCubit.getDepartureTime().millisecondsSinceEpoch,
        onEnd: () => {});
    getData();
  }

  getData() async {
    final requestData = await getOfferRequests(offerCubit.getId());
    pendingRequests = requestData.data['requests'];
    final partyData = await getConfirmedRequests(offerCubit.getId());
    confirmedRequests = partyData.data['requests'];
    if (confirmedRequests != null) {
      if ((confirmedRequests?.length)! > 0) {
        var price = 0;
        for (var request in confirmedRequests!) {
          int requestPrice = int.parse(request['price']);
          price = price + requestPrice;
        }
        offerCubit.setPrice(price);
      }
    }

    setState(() {
      isVisible = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
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
          body: Visibility(
            visible: isVisible,
            replacement: const Center(child: CircularProgressIndicator()),
            child: SizedBox(
              width: size.width,
              height: size.height,
              child: Padding(
                padding: sidePadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            'Your ride \nis trending!',
                            style: BlipFonts.displayBlack,
                            textAlign: TextAlign.left,
                          ),
                          Indicator(
                              icon: FluentIcons.eye_12_regular,
                              text: "500",
                              color: BlipColors.green)
                        ],
                      ),
                    ),
                    addVerticalSpace(48),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(('You Earn').toUpperCase(),
                                style: Theme.of(context).textTheme.titleLarge),
                            Row(
                              children: [
                                Text('Rs. ${state.price}',
                                    style: BlipFonts.title),
                                addHorizontalSpace(8),
                              ],
                            ),
                          ],
                        ),
                        OutlineButton(
                            onPressedAction: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const RideDetailsScreen(),
                                ),
                              );
                            },
                            text: "View Ride Details",
                            color: BlipColors.black)
                      ],
                    ),
                    addVerticalSpace(24),
                    const Align(
                      alignment: Alignment.center,
                      child: CountDownLabel(),
                    ),
                    addVerticalSpace(40),
                    const Text(
                      'Ride Requests',
                      style: BlipFonts.heading,
                      textAlign: TextAlign.left,
                    ),
                    addVerticalSpace(16),
                    if (pendingRequests?.length != null)
                      SizedBox(
                        height: 130,
                        child:
                            RideRequestsList(pendingRequests: pendingRequests!),
                      ),
                    addVerticalSpace(24),
                    const Text(
                      'Joining you',
                      style: BlipFonts.heading,
                      textAlign: TextAlign.left,
                    ),
                    if (confirmedRequests != null)
                      ConfirmedRequestsList(
                          confirmedRequests: confirmedRequests!)
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
