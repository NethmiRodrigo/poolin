import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:poolin/icons.dart';
import 'package:poolin/screens/view-ride-offers/view_offer_details_screen.dart';
import 'package:poolin/utils/widget_functions.dart';

import 'package:poolin/colors.dart';
import 'package:poolin/fonts.dart';

import 'package:poolin/models/ride_offer_search_result.dart';

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
                  builder: ((context) => const ViewRideOfferDetails()),
                ),
              );
            },
            child: Card(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.star_rounded,
                                        size: 10.0,
                                        color: BlipColors.gold,
                                      ),
                                      addHorizontalSpace(8.0),
                                      Text(
                                        offers[index]
                                            .user
                                            .starRating
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
                                        offers[index]
                                            .user
                                            .noOfRatings
                                            .toString(),
                                        style: BlipFonts.tagline,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              const Spacer(),
                              type == "view"
                                  ? SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: Checkbox(
                                        checkColor: BlipColors.black,
                                        fillColor:
                                            MaterialStateProperty.resolveWith(
                                                getColor),
                                        value: isChecked,
                                        onChanged: (bool? value) {
                                          isChecked = value!;
                                        },
                                      ),
                                    )
                                  : IconButton(
                                      icon: const Icon(
                                        EvaIcons.trash2,
                                        color: BlipColors.grey,
                                        size: 20.0,
                                      ),
                                      onPressed: () {},
                                    ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Icon(
                                Icons.directions_car_filled_rounded,
                                color: BlipColors.grey,
                              ),
                              addHorizontalSpace(5.0),
                              Text(
                                offers[index].model,
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
                )),
          );
        },
        itemCount: offers.length,
      ),
    );
  }
}
