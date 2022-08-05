import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:mobile/colors.dart';
import 'package:mobile/custom/role_tag.dart';
import 'package:mobile/fonts.dart';
import 'package:mobile/icons.dart';
import 'package:mobile/models/ride_request.dart';
import 'package:mobile/models/vehicle_type.dart';
import 'package:mobile/utils/widget_functions.dart';

class RideRequestCard extends StatelessWidget {
  final RideRequest rideRequest;

  const RideRequestCard(this.rideRequest, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                          .format(rideRequest.pickupTime),
                      style: BlipFonts.outline
                          .merge(const TextStyle(color: BlipColors.grey))),
                  UserRoleTag.rider,
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
                        Text(
                            DateFormat('h.mm a').format(rideRequest.pickupTime),
                            style: BlipFonts.outline),
                        Text(
                            DateFormat('h.mm a')
                                .format(rideRequest.dropoffTime),
                            style: BlipFonts.outline),
                      ],
                    ),
                    const SizedBox(width: 24.0),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(rideRequest.pickupLocation,
                            style: BlipFonts.outline),
                        Text(rideRequest.dropoffLocation,
                            style: BlipFonts.outline),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Trip ID - ${rideRequest.id}',
                      style: BlipFonts.labelBold),
                  addVerticalSpace(16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          '${rideRequest.driver.firstName} ${rideRequest.driver.lastName}',
                          style: BlipFonts.outline),
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
                                rideRequest.driver.stars.toString(),
                                style: BlipFonts.tagline,
                              ),
                            ],
                          ),
                          Text(
                            '\u2022 ${rideRequest.driver.totalRatings} ratings',
                            style: BlipFonts.tagline,
                          )
                        ],
                      ),
                    ],
                  ),
                  addVerticalSpace(12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      (rideRequest.driver.vehicleType == VehicleType.bike)
                          ? const Icon(
                              BlipIcons.bike,
                              color: BlipColors.grey,
                              size: 24.0,
                            )
                          : (rideRequest.driver.vehicleType == VehicleType.van)
                              ? const Icon(
                                  BlipIcons.car,
                                  color: BlipColors.grey,
                                  size: 24.0,
                                )
                              : const Icon(
                              BlipIcons.car,
                              color: BlipColors.grey,
                              size: 24.0,
                            ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            rideRequest.driver.VehicleNum,
                            style: BlipFonts.labelBold,
                          ),
                          Text(
                            '${toBeginningOfSentenceCase(rideRequest.driver.vehicleType.name)}',
                            style: BlipFonts.outline,
                          ),
                        ],
                      ),
                    ],
                  ),
                  addVerticalSpace(16),
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
                            '${rideRequest.totalDistance.toString()}km',
                            style: BlipFonts.outlineBold,
                          ),
                        ],
                      ),
                      const SizedBox(width: 16.0),
                      Text('Rs. ${rideRequest.rideFare.toString()}',
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
