import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';
import 'package:mobile/colors.dart';
import 'package:mobile/cubits/matching_rides_cubit.dart';
import 'package:mobile/cubits/ride_request_cubit.dart';
import 'package:mobile/screens/request-ride/request_confirmation.dart';
import 'package:mobile/services/ride_request_service.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import 'package:mobile/custom/wide_button.dart';
import 'package:mobile/utils/widget_functions.dart';

import 'package:mobile/fonts.dart';

class RequestDetailsCard extends StatefulWidget {
  const RequestDetailsCard({Key? key}) : super(key: key);

  @override
  State<RequestDetailsCard> createState() => _RequestDetailsCardState();
}

class _RequestDetailsCardState extends State<RequestDetailsCard> {
  bool isChecked = false;
  bool isLoading = false;

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return BlipColors.black;
    }
    return BlipColors.black;
  }

  double _ridePrice = 250.0;

  @override
  Widget build(BuildContext context) {
    final RideRequestCubit reqCubit =
        BlocProvider.of<RideRequestCubit>(context);
    final MatchingOffersCubit matchingOffersCubit =
        BlocProvider.of<MatchingOffersCubit>(context);

    reqCubit.setPrice(_ridePrice);

    Future<Response> handlePostRideRequest() async {
      setState(() {
        isLoading = true;
      });

      Response postResponse = await postRequest(reqCubit.state);

      return postResponse;
    }

    return SingleChildScrollView(
      child: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: BlipColors.orange,
              ),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Confirm your Ride Requests",
                    style: BlipFonts.heading,
                  ),
                  addVerticalSpace(20.0),
                  Text(
                    "${Jiffy(reqCubit.state.startTime).MMMMEEEEd} ",
                    style: BlipFonts.labelBold,
                  ),
                  addVerticalSpace(5.0),
                  Text(
                    "${Jiffy(reqCubit.state.startTime).format("h:mm a")} +- 30 mins",
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
                            itemCount: reqCubit.state.offerIDs.length > 4
                                ? 4
                                : reqCubit.state.offerIDs.length,
                            itemBuilder: (context, index) {
                              return Align(
                                widthFactor: 0.6,
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundColor: BlipColors.lightGrey,
                                  foregroundImage: NetworkImage(
                                      matchingOffersCubit.state.offers[index]
                                          .driver.profilePicURL),
                                ),
                              );
                            },
                          ),
                        ),
                        const Spacer(),
                        reqCubit.state.offerIDs.length > 4
                            ? Text(
                                "+${reqCubit.state.offerIDs.length - 4} requests",
                                style: BlipFonts.labelBold,
                              )
                            : Container()
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
                          checkColor: BlipColors.black,
                          fillColor:
                              MaterialStateProperty.resolveWith(getColor),
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
                    min: 100.0,
                    max: 1000.0,
                    value: _ridePrice,
                    interval: 10,
                    enableTooltip: true,
                    shouldAlwaysShowTooltip: true,
                    activeColor: BlipColors.black,
                    inactiveColor: BlipColors.grey,
                    onChanged: isChecked
                        ? (dynamic value) {
                            setState(() {
                              _ridePrice = value;
                              reqCubit.setPrice(_ridePrice);
                            });
                          }
                        : null,
                  ),
                  addVerticalSpace(20.0),
                  WideButton(
                    text:
                        "I'll depart at ${Jiffy(reqCubit.state.startTime).format("h:mm a").split(" ").join('')} ${Jiffy(reqCubit.state.startTime).startOf(Units.HOUR).fromNow()}",
                    onPressedAction: () async {
                      Response response = await handlePostRideRequest();
                      if (response.statusCode == 200) {
                        setState(() {
                          isLoading = false;
                        });
                        // ignore: use_build_context_synchronously
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RequestConfirmation(),
                          ),
                        );
                      } else {
                        print(response.data);
                      }
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
