import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:mobile/colors.dart';
import 'package:mobile/fonts.dart';

import '../../utils/widget_functions.dart';

class RateDriverScreen extends StatefulWidget {
  const RateDriverScreen({Key? key}) : super(key: key);

  @override
  State<RateDriverScreen> createState() => _RateDriverScreenState();
}

class _RateDriverScreenState extends State<RateDriverScreen> {
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
                Text(
                  "Your ride has been completed!",
                  style: BlipFonts.heading,
                  textAlign: TextAlign.center,
                ),
                addVerticalSpace(96),
                Text(
                  "Rate your driver",
                  style: BlipFonts.labelBold,
                ),
                addVerticalSpace(16),
                RatingBar.builder(
                  initialRating: 3,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Icon(
                    EvaIcons.star,
                    color: BlipColors.gold,
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
                addVerticalSpace(24),
                Text(
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
                              CircleAvatar(
                                radius: 16,
                                backgroundImage:
                                    NetworkImage("https://i.pravatar.cc/800"),
                              ),
                              addHorizontalSpace(8),
                              Text("Yadeesha \nWeerasinghe",
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
                            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => Icon(
                              EvaIcons.star,
                              size: 8,
                              color: BlipColors.gold,
                            ),
                            onRatingUpdate: (rating) {
                              print(rating);
                            },
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
                              CircleAvatar(
                                radius: 16,
                                backgroundImage:
                                    NetworkImage("https://i.pravatar.cc/900"),
                              ),
                              addHorizontalSpace(8),
                              Text("Yadeesha \nWeerasinghe",
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
                            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => Icon(
                              EvaIcons.star,
                              size: 8,
                              color: BlipColors.gold,
                            ),
                            onRatingUpdate: (rating) {
                              print(rating);
                            },
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
                              CircleAvatar(
                                radius: 16,
                                backgroundImage:
                                    NetworkImage("https://i.pravatar.cc/700"),
                              ),
                              addHorizontalSpace(8),
                              Text("Yadeesha \nWeerasinghe",
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
                            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => Icon(
                              EvaIcons.star,
                              size: 8,
                              color: BlipColors.gold,
                            ),
                            onRatingUpdate: (rating) {
                              print(rating);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Text("Skip", style: BlipFonts.outlineBold),
                addVerticalSpace(48),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
