import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:mobile/custom/wide_button.dart';
import 'package:mobile/fonts.dart';
import 'package:mobile/utils/widget_functions.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class RequestDetailsCard extends StatefulWidget {
  const RequestDetailsCard({Key? key}) : super(key: key);

  @override
  State<RequestDetailsCard> createState() => _RequestDetailsCardState();
}

class _RequestDetailsCardState extends State<RequestDetailsCard> {
  double _value = 40.0;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    const double padding = 16;
    const sidePadding = EdgeInsets.symmetric(horizontal: padding);
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
              'Confirm your Request',
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
                                  const Icon(FluentIcons.edit_16_regular)
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
                                            DatePicker.showDatePicker(context,
                                                showTitleActions: true,
                                                minTime: DateTime(2018, 3, 5),
                                                maxTime: DateTime(2019, 6, 7),
                                                onChanged: (date) {},
                                                onConfirm: (date) {},
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
                          // Column(),
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
                              Text(("expires in".toUpperCase()),
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall),
                              addVerticalSpace(16),
                              SizedBox(
                                width: 140,
                                child: SfSlider(
                                  min: 8.0,
                                  max: 100.0,
                                  value: _value,
                                  interval: 20,
                                  showTicks: false,
                                  showLabels: false,
                                  enableTooltip: true,
                                  minorTicksPerInterval: 1,
                                  onChanged: (dynamic value) {
                                    setState(() {
                                      _value = value;
                                    });
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
            addVerticalSpace(20),
            WideButton(
                text: "I'll arrive at 4.30PM in 2 days", onPressedAction: () {})
          ],
        ),
      ),
    );
  }
}
