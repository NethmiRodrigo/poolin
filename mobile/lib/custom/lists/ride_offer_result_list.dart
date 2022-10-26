import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poolin/cubits/matching_rides_cubit.dart';
import 'package:poolin/cubits/ride_request_cubit.dart';
import 'package:poolin/icons.dart';
import 'package:poolin/models/vehicle_type.dart';
import 'package:poolin/screens/view-ride-offers/view_offer_details_screen.dart';
import 'package:poolin/utils/widget_functions.dart';

import 'package:poolin/colors.dart';
import 'package:poolin/fonts.dart';

class RideOfferResultList extends StatelessWidget {
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

  const RideOfferResultList(this.type, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RideRequestCubit reqCubit =
        BlocProvider.of<RideRequestCubit>(context);
    final MatchingOffersCubit matchingOffersCubit =
        BlocProvider.of<MatchingOffersCubit>(context);

    return Scrollbar(
      thumbVisibility: true,
      child: ListView.builder(
        itemBuilder: (ctx, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((context) => ViewRideOfferDetails(index)),
                ),
              );
            },
            child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: (reqCubit.state.offerIDs
                          .contains(matchingOffersCubit.state.offers[index].id))
                      ? const BorderSide(
                          color: BlipColors.orange,
                          width: 1.0,
                        )
                      : const BorderSide(
                          color: BlipColors.white,
                          width: 1.0,
                        ),
                ),
                color: (reqCubit.state.offerIDs
                        .contains(matchingOffersCubit.state.offers[index].id))
                    ? BlipColors.lightGrey
                    : BlipColors.white,
                elevation: (reqCubit.state.offerIDs
                        .contains(matchingOffersCubit.state.offers[index].id))
                    ? 0
                    : 3,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: BlipColors.lightGrey,
                            foregroundImage: NetworkImage(
                              matchingOffersCubit
                                  .state.offers[index].driver.profilePicURL,
                            ),
                          ),
                          addHorizontalSpace(5.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${matchingOffersCubit.state.offers[index].driver.firstName} ${matchingOffersCubit.state.offers[index].driver.lastName}',
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
                                    matchingOffersCubit
                                        .state.offers[index].driver.stars
                                        .toString(),
                                    style: BlipFonts.tagline,
                                  ),
                                  addHorizontalSpace(8.0),
                                  const Icon(
                                    Icons.circle,
                                    size: 4.0,
                                  ),
                                  addHorizontalSpace(8.0),
                                  Text(
                                    matchingOffersCubit
                                        .state.offers[index].driver.totalRatings
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
                          (matchingOffersCubit
                                      .state.offers[index].driver.vehicleType ==
                                  VehicleType.bike)
                              ? const Icon(
                                  BlipIcons.bike,
                                  color: BlipColors.grey,
                                  size: 24.0,
                                )
                              : (matchingOffersCubit.state.offers[index].driver
                                          .vehicleType ==
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
                            matchingOffersCubit
                                .state.offers[index].driver.vehicleModel,
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
                            "Rs. ${matchingOffersCubit.state.offers[index].pricePerKM} Per KM",
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
        itemCount: matchingOffersCubit.state.offers.length,
      ),
    );
  }
}
