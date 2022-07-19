import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:mobile/custom/WideButton.dart';
import 'package:mobile/screens/LoginScreen.dart';
import 'package:mobile/services/register_service.dart';
import 'package:mobile/utils/widget_functions.dart';
import 'package:mobile/screens/EmailOTPScreen.dart';

class RideOfferSourceScreen extends StatefulWidget {
  const RideOfferSourceScreen({super.key});

  @override
  RideOfferSourceScreenState createState() {
    return RideOfferSourceScreenState();
  }
}

class RideOfferSourceScreenState extends State<RideOfferSourceScreen> {
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
      bottomSheet: Container(
        padding: sidePadding,
        height: size.height * 0.5,
        width: size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            addVerticalSpace(24),
            Text(
              'Good morning, Dulaj',
              style: Theme.of(context).textTheme.headline5,
            ),
            addVerticalSpace(40),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    key: const Key('password-field'),
                    controller: _pass,
                    obscureText: true,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.search_outlined),
                      isDense: true,
                      border: OutlineInputBorder(),
                      hintText: "Where do you start from?",
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
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/map.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Padding(
            padding: sidePadding,
          ),
        ),
      ),
    );
  }
}
