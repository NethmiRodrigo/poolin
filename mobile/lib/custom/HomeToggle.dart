import 'package:flutter/material.dart';
import 'package:mobile/custom/custom_icons_icons.dart';
import 'package:mobile/screens/DriverHomeScreen.dart';
import 'package:mobile/screens/RiderHomeScreen.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeToggle extends StatelessWidget {
  // final Widget activeScreen;

  // Toggle(this.activeScreen);

  @override
  Widget build(BuildContext context) {
    return ToggleSwitch(
      minWidth: 80,
      initialLabelIndex: 1,
      cornerRadius: 20.0,
      activeFgColor: Colors.white,
      inactiveBgColor: Colors.grey,
      inactiveFgColor: Colors.white,
      totalSwitches: 2,
      labels: ['Driver', 'Rider'],
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
      icons: [CustomIcons.driver, CustomIcons.rider],
      activeBgColor: [Colors.black],
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
