import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:jiffy/jiffy.dart';

import 'package:poolin/colors.dart';
import 'package:poolin/cubits/matching_rides_cubit.dart';
import 'package:poolin/cubits/ride_request_cubit.dart';
import 'package:poolin/fonts.dart';

import 'package:poolin/custom/wide_button.dart';
import 'package:poolin/screens/request-ride/ride_request_details_screen.dart';
import 'package:poolin/services/ride_request_service.dart';
import 'package:poolin/utils/widget_functions.dart';
import 'package:poolin/custom/lists/ride_offer_result_list.dart';

class ViewRideOffersScreen extends StatefulWidget {
  const ViewRideOffersScreen({Key? key}) : super(key: key);

  @override
  State<ViewRideOffersScreen> createState() => _ViewRideOffersScreenState();
}

class _ViewRideOffersScreenState extends State<ViewRideOffersScreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    const double padding = 16;
    const sidePadding = EdgeInsets.symmetric(horizontal: padding);
    final RideRequestCubit reqCubit =
        BlocProvider.of<RideRequestCubit>(context);
    final MatchingOffersCubit matchingOffersCubit =
        BlocProvider.of<MatchingOffersCubit>(context);

    void fetchRideOffers() async {
      setState(() {
        isLoading = true;
        matchingOffersCubit.clearOffers();
      });

      List<MatchedOffer> fetchedOffers =
          await getAvailableOffers(reqCubit.state);

      for (var offer in fetchedOffers) {
        matchingOffersCubit.addOffer(offer);
      }

      setState(() {
        isLoading = false;
      });
    }

    Future<DateTime?> showDatePicker() {
      return DatePicker.showDateTimePicker(
        context,
        showTitleActions: true,
        minTime: DateTime.now().add(const Duration(days: 1)),
        maxTime: DateTime.now().add(const Duration(days: 7)),
        onChanged: (date) {},
        onConfirm: (date) {
          reqCubit.setStartTime(date);
          fetchRideOffers();
        },
        currentTime: reqCubit.state.startTime,
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
                children: [
                  TextButton(
                    onPressed: () {
                      showDatePicker();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${Jiffy(reqCubit.state.startTime).yMMMd} ${Jiffy(reqCubit.state.startTime).format("h:mm a")} ',
                          style: BlipFonts.labelBold
                              .merge(const TextStyle(color: BlipColors.black)),
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
                    child: matchingOffersCubit.state.offers.isNotEmpty
                        ? const RideOfferResultList("view")
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
                    isDisabled: reqCubit.state.offerIDs.isEmpty ? true : false,
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
                  addVerticalSpace(16),
                ],
              ),
            ),
    );
  }
}
