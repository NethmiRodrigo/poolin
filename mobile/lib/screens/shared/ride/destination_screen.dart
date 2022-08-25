import 'dart:async';

import 'package:akar_icons_flutter/akar_icons_flutter.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobile/colors.dart';
import 'package:mobile/fonts.dart';
import 'package:mobile/models/ride_type_model.dart';
import 'package:mobile/screens/shared/ride/search_screen.dart';
import 'package:mobile/services/auth_service.dart';
import 'package:mobile/utils/widget_functions.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';

class DestinationScreen extends StatefulWidget {
  RideType rideType = RideType.offer;
  DestinationScreen({super.key, this.rideType = RideType.offer});

  @override
  DestinationScreenState createState() {
    return DestinationScreenState();
  }
}

class DestinationScreenState extends State<DestinationScreen> {
  final _storage = const FlutterSecureStorage();
  late RideType _rideType;
  late bool isRideAnOffer;

  @override
  void initState() {
    super.initState();
    _rideType = widget.rideType;
    isRideAnOffer = _rideType != RideType.request;
    getCurrentUser();
  }

  Future<void> setRideTypeInStoreage(
      BuildContext context, VoidCallback onSuccess) async {
    await _storage.write(key: "RIDE_TYPE", value: _rideType.name);
    onSuccess.call();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    const double padding = 16;
    const sidePadding = EdgeInsets.symmetric(horizontal: padding);

    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: BlipColors.black),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: sidePadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                addVerticalSpace(16),
                Align(
                  alignment: Alignment.topRight,
                  child: AnimatedToggleSwitch<bool>.dual(
                    current: isRideAnOffer,
                    first: false,
                    second: true,
                    dif: 5.0,
                    borderColor: Colors.black,
                    borderWidth: 1,
                    height: 35,
                    onChanged: (toggleValue) => [
                      setState(() {
                        isRideAnOffer = toggleValue;
                        if (isRideAnOffer) {
                          _rideType = RideType.offer;
                        } else {
                          _rideType = RideType.request;
                        }
                      })
                    ],
                    colorBuilder: (b) => b ? Colors.black : Colors.black,
                    iconBuilder: (value) => value
                        ? const Icon(Icons.drive_eta_rounded, color: Colors.white)
                        : const Icon(Icons.airline_seat_recline_extra_rounded,
                            color: Colors.white),
                    textBuilder: (value) => value
                        ? Center(
                            child: Text(
                            'Driver',
                            style: Theme.of(context).textTheme.labelMedium,
                          ))
                        : Center(
                            child: Text(
                            'Rider',
                            style: Theme.of(context).textTheme.labelMedium,
                          )),
                  ),
                ),
                Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      isRideAnOffer
                          ? 'assets/images/driver.png'
                          : 'assets/images/rider.png',
                      height: 272,
                    )),
                addVerticalSpace(24),
                Text(
                  isRideAnOffer
                      ? 'Where are you headed?'
                      : 'Where are you going?',
                  style: BlipFonts.title,
                ),
                addVerticalSpace(8),
                Text(
                  isRideAnOffer
                      ? "Let's let everyone know!"
                      : "Let's find you a ride!",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                addVerticalSpace(20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        autofocus: false,
                        showCursor: false,
                        readOnly: true,
                        style: Theme.of(context).textTheme.labelLarge,
                        textAlignVertical: TextAlignVertical.center,
                        key: const Key('destination-field'),
                        decoration: const InputDecoration(
                          prefixIcon: Icon(AkarIcons.search),
                          hintText: "What's your destination?",
                        ),
                        onTap: (() => setRideTypeInStoreage(
                              context,
                              () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const SearchScreen(),
                                      fullscreenDialog: true),
                                );
                              },
                            )),
                      ),
                    ),
                  ],
                ),
                addVerticalSpace(16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Icon(FluentIcons.location_16_filled),
                          addHorizontalSpace(16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'University of Colombo',
                                style: Theme.of(context).textTheme.headlineMedium,
                              ),
                              Text(
                                '206/A, Reid Avenue, Colombo 07',
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            ],
                          )
                        ],
                      ),
                      addVerticalSpace(16),
                      Row(
                        children: [
                          const Icon(FluentIcons.location_16_filled),
                          addHorizontalSpace(16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'University of Colombo',
                                style: Theme.of(context).textTheme.headlineMedium,
                              ),
                              Text(
                                '206/A, Reid Avenue, Colombo 07',
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
