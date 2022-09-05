import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:jiffy/jiffy.dart';
import 'package:mobile/colors.dart';
import 'package:mobile/cubits/ride_request_cubit.dart';
import 'package:mobile/custom/wide_button.dart';
import 'package:mobile/fonts.dart';
import 'package:mobile/screens/view-ride-offers/view_ride_offers_screen.dart';
import 'package:mobile/utils/widget_functions.dart';

class EnterTripDetailsScreen extends StatefulWidget {
  const EnterTripDetailsScreen({Key? key}) : super(key: key);

  @override
  State<EnterTripDetailsScreen> createState() => _EnterTripDetailsScreenState();
}

class _EnterTripDetailsScreenState extends State<EnterTripDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    const double padding = 16;
    const sidePadding = EdgeInsets.symmetric(horizontal: padding);
    final RideRequestCubit reqCubit =
        BlocProvider.of<RideRequestCubit>(context);

    Future<DateTime?> showDatePicker() {
      return DatePicker.showDateTimePicker(
        context,
        showTitleActions: true,
        minTime: DateTime.now().add(const Duration(days: 1)),
        maxTime: DateTime.now().add(const Duration(days: 7)),
        onChanged: (date) {},
        onConfirm: (date) {
          reqCubit.setStartTime(date);
          setState(() {});
        },
        currentTime: DateTime.now(),
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
      body: Padding(
        padding: sidePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Enter trip details",
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
              onPressedAction: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ViewRideOffersScreen()),
                );
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
