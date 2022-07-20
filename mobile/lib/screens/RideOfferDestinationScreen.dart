import 'package:akar_icons_flutter/akar_icons_flutter.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:mobile/custom/WideButton.dart';
import 'package:mobile/screens/LoginScreen.dart';
import 'package:mobile/services/register_service.dart';
import 'package:mobile/utils/widget_functions.dart';
import 'package:mobile/screens/EmailOTPScreen.dart';
import 'package:akar_icons_flutter/akar_icons_flutter.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:rolling_switch/rolling_switch.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';

class RideOfferDestinationScreen extends StatefulWidget {
  const RideOfferDestinationScreen({super.key});

  @override
  RideOfferDestinationScreenState createState() {
    return RideOfferDestinationScreenState();
  }
}

class RideOfferDestinationScreenState
    extends State<RideOfferDestinationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();
  final _storage = const FlutterSecureStorage();
  bool positive = false;
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
              Align(
                  alignment: Alignment.topLeft,
                  child: Icon(
                    EvaIcons.arrowBackOutline,
                    color: Colors.black,
                  )),
              Align(
                alignment: Alignment.topRight,
                child: AnimatedToggleSwitch<bool>.dual(
                  current: positive,
                  first: false,
                  second: true,
                  dif: 5.0,
                  borderColor: Colors.black,
                  borderWidth: 1,
                  height: 35,
                  onChanged: (b) => setState(() => positive = b),
                  colorBuilder: (b) => b ? Colors.black : Colors.black,
                  iconBuilder: (value) => value
                      ? Icon(Icons.drive_eta_rounded, color: Colors.white)
                      : Icon(Icons.airline_seat_recline_extra_rounded,
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
                    'assets/images/driver.png',
                    height: 272,
                  )),
              addVerticalSpace(24),
              Text(
                'Where are you headed?',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              addVerticalSpace(8),
              Text(
                "Let's let everyone know!",
                style: Theme.of(context).textTheme.labelLarge,
              ),
              addVerticalSpace(32),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    addVerticalSpace(24),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).backgroundColor,
                      ),
                      child: TextFormField(
                        style: Theme.of(context).textTheme.labelLarge,
                        textAlignVertical: TextAlignVertical.center,
                        key: const Key('password-field'),
                        controller: _pass,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(AkarIcons.search),
                          isDense: true,
                          border: InputBorder.none,
                          alignLabelWithHint: true,
                          hintText: "What's your destination?",
                          contentPadding: EdgeInsets.fromLTRB(16, 8, 16, 0),
                        ),
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
                        Icon(FluentIcons.location_16_filled),
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
                        Icon(FluentIcons.location_16_filled),
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
