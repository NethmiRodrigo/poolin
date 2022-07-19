import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:mobile/custom/HomeToggle.dart';
import 'package:mobile/custom/RideCountDown.dart';
import 'package:mobile/custom/custom_icons_icons.dart';
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

  int endTime = DateTime.now().millisecondsSinceEpoch +
      const Duration(days: 1, hours: 2, minutes: 30).inMilliseconds;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    const double padding = 16;
    const sidePadding = EdgeInsets.symmetric(horizontal: padding);

    return Scaffold(
      body: Padding(
        padding: sidePadding,
        child: ListView(
          padding: sidePadding,
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
                  .headline5!
                  .merge(const TextStyle(color: Colors.black)),
              textAlign: TextAlign.left,
            ),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Theme.of(context).primaryColor,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: RideCountDown(endTime),
                    ),
                    Row(
                      children: [
                        Text(
                          'more for your next ride',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .merge(const TextStyle(color: Colors.white)),
                          textAlign: TextAlign.left,
                        ),
                        const Icon(icon: CustomIcons.forwardarrow)
                      ],
                    )
                  ],
                ),
              ),
            ),
            addVerticalSpace(48),
          ],
        ),
      ),
    );
  }
}
