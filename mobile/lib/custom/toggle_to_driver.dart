import 'package:flutter/material.dart';
import 'dart:async';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';

import 'package:mobile/screens/home/DriverHomeScreen.dart';
import 'package:mobile/screens/home/RiderHomeScreen.dart';

class ToggleToDriver extends StatefulWidget {
  final bool activeScreen;

  const ToggleToDriver(this.activeScreen, {Key? key}) : super(key: key);

  @override
  State<ToggleToDriver> createState() => _ToggleState();
}

class _ToggleState extends State<ToggleToDriver> {
  bool positive = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedToggleSwitch<bool>.dual(
      current: widget.activeScreen ? false : true,
      first: false,
      second: true,
      dif: 5.0,
      borderColor: Colors.black,
      borderWidth: 1,
      height: 35,
      onChanged: (b) => [
        setState(() => positive = !b),
        Timer(const Duration(milliseconds: 200), () {
          widget.activeScreen
              ? Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DriverHomeScreen()))
              : Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RiderHomeScreen()));
        }),
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
    );
  }
}
