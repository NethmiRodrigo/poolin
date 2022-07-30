import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:mobile/colors.dart';
import 'package:mobile/cubits/ride_offer_cubit.dart';
import 'package:mobile/custom/wide_button.dart';
import 'package:mobile/fonts.dart';
import 'package:mobile/utils/widget_functions.dart';

class OfferDetailsCard extends StatelessWidget {
  const OfferDetailsCard({Key? key}) : super(key: key);

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
                                      addVerticalSpace(8),
                                      TextButton(
                                          onPressed: () {
                                            DatePicker.showDatePicker(context,
                                                showTitleActions: true,
                                                minTime: DateTime(2018, 3, 5),
                                                maxTime: DateTime(2019, 6, 7),
                                                onChanged: (date) {
                                              print('change $date');
                                            }, onConfirm: (date) {
                                              print('confirm $date');
                                            },
                                                currentTime: DateTime.now(),
                                                locale: LocaleType.en);
                                          },
                                          child: Text(
                                            '26 Oct, 2022',
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
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  border: Border.all(
                                    color: BlipColors.orange,
                                    width: 1,
                                  ),
                                ),
                                child: SpinBox(
                                  iconColor:
                                      MaterialStateProperty.all(Colors.black),
                                  textStyle:
                                      Theme.of(context).textTheme.labelLarge,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding:
                                        EdgeInsets.fromLTRB(0, 0, 0, 12),
                                  ),
                                  min: 1,
                                  max: 100,
                                  value: 50,
                                  onChanged: (value) => print(value),
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
                text: "I'll arrive at 4.30PM in 2 days", onPressedAction: () {})
          ],
        ),
      ),
    );
  }
}
