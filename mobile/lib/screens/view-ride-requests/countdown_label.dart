import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:poolin/cubits/active_ride_cubit.dart';
import 'package:poolin/fonts.dart';

class CountDownLabel extends StatelessWidget {
  const CountDownLabel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ActiveRideCubit offerCubit = BlocProvider.of<ActiveRideCubit>(context);
    CountdownTimerController controller = CountdownTimerController(
        endTime: offerCubit.getDepartureTime().millisecondsSinceEpoch,
        onEnd: () => {});
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.black,
        ),
      ),
      child: CountdownTimer(
          controller: controller,
          widgetBuilder: (_, CurrentRemainingTime? time) {
            if (time == null) {
              return const Text(
                'Trip in Progress',
                style: BlipFonts.labelBold,
              );
            }
            return RichText(
              text: TextSpan(
                text: 'Your ride begins in ',
                style: Theme.of(context).textTheme.labelMedium,
                children: [
                  TextSpan(
                    text: '${time.days}',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  TextSpan(
                    text: time.days! > 1 ? ' days' : ' day',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  TextSpan(
                    text: ' ${time.hours}',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  TextSpan(
                    text: time.hours! > 1 ? ' hrs' : ' hr',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  TextSpan(
                    text: ' ${time.min}',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  TextSpan(
                    text: time.min! > 1 ? ' mins' : ' min',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ],
              ),
            );
          }),
    );
  }
}
