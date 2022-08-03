import 'dart:convert';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jiffy/jiffy.dart';

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
  List<dynamic>? pendingRequests;
  List<dynamic>? confirmedRequests;

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
    final requestData = await getOfferRequests();
    final pendingRequestsJson = json.decode(requestData.body);
    pendingRequests = (pendingRequestsJson['requests']);
    final partyData = await getConfirmedRequests();
    confirmedRequests = json.decode(partyData.body)['requests'];
    print(confirmedRequests![0]);

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
                        onPressedAction: () {},
                        text: "View Ride Details",
                        color: BlipColors.black)
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
                    itemCount: pendingRequests?.length,
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
                                              pendingRequests![index]
                                                  ['avatar'])),
                                      Text(
                                        pendingRequests![index]['fname'],
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge!
                                            .merge(
                                                TextStyle(color: Colors.white)),
                                      ),
                                      Text(
                                        "+ Rs. " +
                                            pendingRequests![index]['price'],
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
                                          onPressedAction: () {},
                                          text: "View Request",
                                          color: BlipColors.white),
                                    ],
                                  ),
                                ],
                              ))),
                          addHorizontalSpace(16),
                        ],
                      );
                    },
                  ),
                ),
                addVerticalSpace(24),
                const Text(
                  'Joining you',
                  style: BlipFonts.heading,
                  textAlign: TextAlign.left,
                ),
                Timeline(
                  indicators: <Widget>[
                    for (var request in confirmedRequests!)
                      CircleAvatar(
                        backgroundImage: NetworkImage(request['avatar']),
                      ),
                  ],
                  children: <Widget>[
                    for (var request in confirmedRequests!)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(request['fname'] + " " + request['lname'],
                              style: BlipFonts.outline),
                          Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 4, vertical: 2),
                              decoration: BoxDecoration(
                                color: BlipColors.lightBlue,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                ('gets on at ' +
                                        request['pickup'] +
                                        " at " +
                                        Jiffy(request['starttime'])
                                            .format("h:mm a")
                                            .split(" ")
                                            .join(''))
                                    .toUpperCase(),
                                style: BlipFonts.taglineBold
                                    .merge(TextStyle(color: BlipColors.blue)),
                              )),
                        ],
                      ),
                    //
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
