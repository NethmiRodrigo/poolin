import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/index.dart';

class RideCountDown extends StatefulWidget {
  final int endTime;

  RideCountDown(this.endTime);

  @override
  State<RideCountDown> createState() => _RideCountDownState();
}

class _RideCountDownState extends State<RideCountDown> {
  late CountdownTimerController controller;

  @override
  void initState() {
    super.initState();
    controller =
        CountdownTimerController(endTime: widget.endTime, onEnd: () => {});
  }

  @override
  Widget build(BuildContext context) {
    return CountdownTimer(
      controller: controller,
      widgetBuilder: (_, CurrentRemainingTime? time) {
        if (time == null) {
          return Text(
            'Trip in Progress',
            style: Theme.of(context)
                .textTheme
                .headline4!
                .merge(const TextStyle(color: Colors.white)),
          );
        }
        return RichText(
          text: TextSpan(
            text: ' ${time.days}',
            style: Theme.of(context)
                .textTheme
                .headline4!
                .merge(const TextStyle(color: Colors.white)),
            children: [
              TextSpan(
                text: time.days! > 1 ? ' days' : ' day',
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .merge(const TextStyle(color: Colors.white)),
              ),
              TextSpan(
                text: ' ${time.hours}',
                style: Theme.of(context)
                    .textTheme
                    .headline4!
                    .merge(const TextStyle(color: Colors.white)),
              ),
              TextSpan(
                text: time.hours! > 1 ? ' hrs' : ' hr',
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .merge(const TextStyle(color: Colors.white)),
              ),
              TextSpan(
                text: ' ${time.min}',
                style: Theme.of(context)
                    .textTheme
                    .headline4!
                    .merge(const TextStyle(color: Colors.white)),
              ),
              TextSpan(
                text: time.min! > 1 ? ' mins' : ' min',
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .merge(const TextStyle(color: Colors.white)),
              ),
            ],
          ),
        );
      },
    );
  }
}
