import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:jiffy/jiffy.dart';
import 'package:poolin/colors.dart';
import 'package:poolin/cubits/matching_rides_cubit.dart';
import 'package:poolin/cubits/ride_request_cubit.dart';
import 'package:poolin/custom/wide_button.dart';
import 'package:poolin/fonts.dart';
import 'package:poolin/screens/view-ride-offers/view_ride_offers_screen.dart';
import 'package:poolin/services/ride_request_service.dart';
import 'package:poolin/utils/widget_functions.dart';

class ConfirmTripDetailsScreen extends StatefulWidget {
  const ConfirmTripDetailsScreen({Key? key}) : super(key: key);

  @override
  State<ConfirmTripDetailsScreen> createState() =>
      _ConfirmTripDetailsScreenState();
}

class _ConfirmTripDetailsScreenState extends State<ConfirmTripDetailsScreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    const double padding = 16;
    const sidePadding = EdgeInsets.symmetric(horizontal: padding);
    final RideRequestCubit reqCubit =
        BlocProvider.of<RideRequestCubit>(context);
    final MatchingOffersCubit matchingOffers =
        BlocProvider.of<MatchingOffersCubit>(context);

    Future<DateTime?> showDatePicker() {
      return DatePicker.showDateTimePicker(
        context,
        showTitleActions: true,
        minTime: DateTime.now().add(const Duration(days: 1)),
        onChanged: (date) {},
        onConfirm: (date) {
          reqCubit.setStartTime(date);
          setState(() {});
        },
        currentTime: DateTime.now(),
        locale: LocaleType.en,
      );
    }

    Future<bool> fetchRideOffers() async {
      setState(() {
        isLoading = true;
      });

      List<MatchedOffer> fetchedOffers =
          await getAvailableOffers(reqCubit.state);

      for (var offer in fetchedOffers) {
        matchingOffers.addOffer(offer);
      }

      setState(() {
        isLoading = false;
      });

      return true;
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Confirm trip details",
                    style: BlipFonts.heading,
                  ),
                  addVerticalSpace(16),
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
                      const Spacer(),
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
                  addVerticalSpace(10.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "On",
                        style: BlipFonts.outline,
                      ),
                      const Spacer(),
                      TextButton(
                        child: Text(
                          reqCubit.state.startTime == null
                              ? 'Specify date'
                              : '${Jiffy(reqCubit.state.startTime).yMMMd} ${Jiffy(reqCubit.state.startTime).format("h:mm a")} ',
                          style: BlipFonts.label
                              .merge(const TextStyle(color: BlipColors.orange)),
                          textAlign: TextAlign.end,
                        ),
                        onPressed: () {
                          showDatePicker();
                        },
                      ),
                    ],
                  ),
                  const Spacer(),
                  WideButton(
                    onPressedAction: () async {
                      bool result = await fetchRideOffers();
                      if (result) {
                        // ignore: use_build_context_synchronously
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const ViewRideOffersScreen()),
                        );
                      }
                    },
                    text: "Confirm",
                    isDisabled: reqCubit.state.startTime == null,
                  ),
                  addVerticalSpace(16.0),
                ],
              ),
            ),
    );
  }
}
