import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

import 'package:poolin/colors.dart';
import 'package:poolin/custom/role_tag.dart';
import 'package:poolin/fonts.dart';
import 'package:poolin/icons.dart';
import 'package:poolin/models/ride_offer.dart';
import 'package:poolin/utils/widget_functions.dart';

class RideOfferCard extends StatelessWidget {
  final RideOffer rideOffer;

  const RideOfferCard(this.rideOffer, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
        child: Column(
          children: [
            Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      DateFormat('d MMM yyyy, h.mm a')
                          .format(rideOffer.rideDate),
                      style: BlipFonts.outline
                          .merge(const TextStyle(color: BlipColors.grey))),
                  UserRoleTag.driver,
                ],
              ),
              const Divider(
                color: BlipColors.black,
                thickness: 1.0,
              ),
              SizedBox(
                height: 64.0,
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(DateFormat('h.mm a').format(rideOffer.rideDate),
                            style: BlipFonts.outline),
                        Text(
                            DateFormat('h.mm a')
                                .format(rideOffer.estimatedArrivalTime),
                            style: BlipFonts.outline),
                      ],
                    ),
                    const SizedBox(width: 24.0),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(rideOffer.startLocation, style: BlipFonts.outline),
                        Text(rideOffer.destination, style: BlipFonts.outline),
                      ],
                    ),
                  ],
                ),
              ),
              const Divider(
                color: BlipColors.black,
                thickness: 1.0,
              ),
            ]),
            ExpandablePanel(
              header: Container(),
              collapsed: Container(),
              expanded: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('Trip ID - ${rideOffer.id}', style: BlipFonts.labelBold),
                  addVerticalSpace(16),
                  for (var req in rideOffer.requests)
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${req.driver.firstName} ${req.driver.lastName}',
                              style: BlipFonts.outline,
                            ),
                            Wrap(
                              spacing: 10.0,
                              children: [
                                Wrap(
                                  spacing: 5.0,
                                  children: [
                                    const Icon(
                                      BlipIcons.star,
                                      color: BlipColors.gold,
                                      size: 10.0,
                                    ),
                                    Text(
                                      req.driver.stars.toString(),
                                      style: BlipFonts.tagline,
                                    ),
                                  ],
                                ),
                                Text(
                                  '\u2022 ${req.driver.totalRatings} ratings',
                                  style: BlipFonts.tagline,
                                )
                              ],
                            ),
                          ],
                        ),
                        addVerticalSpace(8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: size.width * 0.35,
                              child: Text(
                                req.pickupLocation,
                                style: BlipFonts.tagline,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const Expanded(
                              child: Divider(color: BlipColors.grey),
                            ),
                            SizedBox(
                              width: size.width * 0.35,
                              child: Text(
                                req.dropoffLocation,
                                style: BlipFonts.tagline,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.end,
                              ),
                            ),
                          ],
                        ),
                        addVerticalSpace(16),
                      ],
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Wrap(
                        spacing: 5.0,
                        children: [
                          const Icon(
                            BlipIcons.double_location_pin,
                            color: BlipColors.black,
                            size: 14.0,
                          ),
                          Text(
                            '${rideOffer.totalDistance.toString()}km',
                            style: BlipFonts.outlineBold,
                          ),
                        ],
                      ),
                      const SizedBox(width: 16.0),
                      Text('Rs. ${rideOffer.totalEarnings.toString()}',
                          style: BlipFonts.labelBold),
                    ],
                  )
                ],
              ),
              builder: (_, collapsed, expanded) => Padding(
                  padding: const EdgeInsets.all(0),
                  child: Expandable(
                    collapsed: collapsed,
                    expanded: expanded,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
