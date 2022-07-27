import 'dart:async';

import 'package:akar_icons_flutter/akar_icons_flutter.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobile/models/ride_type_model.dart';
import 'package:mobile/screens/shared/ride/search_screen.dart';
import 'package:mobile/utils/widget_functions.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import '../offer-ride/ride_offer_destination_screen.dart';

class RideRequestDestinationScreen extends StatefulWidget {
  const RideRequestDestinationScreen({super.key});

  @override
  RideRequestDestinationScreenState createState() {
    return RideRequestDestinationScreenState();
  }
}

class RideRequestDestinationScreenState
    extends State<RideRequestDestinationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();
  final _storage = const FlutterSecureStorage();
  bool rideIsARequest = false;
  @override
  void dispose() {
    _email.dispose();
    _pass.dispose();
    _confirmPass.dispose();
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
              Align(
                alignment: Alignment.topRight,
                child: AnimatedToggleSwitch<bool>.dual(
                  current: rideIsARequest,
                  first: false,
                  second: true,
                  dif: 5.0,
                  borderColor: Colors.black,
                  borderWidth: 1,
                  height: 35,
                  onChanged: (isRideARequest) => [
                    () async {
                      if (isRideARequest) {
                        await _storage.write(
                            key: "RIDE_TYPE", value: RideType.offer.toString());
                      }
                    },
                    setState(() {
                      rideIsARequest = isRideARequest;
                    }), //   Navigator.push(
                    Timer(Duration(milliseconds: 200), () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => RideOfferDestinationScreen()));
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
                    'assets/images/rider.png',
                    height: 272,
                  )),
              addVerticalSpace(24),
              Text(
                'Where are you going?',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              addVerticalSpace(8),
              Text(
                "Let's find you a ride!",
                style: Theme.of(context).textTheme.labelLarge,
              ),
              addVerticalSpace(20),
              Form(
                key: _formKey,
                child: Column(
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
                        controller: _pass,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(AkarIcons.search),
                          isDense: true,
                          border: InputBorder.none,
                          alignLabelWithHint: true,
                          hintText: "What's your destination?",
                          contentPadding: EdgeInsets.fromLTRB(16, 8, 16, 0),
                        ),
                        onTap: (() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SearchScreen(),
                                  fullscreenDialog: true));
                        }),
                      ),
                    ),
                  ],
                ),
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
    );
  }
}
