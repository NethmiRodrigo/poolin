import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:poolin/colors.dart';
import 'package:poolin/fonts.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

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

class RideVisibilityScreen extends StatefulWidget {
  const RideVisibilityScreen({Key? key}) : super(key: key);

  @override
  State<RideVisibilityScreen> createState() => _RideVisibilityScreenState();
}

class _RideVisibilityScreenState extends State<RideVisibilityScreen> {
  RangeValues _currentRangeValues = const RangeValues(40, 80);
  List<bool> isSelected = [true, false];
  static List<Faculty> _Faculties = [
    Faculty(id: 1, name: "UCSC"),
    Faculty(id: 2, name: "FMF"),
    Faculty(id: 3, name: "FOL"),
    Faculty(id: 4, name: "FOM"),
    Faculty(id: 5, name: "FOA"),
  ];
  List<Faculty> _selectedFaculties = [];

  static List<Vehicle> _Vehicles = [
    Vehicle(id: 1, name: "Car"),
    Vehicle(id: 2, name: "Van"),
    Vehicle(id: 3, name: "Bike"),
  ];
  List<Vehicle> _selectedVehicles = [];
  double _currentSliderValue = 1;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    const double padding = 16;
    const sidePadding = EdgeInsets.symmetric(horizontal: padding);
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: sidePadding,
          child: Column(
            children: [
              addVerticalSpace(44),
              Align(
                  alignment: Alignment.topLeft,
                  child: Icon(
                    EvaIcons.arrowBackOutline,
                    color: Colors.black,
                  )),
              addVerticalSpace(16),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text('Ride Visibility', style: BlipFonts.title),
              ]),
              addVerticalSpace(8),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text('Filters', style: BlipFonts.heading),
                
                TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      primary: Color.fromARGB(255, 0, 0, 0), // Text Color
                    ),
                    child: Text('Clear All'))
              ]),
              addVerticalSpace(8),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text('Visibility', style: BlipFonts.labelBold),
                
              ]),
              addVerticalSpace(8),
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                OutlineButton(
                  onPressedAction: () {},
                  color: BlipColors.black,
                  text: "All",
                ),
                OutlineButton(
                  onPressedAction: () {},
                  color: BlipColors.black,
                  text: "Close friend",
                ),
                
                // IconButton(
                //           icon: const Icon(
                //             Icons.close,
                //             color: Colors.black,
                //           ),
                //           onPressed: () {
                //             Navigator.pop(context);
                //           },
                //         ),
              ]),
              addVerticalSpace(32),
            ],
          ),
        ),
      ),
    );
  }
}
