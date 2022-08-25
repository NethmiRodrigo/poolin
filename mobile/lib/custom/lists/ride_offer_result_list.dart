import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:mobile/icons.dart';
import 'package:mobile/models/vehicle_type.dart';
import 'package:mobile/screens/view-ride-offers/view_offer_details_screen.dart';
import 'package:mobile/utils/widget_functions.dart';

import 'package:mobile/colors.dart';
import 'package:mobile/fonts.dart';

import 'package:mobile/models/ride_offer_search_result.dart';

class RideOfferResultList extends StatelessWidget {
  bool isChecked = false;
  final List<RideOfferSearchResult> offers;
  final String type;

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.black;
    }
    return Colors.black;
  }

  RideOfferResultList(this.offers, this.type, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      thumbVisibility: true,
      child: ListView.builder(
        itemBuilder: (ctx, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((context) => ViewRideOfferDetails(offers[index])),
                ),
              );
            },
            child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            foregroundImage: NetworkImage(
                              offers[index].driver.profilePicURL,
                            ),
                          ),
                          addHorizontalSpace(5.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${offers[index].driver.firstName} ${offers[index].driver.lastName}',
                                style: BlipFonts.outline,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.star_rounded,
                                    size: 10.0,
                                    color: BlipColors.gold,
                                  ),
                                  addHorizontalSpace(8.0),
                                  Text(
                                    offers[index].driver.stars.toString(),
                                    style: BlipFonts.tagline,
                                  ),
                                  addHorizontalSpace(8.0),
                                  const Icon(
                                    Icons.circle,
                                    size: 4.0,
                                  ),
                                  addHorizontalSpace(8.0),
                                  Text(
                                    offers[index]
                                        .driver
                                        .totalRatings
                                        .toString(),
                                    style: BlipFonts.tagline,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          (offers[index].driver.vehicleType == VehicleType.bike)
                              ? const Icon(
                                  BlipIcons.bike,
                                  color: BlipColors.grey,
                                  size: 24.0,
                                )
                              : (offers[index].driver.vehicleType ==
                                      VehicleType.van)
                                  ? const Icon(
                                      BlipIcons.car,
                                      color: BlipColors.grey,
                                      size: 24.0,
                                    )
                                  : const Icon(
                                      BlipIcons.car,
                                      color: BlipColors.grey,
                                      size: 15.0,
                                    ),
                          addHorizontalSpace(10.0),
                          Text(
                            offers[index].driver.vehicleModel,
                            style: BlipFonts.outline.merge(
                              const TextStyle(color: BlipColors.grey),
                            ),
                          )
                        ],
                      ),
                      addVerticalSpace(8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Rs. ${offers[index].pricePerKM}",
                            style: BlipFonts.labelBold,
                          ),
                          addHorizontalSpace(8.0),
                          const Icon(Icons.chevron_right_rounded)
                        ],
                      )
                    ],
                  ),
                )),
          );
        },
        itemCount: offers.length,
      ),
    );
  }
}
