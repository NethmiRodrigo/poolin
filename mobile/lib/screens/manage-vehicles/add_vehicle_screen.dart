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

  @override
  void dispose() {
    _make.dispose();
    _model.dispose();
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
                'Enter vehicle information',
                style: BlipFonts.title,
              ),
              addVerticalSpace(36),
              Align(
                child: Image.asset('assets/images/car.png', height: 137),
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: ListTile(
                          title: const Text(
                            'Vehicle Make',
                            style: BlipFonts.outline,
                          ),
                          subtitle: TextFormField(
                            decoration: const InputDecoration(
                              hintText: 'Ex: Toyota',
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 16),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: ListTile(
                          title: const Text(
                            'Vehicle Model',
                            style: BlipFonts.outline,
                          ),
                          //style: BlipFonts.labelBold,
                          subtitle: TextFormField(
                            decoration: const InputDecoration(
                              hintText: 'Ex: Prius',
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 16),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  addVerticalSpace(16),
                  ListTile(
                    title: const Text(
                      'Year',
                      style: BlipFonts.outline,
                    ),
                    subtitle: TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Ex: 2018',
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      ),
                    ),
                  ),
                  addVerticalSpace(16),
                  ListTile(
                    title: const Text(
                      'License Plate Number',
                      style: BlipFonts.outline,
                    ),
                    subtitle: TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Ex: EX2727596664',
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      ),
                    ),
                  ),
                  addVerticalSpace(16),
                  ListTile(
                    title: const Text(
                      'Vehicle Color',
                      style: BlipFonts.outline,
                    ),
                    subtitle: TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Ex: Blue',
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      ),
                    ),
                  ),
                  addVerticalSpace(42),
                  WideButton(
                    text: 'Add Vehicle',
                    onPressedAction: () async {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
