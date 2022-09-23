import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:mobile/colors.dart';
import 'package:mobile/fonts.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../custom/outline_button.dart';
import '../../utils/widget_functions.dart';

class DriverRideVisibilityScreen extends StatefulWidget {
  const DriverRideVisibilityScreen({Key? key}) : super(key: key);

  @override
  State<DriverRideVisibilityScreen> createState() =>
      _DriverRideVisibilityScreenState();
}

class _DriverRideVisibilityScreenState
    extends State<DriverRideVisibilityScreen> {
  List<bool> isSelected = [true, false];

  SfRangeValues _values = const SfRangeValues(40.0, 80.0);

  List<String> tags = [];
  List<String> options = [
    'FMF',
    'UCSC',
    'FOA',
    'FOL',
    'FOM',
    'UVPA',
  ];
  double _value = 4;

  @override
  Widget build(BuildContext context) {
    const double padding = 16;
    const sidePadding = EdgeInsets.symmetric(horizontal: padding);
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: sidePadding,
          child: Column(
            children: [
              addVerticalSpace(44),
              const Align(
                  alignment: Alignment.topLeft,
                  child: Icon(
                    EvaIcons.arrowBackOutline,
                    color: Colors.black,
                  )),
              addVerticalSpace(16),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const Text('Ride Visibility', style: BlipFonts.title),
                OutlineButton(
                  onPressedAction: () {},
                  color: BlipColors.black,
                  text: "Clear All",
                )
              ]),
              addVerticalSpace(48),
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Contact level",
                  style: BlipFonts.heading,
                ),
              ),

              SfSlider(
                min: 1,
                max: 4,
                value: _value,
                activeColor: BlipColors.orange,
                inactiveColor: BlipColors.black,
                interval: 1,
                showLabels: true,
                enableTooltip: true,
                shouldAlwaysShowTooltip: true,
                minorTicksPerInterval: 0,
                onChanged: (dynamic value) {
                  setState(() {
                    _value = value;
                  });
                },
              ),
              addVerticalSpace(32),
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Price Range",
                  style: BlipFonts.heading,
                ),
              ),
              SfRangeSlider(
                min: 0.0,
                max: 100.0,
                values: _values,
                interval: 20,
                activeColor: BlipColors.orange,
                inactiveColor: BlipColors.black,
                shouldAlwaysShowTooltip: true,
                showLabels: true,
                enableTooltip: true,
                minorTicksPerInterval: 0,
                onChanged: (SfRangeValues values) {
                  setState(() {
                    _values = values;
                  });
                },
              ),

              addVerticalSpace(32),
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Gender",
                  style: BlipFonts.heading,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: ToggleButtons(
                  selectedColor: BlipColors.white,
                  fillColor: Colors.black,
                  borderRadius: BorderRadius.circular(40),
                  onPressed: (int index) {
                    setState(() {
                      isSelected[index] = !isSelected[index];
                    });
                  },
                  isSelected: isSelected,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        children: [
                          const Icon(Icons.male_outlined),
                          addHorizontalSpace(8),
                          const Text("Male")
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        children: [
                          const Icon(Icons.female_outlined),
                          addHorizontalSpace(8),
                          const Text("Female")
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              addVerticalSpace(32),
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Faculty",
                  style: BlipFonts.heading,
                ),
              ),
              addVerticalSpace(16),
              ChipsChoice<String>.multiple(
                value: tags,
                onChanged: (val) => setState(() => tags = val),
                choiceItems: C2Choice.listFrom<String, String>(
                  source: options,
                  value: (i, v) => v,
                  label: (i, v) => v,
                ),
                choiceStyle: C2ChoiceStyle(
                  backgroundColor: BlipColors.white,
                  borderRadius: BorderRadius.circular(40),
                  borderColor: BlipColors.black,
                  borderWidth: 1,
                  color: BlipColors.black,
                ),
              ),
              // MultiSelectDialogField(
              //   items:
              //       _Faculties.map((e) => MultiSelectItem(e, e.name)).toList(),
              //   listType: MultiSelectListType.CHIP,
              //   onConfirm: (List<Faculty> values) {
              //     _selectedFaculties = values;
              //   },
              // ),
              addVerticalSpace(32),
            ],
          ),
        ),
      ),
    );
  }
}
