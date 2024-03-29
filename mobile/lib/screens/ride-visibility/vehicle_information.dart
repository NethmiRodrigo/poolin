import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:poolin/custom/wide_button.dart';
import 'package:poolin/fonts.dart';
import 'package:poolin/screens/user/profile/user_profile_screen.dart';
import 'package:poolin/utils/widget_functions.dart';

import '../../colors.dart';

class VehicleInformationScreen extends StatefulWidget {
  const VehicleInformationScreen({super.key});

  @override
  VehicleInformationScreenState createState() {
    return VehicleInformationScreenState();
  }
}

class VehicleInformationScreenState extends State<VehicleInformationScreen> {
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

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    const double padding = 16;
    const sidePadding = EdgeInsets.symmetric(horizontal: padding);
    return Scaffold(
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Padding(
          padding: sidePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              addVerticalSpace(44),
              const Align(
                  alignment: Alignment.topLeft,
                  child: Icon(
                    EvaIcons.arrowBackOutline,
                    color: Colors.black,
                  )),
              addVerticalSpace(42),
              const Text(
                'Vehicle information',
                style: BlipFonts.title,
              ),
              addVerticalSpace(36),
              Align(
                child: Image.asset('assets/images/car.png', height: 137),
              ),
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
                                "Vehicle Make",
                                style: BlipFonts.outlineBold,
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                "Toyota",
                                style: BlipFonts.outline,
                              ),
                            ),
                            addVerticalSpace(8),
                            
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
                                style: BlipFonts.outlineBold,
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                "Prius",
                                style: BlipFonts.outline,
                              ),
                            ),
                            addVerticalSpace(8),
                            
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
                          style: BlipFonts.outlineBold,
                        ),
                      ),
                      addVerticalSpace(8),
                      
                    ]),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "2018",
                          style: BlipFonts.outline,
                        ),
                      ),
                    addVerticalSpace(16),
                    Column(children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "License Plate Number",
                          style: BlipFonts.outlineBold,
                        ),
                      ),
                      addVerticalSpace(8),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "CAT 9345",
                          style: BlipFonts.outline,
                        ),
                      ),
                      
                    ]),
                    addVerticalSpace(16),
                    Column(children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Vehicle Color",
                          style: BlipFonts.outlineBold,
                        ),
                      ),
                      addVerticalSpace(8),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Red",
                          style: BlipFonts.outline,
                        ),
                      ),
                      
                    ]),
                    addVerticalSpace(42),
                    WideButton(
                      text: 'Close',
                      onPressedAction: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const UserProfileScreen()),
                        )
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
