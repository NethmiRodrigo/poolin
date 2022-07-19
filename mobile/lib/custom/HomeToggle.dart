import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

import 'package:mobile/custom/custom_icons_icons.dart';
import 'package:mobile/screens/DriverHomeScreen.dart';
import 'package:mobile/screens/RiderHomeScreen.dart';

class HomeToggle extends StatelessWidget {
  // final Widget activeScreen;

  // Toggle(this.activeScreen);

  @override
  Widget build(BuildContext context) {
    return ToggleSwitch(
      minWidth: 90,
      initialLabelIndex: 1,
      cornerRadius: 20.0,
      activeFgColor: Colors.white,
      inactiveBgColor: Colors.grey,
      inactiveFgColor: Colors.white,
      totalSwitches: 2,
      labels: const ['Driver', 'Rider'],
      customTextStyles: [
        Theme.of(context)
            .textTheme
            .bodyText1!
            .merge(const TextStyle(color: Colors.white)),
        Theme.of(context)
            .textTheme
            .bodyText1!
            .merge(const TextStyle(color: Colors.white)),
      ],
      icons: const [CustomIcons.driver, CustomIcons.rider],
      activeBgColor: const [Colors.black],
      onToggle: (index) {
        (index == 0)
            ? Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const DriverHomeScreen()))
            : Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const RiderHomeScreen()));
      },
    );
  }
}
