import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:poolin/colors.dart';
import 'package:poolin/fonts.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../../custom/outline_button.dart';
import '../../utils/widget_functions.dart';

class Faculty {
  final int id;
  final String name;

  Faculty({
    required this.id,
    required this.name,
  });
}

class Vehicle {
  final int id;
  final String name;

  Vehicle({
    required this.id,
    required this.name,
  });
}

class RiderRideVisibilityScreen extends StatefulWidget {
  const RiderRideVisibilityScreen({Key? key}) : super(key: key);

  @override
  State<RiderRideVisibilityScreen> createState() =>
      _RiderRideVisibilityScreenState();
}

class _RiderRideVisibilityScreenState extends State<RiderRideVisibilityScreen> {
  List<bool> isSelected = [true, false];
  static final List<Faculty> _faculties = [
    Faculty(id: 1, name: "UCSC"),
    Faculty(id: 2, name: "FMF"),
    Faculty(id: 3, name: "FOL"),
    Faculty(id: 4, name: "FOM"),
    Faculty(id: 5, name: "FOA"),
  ];
  List<Faculty> _selectedFaculties = [];

  static final List<Vehicle> _vehicles = [
    Vehicle(id: 1, name: "Car"),
    Vehicle(id: 2, name: "Van"),
    Vehicle(id: 3, name: "Bike"),
  ];
  List<Vehicle> _selectedVehicles = [];
  double _currentSliderValue = 1;

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
              Slider(
                activeColor: BlipColors.orange,
                inactiveColor: BlipColors.black,
                value: _currentSliderValue,
                min: 1,
                max: 4,
                divisions: 3,
                label: _currentSliderValue.round().toString(),
                onChanged: (double value) {
                  setState(() {
                    _currentSliderValue = value;
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
              MultiSelectDialogField(
                items:
                    _faculties.map((e) => MultiSelectItem(e, e.name)).toList(),
                listType: MultiSelectListType.CHIP,
                onConfirm: (List<Faculty> values) {
                  _selectedFaculties = values;
                },
              ),
              addVerticalSpace(32),
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Vehicle type",
                  style: BlipFonts.heading,
                ),
              ),
              MultiSelectDialogField(
                title: const Text(""),
                items:
                    _vehicles.map((e) => MultiSelectItem(e, e.name)).toList(),
                listType: MultiSelectListType.CHIP,
                onConfirm: (List<Vehicle> values) {
                  _selectedVehicles = values;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
