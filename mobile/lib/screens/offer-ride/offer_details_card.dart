import 'dart:convert';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:http/http.dart';
import 'package:jiffy/jiffy.dart';
import 'package:mobile/colors.dart';
import 'package:mobile/cubits/ride_offer_cubit.dart';
import 'package:mobile/custom/wide_button.dart';
import 'package:mobile/fonts.dart';
import 'package:mobile/services/distance_duration_service.dart';
import 'package:mobile/services/ride_offer_service.dart';
import 'package:mobile/utils/helper_functions.dart';
import 'package:mobile/utils/widget_functions.dart';

class OfferDetailsCard extends StatefulWidget {
  const OfferDetailsCard({Key? key}) : super(key: key);

  @override
  OfferDetailsCardState createState() => OfferDetailsCardState();
}

class OfferDetailsCardState extends State<OfferDetailsCard> {
  DateTime startTime = DateTime.now().add(Duration(days: 1));
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    const double padding = 16;
    const sidePadding = EdgeInsets.symmetric(horizontal: padding);
    final RideOfferCubit offerCubit = BlocProvider.of<RideOfferCubit>(context);
    print(offerCubit.state.seatCount.toString());
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        padding: sidePadding,
        height: size.height * 0.5,
        width: size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            addVerticalSpace(24),
            const Text(
              'Confirm your Offer',
              style: BlipFonts.title,
            ),
            addVerticalSpace(40),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Column(
                            children: [
                              Text(("fare per rider".toUpperCase()),
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall),
                              addVerticalSpace(20),
                              Row(
                                children: [
                                  Text("Rs. 5000",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge),
                                  const Icon(
                                    FluentIcons.edit_16_regular,
                                    size: 14,
                                    color: BlipColors.orange,
                                  ),
                                ],
                              ),
                              addVerticalSpace(16),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Text(("date and time".toUpperCase()),
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall),
                                      addVerticalSpace(20),
                                      TextButton(
                                          onPressed: () {
                                            DatePicker.showDateTimePicker(
                                                context,
                                                showTitleActions: true,
                                                minTime: DateTime.now()
                                                    .add(Duration(days: 1)),
                                                maxTime: DateTime.now()
                                                    .add(Duration(days: 7)),
                                                onChanged: (date) {
                                              print('change $date');
                                            }, onConfirm: (date) {
                                              setState(() {
                                                startTime = date;
                                              });
                                              print('confirm $date');
                                            },
                                                currentTime: startTime,
                                                locale: LocaleType.en);
                                          },
                                          child: Text(
                                            Jiffy(startTime).yMMMd,
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelLarge,
                                          ))
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Column(
                            children: [
                              Text(("visibility".toUpperCase()),
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall),
                              addVerticalSpace(20),
                              Row(
                                children: [
                                  const Icon(FluentIcons.eye_16_filled,
                                      size: 18),
                                  addHorizontalSpace(8),
                                  Text("Public",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge),
                                ],
                              ),
                            ],
                          ),
                          addVerticalSpace(16),
                          Column(
                            children: [
                              Text(("empty seats".toUpperCase()),
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall),
                              addVerticalSpace(16),
                              Container(
                                width: 140,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  border: Border.all(
                                    color: BlipColors.orange,
                                    width: 1,
                                  ),
                                ),
                                child: SpinBox(
                                  textAlign: TextAlign.center,
                                  iconColor:
                                      MaterialStateProperty.all(Colors.black),
                                  textStyle: BlipFonts.label,
                                  decoration: const InputDecoration(
                                    filled: false,
                                    border: InputBorder.none,
                                    contentPadding:
                                        EdgeInsets.fromLTRB(0, 6, 0, 0),
                                  ),
                                  min: 1,
                                  max: 5,
                                  value: 3,
                                  onChanged: (value) => {
                                    print(value),
                                    offerCubit.setSeatCount(value.toInt())
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            addVerticalSpace(32),
            WideButton(
                text: "I'll arrive at " +
                    Jiffy(startTime).format("h:mm a").split(" ").join('') +
                    " " +
                    Jiffy(startTime).startOf(Units.HOUR).fromNow(),
                onPressedAction: () async {
                  offerCubit.setStartTime(startTime);
                  Response response = await getDistanceAndTime(
                      offerCubit.state.source, offerCubit.state.destination);
                  final res = json.decode(response.body);
                  if (response.statusCode == 200) {
                    print(res["rows"][0]["elements"]);
                  }
                  final distance = double.parse(res["rows"][0]["elements"][0]
                          ["distance"]["text"]
                      .split(' ')[0]);
                  print(distance);
                  final duration = int.parse(res["rows"][0]["elements"][0]
                          ["duration"]["text"]
                      .split(' ')[0]);
                  print(duration);
                  offerCubit.setDistance(distance * 1.60934);
                  print("done");
                  offerCubit.setDuration(duration);

                  Response postResponse = await postOffer(offerCubit.state);
                  if (postResponse.statusCode == 200) {
                    print("Success! " + postResponse.body);

                    // if (!mounted) {
                    //   return;
                    // }

                  } else {
                    print("Error! " + postResponse.body);
                  }
                })
          ],
        ),
      ),
    );
  }
}
