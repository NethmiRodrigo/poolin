import 'package:flutter/material.dart';
import 'package:mobile/colors.dart';
import 'package:mobile/fonts.dart';
import 'package:mobile/models/user_model.dart';
import 'package:mobile/screens/view-profile/driver_profile_screen.dart';
import 'package:mobile/utils/widget_functions.dart';

class UserCard extends StatelessWidget {
  final User driver;
  const UserCard(this.driver, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: BlipColors.lightGrey,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: BlipColors.lightGrey),
        borderRadius: BorderRadius.circular(15.0),
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
                      radius: 30,
                      foregroundImage: NetworkImage(
                        driver.profilePicURL,
                      ),
                    ),
                    addHorizontalSpace(8.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "${driver.firstName} ${driver.lastName}",
                          style: BlipFonts.label,
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
                            Text(driver.stars.toString(), style: BlipFonts.tagline),
                            addHorizontalSpace(8.0),
                            const Icon(
                              Icons.circle,
                              size: 4.0,
                              color: BlipColors.grey,
                            ),
                            addHorizontalSpace(8.0),
                            Text(
                              "${driver.totalRatings} Ratings",
                              style: BlipFonts.tagline,
                            )
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.directions_car_filled_rounded,
                              color: BlipColors.grey,
                            ),
                            addHorizontalSpace(5.0),
                            Text(driver.vehicleModel,
                                style: BlipFonts.outline),
                            addHorizontalSpace(70.0),
                            IconButton(
                              alignment: Alignment.centerRight,
                              icon: const Icon(
                                Icons.chevron_right,
                                color: BlipColors.grey,
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const DriverProfileScreen()),
                                );
                              },
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   children: [
                //     IconButton(
                //       icon: Icon(
                //         Icons.chevron_right,
                //         color: BlipColors.grey,
                //       ),
                //       onPressed: () {},
                //     )
                //   ],
                // )
              ],
            )
          ],
        ),
      ),
    );
  }
}
