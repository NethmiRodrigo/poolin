import 'package:flutter/material.dart';
import 'package:mobile/utils/widget_functions.dart';

import 'package:mobile/colors.dart';
import 'package:mobile/fonts.dart';

import 'package:mobile/models/ride_offer_search_result.dart';

class RideOfferResultList extends StatelessWidget {
  final List<RideOfferSearchResult> offers;

  const RideOfferResultList(this.offers, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      thumbVisibility: true,
      child: ListView.builder(
        itemBuilder: (ctx, index) {
          return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              foregroundImage: NetworkImage(
                                offers[index].user.profilePicture,
                              ),
                            ),
                            addHorizontalSpace(5.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  offers[index].user.name,
                                  style: BlipFonts.outline,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.star_rounded,
                                      size: 10.0,
                                    ),
                                    addHorizontalSpace(8.0),
                                    Text(
                                      offers[index].user.starRating.toString(),
                                      style: BlipFonts.tagline,
                                    ),
                                    addHorizontalSpace(8.0),
                                    const Icon(
                                      Icons.circle,
                                      size: 4.0,
                                    ),
                                    addHorizontalSpace(8.0),
                                    Text(
                                      offers[index].user.noOfRatings.toString(),
                                      style: BlipFonts.tagline,
                                    )
                                  ],
                                )
                              ],
                            ),
                            const Spacer(),
                            const Icon(
                              Icons.directions_car_filled_rounded,
                              color: BlipColors.grey,
                            ),
                            addHorizontalSpace(5.0),
                            Text(
                              offers[index].model,
                              style: BlipFonts.outline,
                            )
                          ],
                        ),
                        addVerticalSpace(8.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "Rs. ${offers[index].price}",
                              style: BlipFonts.labelBold,
                            ),
                            addHorizontalSpace(8.0),
                            const Icon(Icons.chevron_right_rounded)
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ));
        },
        itemCount: offers.length,
      ),
    );
  }
}
