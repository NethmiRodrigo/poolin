import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:mobile/custom/HomeToggle.dart';
import 'package:mobile/utils/widget_functions.dart';

class DriverHomeScreen extends StatefulWidget {
  const DriverHomeScreen({super.key});

  @override
  DriverHomeScreenState createState() {
    return DriverHomeScreenState();
  }
}

class DriverHomeScreenState extends State<DriverHomeScreen> {
  final _storage = const FlutterSecureStorage();

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
                child: HomeToggle(),
              ),
              Text(
                'Going somewhere?',
                style: Theme.of(context)
                    .textTheme
                    .headline3!
                    .merge(const TextStyle(color: Colors.black)),
                textAlign: TextAlign.left,
              ),
              addVerticalSpace(48),
              Text(
                'Rest of home screen',
                style: Theme.of(context)
                    .textTheme
                    .headline3!
                    .merge(const TextStyle(color: Colors.black)),
                textAlign: TextAlign.left,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
