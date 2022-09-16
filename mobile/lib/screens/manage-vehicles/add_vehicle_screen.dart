import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:mobile/custom/wide_button.dart';
import 'package:mobile/fonts.dart';
import 'package:mobile/utils/widget_functions.dart';

import '../../colors.dart';

class AddVehicleScreen extends StatefulWidget {
  const AddVehicleScreen({super.key});

  @override
  AddVehicleScreenState createState() {
    return AddVehicleScreenState();
  }
}

class AddVehicleScreenState extends State<AddVehicleScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _make = TextEditingController();
  final TextEditingController _model = TextEditingController();
  final TextEditingController _year = TextEditingController();
  final TextEditingController _color = TextEditingController();
  final TextEditingController _plateno = TextEditingController();

  @override
  void dispose() {
    _make.dispose();
    _model.dispose();
    _year.dispose();
    _color.dispose();
    _plateno.dispose();
    super.dispose();
  }

  String _dropdownValue = "Car";
  List<String> dropDownOptions = [
    "Car",
    "Van",
    "Bike",
  ];

  void dropdownCallback(String? selectedValue) {
    if (selectedValue is String) {
      setState(() {
        _dropdownValue = selectedValue;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    const double padding = 16;
    const sidePadding = EdgeInsets.symmetric(horizontal: padding);

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
            width: size.width,
            height: size.height,
            child: Padding(
              padding: sidePadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  addVerticalSpace(12),
                  Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        icon: Icon(
                          EvaIcons.arrowBackOutline,
                          color: Colors.black,
                        ),
                        onPressed: () async {},
                      )),
                  addVerticalSpace(12),
                  const Text(
                    'Enter vehicle information',
                    style: BlipFonts.title,
                  ),
                  addVerticalSpace(36),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Vehicle Type",
                                    style: BlipFonts.outline,
                                  ),
                                ),
                                addVerticalSpace(8),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: BlipColors.lightGrey,
                                  ),
                                  width: 250,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                        items: dropDownOptions
                                            .map<DropdownMenuItem<String>>(
                                                (String mascot) {
                                          return DropdownMenuItem<String>(
                                              child: Text(
                                                mascot,
                                              ),
                                              value: mascot);
                                        }).toList(),
                                        value: _dropdownValue,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: BlipColors.grey,
                                          fontFamily: 'Satoshi',
                                        ),
                                        onChanged: dropdownCallback,
                                        elevation: 4,
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: Column(children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Vehicle Model",
                                    style: BlipFonts.outline,
                                  ),
                                ),
                                addVerticalSpace(8),
                                TextFormField(
                                  style: BlipFonts.label,
                                  controller: _model,
                                  textAlignVertical: TextAlignVertical.center,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 16),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: const BorderSide(
                                        width: 0,
                                        style: BorderStyle.none,
                                      ),
                                    ),
                                    hintText: "Ex: Prius",
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Field cannot be empty';
                                    }
                                    return null;
                                  },
                                ),
                              ]),
                            ),
                          ],
                        ),
                        addVerticalSpace(16),
                        Row(
                          children: [
                            Expanded(
                              child: Column(children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Vehicle Make",
                                    style: BlipFonts.outline,
                                  ),
                                ),
                                addVerticalSpace(8),
                                TextFormField(
                                  style: BlipFonts.label,
                                  controller: _make,
                                  textAlignVertical: TextAlignVertical.center,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 16),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: const BorderSide(
                                        width: 0,
                                        style: BorderStyle.none,
                                      ),
                                    ),
                                    hintText: "Ex: Toyota",
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Field cannot be empty';
                                    }
                                    return null;
                                  },
                                ),
                              ]),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: Column(children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Vehicle Model",
                                    style: BlipFonts.outline,
                                  ),
                                ),
                                addVerticalSpace(8),
                                TextFormField(
                                  style: BlipFonts.label,
                                  controller: _model,
                                  textAlignVertical: TextAlignVertical.center,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 16),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: const BorderSide(
                                        width: 0,
                                        style: BorderStyle.none,
                                      ),
                                    ),
                                    hintText: "Ex: Prius",
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Field cannot be empty';
                                    }
                                    return null;
                                  },
                                ),
                              ]),
                            ),
                          ],
                        ),
                        addVerticalSpace(16),
                        Column(children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Year",
                              style: BlipFonts.outline,
                            ),
                          ),
                          addVerticalSpace(8),
                          TextFormField(
                            style: BlipFonts.label,
                            textAlignVertical: TextAlignVertical.center,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 16),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                              hintText: "Ex: 2018",
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Field cannot be empty';
                              }
                              return null;
                            },
                          ),
                        ]),
                        addVerticalSpace(16),
                        Column(children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "License Plate Number",
                              style: BlipFonts.outline,
                            ),
                          ),
                          addVerticalSpace(8),
                          TextFormField(
                            style: BlipFonts.label,
                            controller: _plateno,
                            textAlignVertical: TextAlignVertical.center,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 16),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                              hintText: "Ex: CAT 9345",
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Field cannot be empty';
                              }
                              return null;
                            },
                          ),
                        ]),
                        addVerticalSpace(16),
                        Column(children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Vehicle Color",
                              style: BlipFonts.outline,
                            ),
                          ),
                          addVerticalSpace(8),
                          TextFormField(
                            style: BlipFonts.label,
                            controller: _color,
                            textAlignVertical: TextAlignVertical.center,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 16),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                              hintText: "Ex: Blue",
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Field cannot be empty';
                              }
                              return null;
                            },
                          ),
                        ]),
                        addVerticalSpace(42),
                        WideButton(
                          text: 'Add Vehicle',
                          onPressedAction: () async {},
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
