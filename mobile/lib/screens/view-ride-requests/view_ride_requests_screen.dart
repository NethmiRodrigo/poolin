import 'dart:convert';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:mobile/colors.dart';
import 'package:mobile/custom/check.dart';

import 'package:mobile/fonts.dart';
import 'package:mobile/models/ride_request.dart';

import 'package:mobile/utils/widget_functions.dart';

import '../../custom/indicator.dart';
import '../../custom/outline_button.dart';
import '../../custom/timeline.dart';
import '../../services/ride_offer_service.dart';

class ViewRideRequestsScreen extends StatefulWidget {
  const ViewRideRequestsScreen({super.key});

  @override
  ViewRideRequestsScreenState createState() {
    return ViewRideRequestsScreenState();
  }
}

class ViewRideRequestsScreenState extends State<ViewRideRequestsScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();
  final _storage = const FlutterSecureStorage();
  var isVisible = false;
  List<dynamic>? requests;

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  void dispose() {
    _email.dispose();
    _pass.dispose();
    _confirmPass.dispose();
    super.dispose();
  }

  getData() async {
    var requestData = await getOfferRequests();
    var requestsJson = json.decode(requestData.body);
    requests = (requestsJson['requests']);
    // var requests = requestsFromJson(requestsJson['requests']);
    setState(() {
      isVisible = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    const double padding = 16;
    const sidePadding = EdgeInsets.symmetric(horizontal: padding);

    return Scaffold(
      body: Visibility(
        visible: isVisible,
        replacement: Center(child: CircularProgressIndicator()),
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Padding(
            padding: sidePadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                addVerticalSpace(44),
                Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      icon: const Icon(EvaIcons.arrowBackOutline),
                      color: Colors.black,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )),
                addVerticalSpace(24),
                Row(
                  children: [
                    Text(
                      'Your ride \nis trending!',
                      style: BlipFonts.displayBlack,
                      textAlign: TextAlign.left,
                    ),
                    addHorizontalSpace(100),
                    Indicator(
                        icon: FluentIcons.eye_12_regular,
                        text: "500",
                        color: BlipColors.green)
                  ],
                ),
                addVerticalSpace(48),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(('You Earn').toUpperCase(),
                            style: Theme.of(context).textTheme.titleLarge),
                        Row(
                          children: [
                            Text('Rs. 5000',
                                style: BlipFonts.title.merge(TextStyle(
                                  color: BlipColors.green,
                                ))),
                            addHorizontalSpace(8),
                            Indicator(
                                icon: EvaIcons.arrowUpward,
                                text: "+ 500",
                                color: BlipColors.green)
                          ],
                        ),
                      ],
                    ),
                    OutlineButton(
                        text: "View Ride Details", color: BlipColors.black)
                  ],
                ),
                addVerticalSpace(24),
                Align(
                    child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.black, // red as border color
                            )),
                        child: Text(
                          'Your ride begins in 19 hours and 45 minutes',
                          style: Theme.of(context).textTheme.labelMedium,
                        )),
                    alignment: Alignment.center),
                addVerticalSpace(40),
                Text(
                  'Requests to join',
                  style: BlipFonts.heading,
                  textAlign: TextAlign.left,
                ),
                addVerticalSpace(16),
                Container(
                  height: 125,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: requests?.length,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          (Container(
                              width: 257,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 16),
                              decoration: BoxDecoration(
                                color: BlipColors.orange,
                                borderRadius: BorderRadius.all(
                                    Radius.circular(20)), // red as border color
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              requests![index]['avatar'])),
                                      Text(
                                        requests![index]['fname'],
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge!
                                            .merge(
                                                TextStyle(color: Colors.white)),
                                      ),
                                      Text(
                                        "+ Rs. " + requests![index]['price'],
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineLarge!
                                            .merge(
                                                TextStyle(color: Colors.white)),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Row(
                                        children: [
                                          Check(),
                                          addHorizontalSpace(8),
                                          Text(('select').toUpperCase(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headlineSmall!
                                                  .merge(TextStyle(
                                                      color: Colors.white))),
                                        ],
                                      ),
                                      OutlineButton(
                                          text: "View Request",
                                          color: BlipColors.white)
                                    ],
                                  ),
                                ],
                              ))),
                          addHorizontalSpace(16),
                        ],
                      );
                    },
                    // children: <Widget>[
                    //   Container(
                    //       width: 257,
                    //       padding: EdgeInsets.symmetric(
                    //           horizontal: 12, vertical: 16),
                    //       decoration: BoxDecoration(
                    //         color: BlipColors.orange,
                    //         borderRadius: BorderRadius.all(
                    //             Radius.circular(20)), // red as border color
                    //       ),
                    //       child: Row(
                    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //         crossAxisAlignment: CrossAxisAlignment.center,
                    //         children: [
                    //           Column(
                    //             children: [
                    //               CircleAvatar(
                    //                 backgroundImage: NetworkImage(
                    //                     "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg.jpg?fit=640,427"),
                    //               ),
                    //               Text(
                    //                 "Yadeesha",
                    //                 style: Theme.of(context)
                    //                     .textTheme
                    //                     .labelLarge!
                    //                     .merge(TextStyle(color: Colors.white)),
                    //               ),
                    //               Text(
                    //                 "+ Rs. 500",
                    //                 style: Theme.of(context)
                    //                     .textTheme
                    //                     .headlineLarge!
                    //                     .merge(TextStyle(color: Colors.white)),
                    //               ),
                    //             ],
                    //           ),
                    //           Column(
                    //             mainAxisAlignment:
                    //                 MainAxisAlignment.spaceBetween,
                    //             crossAxisAlignment: CrossAxisAlignment.end,
                    //             children: [
                    //               Row(
                    //                 children: [
                    //                   Check(),
                    //                   addHorizontalSpace(8),
                    //                   Text(('select').toUpperCase(),
                    //                       style: Theme.of(context)
                    //                           .textTheme
                    //                           .headlineSmall!
                    //                           .merge(TextStyle(
                    //                               color: Colors.white))),
                    //                 ],
                    //               ),
                    //               OutlineButton(
                    //                   text: "View Request",
                    //                   color: BlipColors.white)
                    //             ],
                    //           ),
                    //         ],
                    //       )),
                    //   addHorizontalSpace(16),
                    //   Container(
                    //     width: 257,
                    //     padding:
                    //         EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                    //     decoration: BoxDecoration(
                    //       color: BlipColors.black,
                    //       borderRadius: BorderRadius.all(
                    //           Radius.circular(20)), // red as border color
                    //     ),
                    //   ),
                    //   Container(
                    //     width: 200,
                    //     color: Colors.purple[400],
                    //     child: const Center(
                    //         child: Text(
                    //       'Item 3',
                    //       style: TextStyle(fontSize: 18, color: Colors.white),
                    //     )),
                    //   ),
                    //   Container(
                    //     width: 200,
                    //     color: Colors.orange[800],
                    //     child: const Center(
                    //         child: Text(
                    //       'Item 4',
                    //       style: TextStyle(fontSize: 18, color: Colors.white),
                    //     )),
                    //   ),
                    // ],
                  ),
                ),
                addVerticalSpace(24),
                const Text(
                  'Joining you',
                  style: BlipFonts.heading,
                  textAlign: TextAlign.left,
                ),
                Timeline(
                  indicators: const <Widget>[
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                          "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg.jpg?fit=640,427"),
                    ),
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                          "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg.jpg?fit=640,427"),
                    ),
                  ],
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Yadeesha Weerasinghe', style: BlipFonts.outline),
                        Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 4, vertical: 2),
                            decoration: BoxDecoration(
                              color: BlipColors.lightBlue,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              ('gets on at University of Colombo at 10AM')
                                  .toUpperCase(),
                              style: BlipFonts.taglineBold
                                  .merge(TextStyle(color: BlipColors.blue)),
                            )),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Yadeesha Weerasinghe', style: BlipFonts.outline),
                        Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 4, vertical: 2),
                            decoration: BoxDecoration(
                              color: BlipColors.lightBlue,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              ('gets on at University of Colombo at 10AM')
                                  .toUpperCase(),
                              style: BlipFonts.taglineBold
                                  .merge(TextStyle(color: BlipColors.blue)),
                            )),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
