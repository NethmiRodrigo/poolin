import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:mobile/custom/wide_button.dart';
import 'package:mobile/fonts.dart';
import 'package:mobile/utils/widget_functions.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../colors.dart';

var reports = [
  {'title': '1', 'content': '1'},
  {'title': '2', 'content': '2'},
  {'title': '3', 'content': '3'},
  {'title': '4', 'content': '4'},
];

class SelectVehicleTypeScreen extends StatefulWidget {
  const SelectVehicleTypeScreen({super.key});

  @override
  SelectVehicleTypeScreenState createState() {
    return SelectVehicleTypeScreenState();
  }
}

class SelectVehicleTypeScreenState extends State<SelectVehicleTypeScreen> {
  final controller = CarouselController();

  final featuredImages = [
    'assets/images/car.png',
    'assets/images/van.png',
    'assets/images/bike.png'
  ];

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    const double padding = 16;
    const sidePadding = EdgeInsets.symmetric(horizontal: padding);
    // ignore: dead_code

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
              addVerticalSpace(140),
              const Text(
                'What do you drive?',
                style: BlipFonts.title,
              ),
              addVerticalSpace(40),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: IconButton(
                            onPressed: () {
                              // Use the controller to change the current page
                              controller.previousPage();
                            },
                            icon: const Icon(Icons.arrow_back_ios),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Column(
                      children: [
                        CarouselSlider(
                          carouselController: controller,
                          options: CarouselOptions(
                            height: 250.0,
                          ),
                          items: reports
                              .asMap()
                              .map(
                                (i, report) {
                                  return MapEntry(
                                    i,
                                    Builder(
                                      builder: (BuildContext context) {
                                        return Container(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(
                                                '${report['title']}',
                                              ),
                                              Text(
                                                '${report['content']}',
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                },
                              )
                              .values
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            onPressed: () {
                              // Use the controller to change the current page
                              controller.nextPage();
                            },
                            icon: const Icon(Icons.arrow_forward_ios),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              addVerticalSpace(44),
              WideButton(
                text: 'Proceed',
                onPressedAction: () async {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
