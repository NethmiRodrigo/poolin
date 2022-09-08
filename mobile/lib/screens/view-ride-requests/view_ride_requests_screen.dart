import 'dart:convert';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';

import 'package:mobile/colors.dart';
import 'package:mobile/fonts.dart';
import 'package:mobile/screens/ride-details/ride_details_screen.dart';
import 'package:mobile/screens/view-ride-requests/reserve_request_screen.dart';
import 'package:mobile/utils/widget_functions.dart';


import '../../cubits/active_ride_cubit.dart';
import '../../custom/backward_button.dart';
import '../../custom/indicator.dart';
import '../../custom/outline_button.dart';
import '../../custom/timeline.dart';
import '../../services/ride_offer_service.dart';

List<dynamic> selectedRequests = [];

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
    final pendingRequestsJson = json.decode(requestData.data);
    pendingRequests = (pendingRequestsJson['requests']);
    final partyData = await getConfirmedRequests();

    confirmedRequests = json.decode(partyData.data)['requests'];

    setState(() {
      isVisible = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    const double padding = 16;
    const sidePadding = EdgeInsets.symmetric(horizontal: padding);

    return BlocBuilder<ActiveRideCubit, ActiveRide>(
      builder: (context, state) {
        return Scaffold(
          body: Visibility(
            visible: isVisible,
            replacement: const Center(child: CircularProgressIndicator()),
            child: SizedBox(
              width: size.width,
              height: size.height,
              child: Padding(
                padding: sidePadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    addVerticalSpace(44),
                    const BackwardButton(),
                    addVerticalSpace(24),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            'Your ride \nis trending!',
                            style: BlipFonts.displayBlack,
                            textAlign: TextAlign.left,
                          ),
                          // Spacer(),
                          Indicator(
                              icon: FluentIcons.eye_12_regular,
                              text: "500",
                              color: BlipColors.green)
                        ],
                      ),
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
                                Text('Rs. ${state.price}',
                                    style: BlipFonts.title),
                                addHorizontalSpace(8),
                                const Indicator(
                                    icon: EvaIcons.arrowUpward,
                                    text: "+ 500",
                                    color: BlipColors.green)
                              ],
                            ),
                          ],
                        ),
                        OutlineButton(
                            onPressedAction: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const RideDetailsScreen()),
                              );
                            },
                            text: "View Ride Details",
                            color: BlipColors.black)
                      ],
                    ),
                    addVerticalSpace(24),
                    Align(
                        alignment: Alignment.center,
                        child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Colors.black, // red as border color
                                )),
                            child: Text(
                              'Your ride begins in 19 hours and 45 minutes',
                              style: Theme.of(context).textTheme.labelMedium,
                            ))),
                    addVerticalSpace(40),
                    const Text(
                      'Requests to join',
                      style: BlipFonts.heading,
                      textAlign: TextAlign.left,
                    ),
                    addVerticalSpace(16),
                    if (pendingRequests?.length != null)
                      SizedBox(
                        height: 130,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: pendingRequests?.length,
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                (Container(
                                    width: 257,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 16),
                                    decoration: const BoxDecoration(
                                      color: BlipColors.orange,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20),
                                      ), // red as border color
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Column(
                                          children: [
                                            if (pendingRequests![index]![
                                                    'avatar'] !=
                                                null)
                                              CircleAvatar(
                                                backgroundImage: NetworkImage(
                                                  pendingRequests![index]
                                                      ['avatar'],
                                                ),
                                              ),
                                            Text(
                                              pendingRequests![index]['fname'],
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelLarge!
                                                  .merge(
                                                    const TextStyle(
                                                        color: Colors.white),
                                                  ),
                                            ),
                                            Text(
                                              '+ Rs. . ${pendingRequests![index]['price']} ',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headlineLarge!
                                                  .merge(
                                                    const TextStyle(
                                                        color: Colors.white),
                                                  ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Row(
                                              children: [
                                                Check(
                                                  price: int.parse(
                                                    (pendingRequests![index]
                                                        ['price']),
                                                  ),
                                                  request:
                                                      pendingRequests![index],
                                                ),
                                                addHorizontalSpace(8),
                                                Text(
                                                  ('select').toUpperCase(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headlineSmall!
                                                      .merge(
                                                        const TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                ),
                                              ],
                                            ),
                                            OutlineButton(
                                                onPressedAction: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          ReserveRequestScreen(
                                                        request:
                                                            pendingRequests![
                                                                index],
                                                      ),
                                                    ),
                                                  );
                                                },
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
                    if (confirmedRequests != null)
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: BlipColors.lightBlue,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    ("gets on at ${request['pickup']} at ${Jiffy(request['starttime']).format("h:mm a").split(" ").join('')}")
                                        .toUpperCase(),
                                    style: BlipFonts.taglineBold.merge(
                                        const TextStyle(
                                            color: BlipColors.blue)),
                                  ),
                                ),
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
      },
    );
  }
}

class Check extends StatefulWidget {
  final price;
  final request;
  const Check({Key? key, this.price, this.request}) : super(key: key);

  @override
  State<Check> createState() => _CheckState();
}

class _CheckState extends State<Check> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    final ActiveRideCubit offerCubit =
        BlocProvider.of<ActiveRideCubit>(context);
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.white;
      }
      return Colors.white;
    }

    return Checkbox(
      checkColor: BlipColors.orange,
      fillColor: MaterialStateProperty.resolveWith(getColor),
      value: isChecked,
      onChanged: (bool? value) {
        if (value == true) {
          selectedRequests.add(widget.request);
        }
        if (value == false) {
          selectedRequests.removeWhere(
              (element) => element['requestid'] == widget.request['requestid']);
        }
        setState(() {
          isChecked = value!;
        });
        if (isChecked) {
          offerCubit.incrementPrice((widget.price));
        } else {
          offerCubit.decrementPrice((widget.price));
        }
      },
    );
  }
}
