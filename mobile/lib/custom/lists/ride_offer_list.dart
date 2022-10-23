import 'package:flutter/material.dart';
import 'package:time_elapsed/time_elapsed.dart';

import 'package:poolin/models/ride_offer.dart';
import 'package:poolin/icons.dart';
import 'package:poolin/colors.dart';
import 'package:poolin/fonts.dart';

class RideOfferList extends StatelessWidget {
  final List<RideOffer> offers;

  const RideOfferList(this.offers, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return ListView.builder(
      itemBuilder: (ctx, index) {
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: ListTile(
            onTap: () {},
            leading: CircleAvatar(
              radius: 20,
              backgroundColor: BlipColors.lightGrey,
              foregroundImage: NetworkImage(
                offers[index].profilePicture,
              ),
            ),
            title: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    const Icon(
                      BlipIcons.source,
                      size: 15,
                      color: BlipColors.black,
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: size.width * 0.45,
                      child: Text(
                        offers[index].startLocation,
                        overflow: TextOverflow.ellipsis,
                        style: BlipFonts.outline,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(
                      BlipIcons.destination,
                      size: 15,
                      color: BlipColors.black,
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: size.width * 0.45,
                      child: Text(
                        offers[index].destination,
                        overflow: TextOverflow.ellipsis,
                        style: BlipFonts.outline,
                      ),
                    ),
                  ],
                )
              ],
            ),
            trailing: Text(
              TimeElapsed.fromDateTime(offers[index].offeredOn),
              style: BlipFonts.outline,
            ),
          ),
        );
      },
      itemCount: offers.length,
    );
  }
}
