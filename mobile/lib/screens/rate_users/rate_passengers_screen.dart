import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:poolin/colors.dart';
import 'package:poolin/fonts.dart';

import '../../utils/widget_functions.dart';

class RatePassengersScreen extends StatefulWidget {
  const RatePassengersScreen({Key? key}) : super(key: key);

  @override
  State<RatePassengersScreen> createState() => _RatePassengersScreenState();
}

class _RatePassengersScreenState extends State<RatePassengersScreen> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    const double padding = 16;
    const sidePadding = EdgeInsets.symmetric(horizontal: padding);
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: Padding(
            padding: sidePadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                addVerticalSpace(96),
                const Text(
                  "Your ride has been completed!",
                  style: BlipFonts.heading,
                  textAlign: TextAlign.center,
                ),
                addVerticalSpace(96),
                const Text(
                  "Rate the passengers",
                  style: BlipFonts.labelBold,
                ),
                Column(
                  children: [
                    addVerticalSpace(16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const CircleAvatar(
                                radius: 16,
                                backgroundImage:
                                    NetworkImage("https://i.pravatar.cc/500"),
                              ),
                              addHorizontalSpace(8),
                              const Text("Yadeesha \nWeerasinghe",
                                  style: BlipFonts.outline),
                            ],
                          ),
                          RatingBar.builder(
                            initialRating: 3,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 16,
                            itemPadding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => const Icon(
                              EvaIcons.star,
                              size: 8,
                              color: BlipColors.gold,
                            ),
                            onRatingUpdate: (rating) {},
                          ),
                        ],
                      ),
                    ),
                    addVerticalSpace(16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const CircleAvatar(
                                radius: 16,
                                backgroundImage:
                                    NetworkImage("https://i.pravatar.cc/300"),
                              ),
                              addHorizontalSpace(8),
                              const Text("Yadeesha \nWeerasinghe",
                                  style: BlipFonts.outline),
                            ],
                          ),
                          RatingBar.builder(
                            initialRating: 3,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 16,
                            itemPadding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => const Icon(
                              EvaIcons.star,
                              size: 8,
                              color: BlipColors.gold,
                            ),
                            onRatingUpdate: (rating) {},
                          ),
                        ],
                      ),
                    ),
                    addVerticalSpace(16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const CircleAvatar(
                                radius: 16,
                                backgroundImage:
                                    NetworkImage("https://i.pravatar.cc/400"),
                              ),
                              addHorizontalSpace(8),
                              const Text("Yadeesha \nWeerasinghe",
                                  style: BlipFonts.outline),
                            ],
                          ),
                          RatingBar.builder(
                            initialRating: 3,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 16,
                            itemPadding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => const Icon(
                              EvaIcons.star,
                              size: 8,
                              color: BlipColors.gold,
                            ),
                            onRatingUpdate: (rating) {},
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                const Text("Skip", style: BlipFonts.outlineBold),
                addVerticalSpace(48),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
