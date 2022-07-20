import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:mobile/custom/WideButton.dart';
import 'package:mobile/screens/LoginScreen.dart';
import 'package:mobile/services/register_service.dart';
import 'package:mobile/utils/widget_functions.dart';
import 'package:mobile/screens/EmailOTPScreen.dart';

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
              addVerticalSpace(48),
              Align(
                alignment: Alignment.topRight,
                child: Text(
                  'Rider',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/images/driver.png',
                    height: 272,
                  )),
              addVerticalSpace(48),
              Text(
                'Where are you headed?',
                style: Theme.of(context).textTheme.headline5,
              ),
              addVerticalSpace(8),
              Text(
                "Let's let everyone know!",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              addVerticalSpace(40),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    addVerticalSpace(24),
                    TextFormField(
                      key: const Key('password-field'),
                      controller: _pass,
                      obscureText: true,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.search_outlined),
                        isDense: true,
                        border: OutlineInputBorder(),
                        hintText: "What's your destination?",
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                      ),
                    ),
                  ],
                ),
              ),
              addVerticalSpace(16),
              Row(
                children: [
                  Icon(Icons.location_pin),
                  addHorizontalSpace(16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'University of Colombo',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      Text(
                        '206/A, Reid Avenue, Colombo 07',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ],
                  )
                ],
              ),
              addVerticalSpace(16),
              Row(
                children: [
                  Icon(Icons.location_pin),
                  addHorizontalSpace(16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'University of Colombo',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      Text(
                        '206/A, Reid Avenue, Colombo 07',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
