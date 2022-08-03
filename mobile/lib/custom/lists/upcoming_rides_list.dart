import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:mobile/colors.dart';
import 'package:mobile/custom/role_tag.dart';
import 'package:mobile/fonts.dart';
import 'package:mobile/icons.dart';
import 'package:mobile/models/ride_offer.dart';
import 'package:intl/intl.dart';
import 'package:mobile/models/ride_type_model.dart';
import 'package:mobile/models/user_model.dart';
import 'package:mobile/models/vehicle_type.dart';
import 'package:mobile/utils/widget_functions.dart';

class UpcomingRidesList extends StatelessWidget {
  // final List<RideOffer> offeredRides;
  // final List<RideOffer> participatedRides;

  // const UpcomingRidesList(this.offeredRides, this.participatedRides, {Key? key})
  // : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User user = User(
        firstName: 'Yadeesha',
        lastName: 'Weerasinghe',
        gender: 'female',
        email: 'yadeesha@gmail.com',
        stars: 4.5,
        totalRatings: 250,
        vehicleType: VehicleType.car,
        VehicleNum: 'YAC9131');
    final List<RideOffer> upcomingRides = [
      RideOffer(
        id: '18328991201',
        startLocation: 'Faculty of science',
        destination: 'Thurstan College',
        offeredOn: DateTime.now(),
        rideDate: DateTime.now(),
        estimatedArrivalTime: DateTime.now().add(const Duration(minutes: 45)),
        totalDistance: 10,
        totalCharge: 1500,
      ),
      RideOffer(
        id: '18328991690',
        startLocation: 'Faculty of science',
        destination: 'Thurstan College',
        offeredOn: DateTime.now(),
        rideDate: DateTime.now(),
        estimatedArrivalTime: DateTime.now().add(const Duration(minutes: 45)),
        totalDistance: 10,
        totalCharge: 1500,
      ),
      RideOffer(
        id: '18328991690',
        startLocation: 'Faculty of science',
        destination: 'Thurstan College',
        offeredOn: DateTime.now(),
        rideDate: DateTime.now(),
        estimatedArrivalTime: DateTime.now().add(const Duration(minutes: 45)),
        totalDistance: 10,
        totalCharge: 1500,
      ),
    ];

    return ListView.builder(
        shrinkWrap: true,
        itemBuilder: (ctx, index) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            DateFormat('d MMM yyyy, h.mm a')
                                .format(upcomingRides[index].rideDate),
                            style: BlipFonts.outline.merge(
                                const TextStyle(color: BlipColors.grey))),
                        (upcomingRides[index].type == RideType.offer)
                            ? UserRoleTag.driver
                            : UserRoleTag.rider,
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
                                  DateFormat('h.mm a')
                                      .format(upcomingRides[index].rideDate),
                                  style: BlipFonts.outline),
                              Text(
                                  DateFormat('h.mm a').format(
                                      upcomingRides[index]
                                          .estimatedArrivalTime),
                                  style: BlipFonts.outline),
                            ],
                          ),
                          const SizedBox(width: 24.0),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(upcomingRides[index].startLocation,
                                  style: BlipFonts.outline),
                              Text(upcomingRides[index].destination,
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
                        Text('Trip ID - ${upcomingRides[index].id}',
                            style: BlipFonts.labelBold),
                        addVerticalSpace(16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${user.firstName} ${user.lastName}',
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
                                      user.stars.toString(),
                                      style: BlipFonts.tagline,
                                    ),
                                  ],
                                ),
                                Text(
                                  '\u2022 ${user.totalRatings} ratings',
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
                            (user.vehicleType == VehicleType.car)
                                ? const Icon(
                                    BlipIcons.car,
                                    color: BlipColors.grey,
                                    size: 24.0,
                                  )
                                : (user.vehicleType == VehicleType.van)
                                    ? const Icon(
                                        BlipIcons.car,
                                        color: BlipColors.grey,
                                        size: 24.0,
                                      )
                                    : const Icon(
                                        BlipIcons.bike,
                                        color: BlipColors.grey,
                                        size: 24.0,
                                      ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  user.VehicleNum,
                                  style: BlipFonts.labelBold,
                                ),
                                Text(
                                  '${toBeginningOfSentenceCase(user.vehicleType.name)}',
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
                                  '${upcomingRides[index].totalDistance.toString()}km',
                                  style: BlipFonts.outlineBold,
                                ),
                              ],
                            ),
                            const SizedBox(width: 16.0),
                            Text('Rs. ${upcomingRides[index].totalCharge}',
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
        },
        itemCount: upcomingRides.length);
  }
}
