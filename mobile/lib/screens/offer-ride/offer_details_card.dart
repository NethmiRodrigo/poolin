import 'package:dio/dio.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:jiffy/jiffy.dart';

import 'package:poolin/colors.dart';
import 'package:poolin/cubits/active_ride_cubit.dart';
import 'package:poolin/cubits/ride_offer_cubit.dart';
import 'package:poolin/custom/wide_button.dart';
import 'package:poolin/fonts.dart';
import 'package:poolin/screens/offer-ride/driver_ride_visibility_screen.dart';
import 'package:poolin/screens/offer-ride/offer_confirmation.dart';
import 'package:poolin/services/distance_duration_service.dart';
import 'package:poolin/services/ride_offer_service.dart';
import 'package:poolin/utils/widget_functions.dart';

class OfferDetailsCard extends StatefulWidget {
  const OfferDetailsCard({Key? key}) : super(key: key);

  @override
  OfferDetailsCardState createState() => OfferDetailsCardState();
}

class OfferDetailsCardState extends State<OfferDetailsCard> {
  DateTime startTime = DateTime.now().add(const Duration(days: 1));
  TextEditingController _email = TextEditingController(text: "500");
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    const double padding = 16;
    const sidePadding = EdgeInsets.symmetric(horizontal: padding);
    final RideOfferCubit offerCubit = BlocProvider.of<RideOfferCubit>(context);
    final ActiveRideCubit activeRideCubit =
        BlocProvider.of<ActiveRideCubit>(context);

    Future<DateTime?> showDatePicker() {
      return DatePicker.showDateTimePicker(context,
          showTitleActions: true,
          minTime: DateTime.now().add(const Duration(days: 1)),
          onChanged: (date) {}, onConfirm: (date) {
        setState(() {
          startTime = date;
        });
      }, currentTime: startTime, locale: LocaleType.en);
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        child: SingleChildScrollView(
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
                addVerticalSpace(30),
                const Text(
                  'Confirm your Offer',
                  style: BlipFonts.title,
                ),
                addVerticalSpace(40),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                              color: BlipColors.orange),
                        )
                      : Column(
                          children: [
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          Column(
                                            children: [
                                              RichText(
                                                text: TextSpan(
                                                    text: "fare per km"
                                                        .toUpperCase(),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headlineSmall),
                                              ),
                                              addVerticalSpace(20),
                                              SizedBox(
                                                width: 120,
                                                child: TextFormField(
                                                  controller: _email,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelLarge,
                                                  decoration: InputDecoration(
                                                    suffixIcon: const Icon(
                                                      FluentIcons
                                                          .edit_16_regular,
                                                      color: BlipColors.orange,
                                                      size: 14,
                                                    ),
                                                    border: OutlineInputBorder(
                                                      gapPadding: 0.0,
                                                      borderSide:
                                                          const BorderSide(
                                                        color:
                                                            BlipColors.orange,
                                                        width: 2.0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25.0),
                                                    ),
                                                    contentPadding:
                                                        const EdgeInsets
                                                                .fromLTRB(
                                                            15.0, 0, 0, 0),
                                                    fillColor: BlipColors.white,
                                                  ),
                                                ),
                                              ),
                                              addVerticalSpace(16),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    children: [
                                                      Text(
                                                          ("date and time"
                                                              .toUpperCase()),
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .headlineSmall),
                                                      addVerticalSpace(20),
                                                      TextButton(
                                                        onPressed: () {
                                                          showDatePicker();
                                                        },
                                                        child: Text(
                                                          Jiffy(startTime)
                                                              .yMMMd,
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .labelLarge,
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
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Column(
                                            children: [
                                              Text(("visibility".toUpperCase()),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headlineSmall),
                                              addVerticalSpace(20),
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const DriverRideVisibilityScreen()),
                                                  );
                                                },
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 12),
                                                  child: Row(
                                                    children: [
                                                      const Icon(
                                                          FluentIcons
                                                              .eye_16_filled,
                                                          size: 18),
                                                      addHorizontalSpace(8),
                                                      Text("Public",
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .labelLarge),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          addVerticalSpace(20),
                                          Column(
                                            children: [
                                              Text(
                                                  ("empty seats".toUpperCase()),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headlineSmall),
                                              addVerticalSpace(20),
                                              Container(
                                                width: 140,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(40),
                                                  border: Border.all(
                                                    color: BlipColors.black,
                                                    width: 1,
                                                  ),
                                                ),
                                                child: SpinBox(
                                                  textAlign: TextAlign.center,
                                                  iconColor:
                                                      MaterialStateProperty.all(
                                                          Colors.black),
                                                  textStyle: BlipFonts.label,
                                                  decoration:
                                                      const InputDecoration(
                                                    filled: false,
                                                    border: InputBorder.none,
                                                    contentPadding:
                                                        EdgeInsets.fromLTRB(
                                                            0, 0, 0, 0),
                                                  ),
                                                  min: 1,
                                                  max: 5,
                                                  value: 3,
                                                  onChanged: (value) => {
                                                    offerCubit.setSeatCount(
                                                        value.toInt())
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
                                text:
                                    "I'll arrive at ${Jiffy(startTime).format("h:mm a").split(" ").join('')} ${Jiffy(startTime).startOf(Units.HOUR).fromNow()}",
                                isDisabled: isLoading,
                                onPressedAction: () async {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  offerCubit.setStartTime(startTime);
                                  Response response = await getDistanceAndTime(
                                      offerCubit.state.source,
                                      offerCubit.state.destination);
                                  // final res = json.decode(response.data);
                                  final res = response.data;
                                  if (response.statusCode == 200) {
                                    print(res["rows"][0]["elements"]);
                                  }
                                  final distance = double.parse(res["rows"][0]
                                          ["elements"][0]["distance"]["text"]
                                      .split(' ')[0]);
                                  final duration = int.parse(res["rows"][0]
                                          ["elements"][0]["duration"]["text"]
                                      .split(' ')[0]);
                                  offerCubit.setDistance((distance * 1.60934));
                                  offerCubit.setDuration(duration);
                                  Response postResponse =
                                      await postOffer(offerCubit.state);
                                  if (postResponse.statusCode == 200) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const OfferConfirmation()),
                                    );
                                  } else {
                                    print("Error! " + postResponse.data);
                                  }
                                })
                          ],
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
