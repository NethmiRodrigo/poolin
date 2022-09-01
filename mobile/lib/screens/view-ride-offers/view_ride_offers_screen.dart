import 'package:dio/dio.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:jiffy/jiffy.dart';

import 'package:mobile/colors.dart';
import 'package:mobile/cubits/ride_request_cubit.dart';
import 'package:mobile/fonts.dart';

import 'package:mobile/custom/wide_button.dart';
import 'package:mobile/models/ride_offer_search_result.dart';
import 'package:mobile/screens/request-ride/ride_request_details_screen.dart';
import 'package:mobile/services/ride_request_service.dart';
import 'package:mobile/utils/widget_functions.dart';
import 'package:mobile/custom/lists/ride_offer_result_list.dart';
import 'package:mobile/constants/search_offer_results.dart';

class ViewRideOffersScreen extends StatefulWidget {
  const ViewRideOffersScreen({Key? key}) : super(key: key);

  @override
  State<ViewRideOffersScreen> createState() => _ViewRideOffersScreenState();
}

class _ViewRideOffersScreenState extends State<ViewRideOffersScreen> {
  DateTime startTime = DateTime.now().add(const Duration(days: 1));
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    const double padding = 16;
    const sidePadding = EdgeInsets.symmetric(horizontal: padding);
    final RideRequestCubit reqCubit =
        BlocProvider.of<RideRequestCubit>(context);
    // late List<RideOfferSearchResult> rideOffers;
    final List<RideOfferSearchResult> rideOffers = results;

    // void fetchRideOffers() async {
    //   setState(() {
    //     isLoading = true;
    //   });

    //   Response response = await getAvailableOffers(reqCubit.state);

    //   if (response.statusCode == 200) {
    //     response.data.forEach((offer) {
    //       rideOffers.add(RideOfferSearchResult(
    //         id: offer.id,
    //         startTime: offer.startTime,
    //         source: offer.source,
    //         destination: offer.destination,
    //         driver: offer.driver,
    //       ));
    //     });
    //   } else {
    //     // rideOffers = [];
    //   }

    //   setState(() {
    //     isLoading = false;
    //   });
    // }

    // fetchRideOffers();

    Future<DateTime?> showDatePicker() {
      return DatePicker.showDateTimePicker(
        context,
        showTitleActions: true,
        minTime: DateTime.now().add(const Duration(days: 1)),
        maxTime: DateTime.now().add(const Duration(days: 7)),
        onChanged: (date) {},
        onConfirm: (date) {
          setState(
            () {
              startTime = date;
              reqCubit.setStartTime(startTime);
            },
          );
        },
        currentTime: startTime,
        locale: LocaleType.en,
      );
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: BlipColors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.filter_list),
            color: BlipColors.black,
          )
        ],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                value: null,
                semanticsLabel: 'Please wait',
                color: BlipColors.grey,
              ),
            )
          : Padding(
              padding: sidePadding,
              child: Expanded(
                child: Column(
                  children: [
                    TextButton(
                      onPressed: () {
                        showDatePicker();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${Jiffy(startTime).yMMMd} ${Jiffy(startTime).format("h:mm a")} ',
                            style: BlipFonts.labelBold.merge(
                                const TextStyle(color: BlipColors.black)),
                            textAlign: TextAlign.start,
                          ),
                          const Icon(
                            FluentIcons.edit_16_regular,
                            color: BlipColors.orange,
                            size: 14,
                          )
                        ],
                      ),
                    ),
                    addVerticalSpace(10.0),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "From",
                          style: BlipFonts.outline,
                        ),
                        const Spacer(
                          flex: 1,
                        ),
                        Expanded(
                          child: Text(
                            reqCubit.state.source.name,
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
                        addHorizontalSpace(8.0),
                        const Spacer(
                          flex: 1,
                        ),
                        Expanded(
                          child: Text(
                            reqCubit.state.destination.name,
                            style: BlipFonts.label,
                            textAlign: TextAlign.end,
                            overflow: TextOverflow.clip,
                          ),
                        ),
                      ],
                    ),
                    addVerticalSpace(36),
                    Row(
                      children: const [
                        Text(
                          "Browse through available rides",
                          style: BlipFonts.heading,
                        )
                      ],
                    ),
                    addVerticalSpace(20.0),
                    Expanded(
                      child: rideOffers.isNotEmpty
                          ? RideOfferResultList(rideOffers, "view")
                          : Container(
                              width: size.width,
                              color: BlipColors.lightGrey,
                              child: Align(
                                alignment: Alignment.center,
                                child: Column(
                                  children: [
                                    addVerticalSpace(20.0),
                                    Image.asset(
                                      'assets/images/waiting-at-stop.png',
                                      height: size.height * 0.22,
                                    ),
                                    addVerticalSpace(20.0),
                                    const Text(
                                      "No rides available currently",
                                      style: BlipFonts.label,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                    ),
                    addVerticalSpace(16),
                    WideButton(
                      isDisabled:
                          reqCubit.state.offerIDs.isEmpty ? true : false,
                      onPressedAction: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: ((context) =>
                                const RideRequestDetailsScreen()),
                          ),
                        );
                      },
                      text: "Proceed",
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
