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

class UpdateVehicleScreen extends StatefulWidget {
  const UpdateVehicleScreen({super.key});

  @override
  UpdateVehicleScreenState createState() {
    return UpdateVehicleScreenState();
  }
}

class UpdateVehicleScreenState extends State<UpdateVehicleScreen> {
  final controller = CarouselController();
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
                'Update vehicle information',
                style: BlipFonts.title,
              ),
              addVerticalSpace(36),
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
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(children: [
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Vehicle Make",
                              style: BlipFonts.outline,
                            ),
                          ),
                          addVerticalSpace(8),
                          TextField(
                            style: BlipFonts.label,
                            textAlignVertical: TextAlignVertical.center,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
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
                          ),
                        ]),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: Column(children: [
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Vehicle Model",
                              style: BlipFonts.outline,
                            ),
                          ),
                          addVerticalSpace(8),
                          TextField(
                            style: BlipFonts.label,
                            textAlignVertical: TextAlignVertical.center,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
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
                          ),
                        ]),
                      ),
                    ],
                  ),
                  addVerticalSpace(16),
                  Column(children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Year",
                        style: BlipFonts.outline,
                      ),
                    ),
                    addVerticalSpace(8),
                    TextField(
                      style: BlipFonts.label,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
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
                    ),
                  ]),
                  addVerticalSpace(16),
                  Column(children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "License Plate Number",
                        style: BlipFonts.outline,
                      ),
                    ),
                    addVerticalSpace(8),
                    TextField(
                      style: BlipFonts.label,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
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
                    ),
                  ]),
                  addVerticalSpace(16),
                  Column(children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Vehicle Color",
                        style: BlipFonts.outline,
                      ),
                    ),
                    addVerticalSpace(8),
                    TextFormField(
                      style: BlipFonts.label,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
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
                    ),
                  ]),
                  addVerticalSpace(42),
                  Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 8,
                            child: Column(
                              children: [
                                WideButton(
                                  text: 'Confirm Changes',
                                  onPressedAction: () async {},
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              children: [
                                ElevatedButton(
                                    onPressed: () async {},
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.red.shade400,
                                      padding: const EdgeInsets.all(16.0),
                                    ),
                                    child: const Icon(
                                      Icons.delete_sharp,
                                      color: Colors.white,
                                    ))
                              ],
                            ),
                          )
                        ],
                      )
                    ],
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
