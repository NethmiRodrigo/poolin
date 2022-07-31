import 'package:flutter/material.dart';
import 'package:mobile/colors.dart';
import 'package:mobile/fonts.dart';
import 'package:mobile/utils/widget_functions.dart';

class UserCard extends StatelessWidget {
  const UserCard({Key? key}) : super(key: key);

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
                    const CircleAvatar(
                      radius: 30,
                      foregroundImage: NetworkImage(
                        'https://i.pravatar.cc/300',
                      ),
                    ),
                    addHorizontalSpace(8.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          "Yadeesha Weerasinghe",
                          style: BlipFonts.label,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.star_rounded,
                              size: 10.0,
                              color: BlipColors.grey,
                            ),
                            addHorizontalSpace(8.0),
                            const Text("5.0", style: BlipFonts.tagline),
                            addHorizontalSpace(8.0),
                            const Icon(
                              Icons.circle,
                              size: 4.0,
                              color: BlipColors.grey,
                            ),
                            addHorizontalSpace(8.0),
                            const Text(
                              "25 Ratings",
                              style: BlipFonts.tagline,
                            )
                          ],
                        ),
                      ],
                    ),
                    const Spacer(),
                    Column(
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.directions_car_filled_rounded,
                              color: BlipColors.grey,
                            ),
                            addHorizontalSpace(5.0),
                            const Text("Nissan Sedan", style: BlipFonts.outline)
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Icon(
                      Icons.chevron_right,
                      color: BlipColors.grey,
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
