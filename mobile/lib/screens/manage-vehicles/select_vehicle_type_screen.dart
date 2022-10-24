import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:poolin/custom/wide_button.dart';
import 'package:poolin/fonts.dart';
import 'package:poolin/utils/widget_functions.dart';
import 'package:carousel_slider/carousel_slider.dart';

var reports = [
  {'title': 'assets/images/car.png', 'content': 'Car'},
  {'title': 'assets/images/van.png', 'content': 'Van'},
  {'title': 'assets/images/bike.png', 'content': 'Bike'},
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
                    flex: 7,
                    child: Column(
                      children: [
                        CarouselSlider(
                          carouselController: controller,
                          options: CarouselOptions(viewportFraction: 1),
                          items: reports
                              .asMap()
                              .map(
                                (i, report) {
                                  return MapEntry(
                                    i,
                                    Builder(
                                      builder: (BuildContext context) {
                                        return Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Expanded(
                                              flex: 8,
                                              child: Image.asset(
                                                '${report['title']}',
                                                height: 80,
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                '${report['content']}',
                                                style: BlipFonts.label,
                                              ),
                                            ),
                                          ],
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
                    flex: 3,
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
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
