import 'package:flutter/material.dart';
import 'package:time_elapsed/time_elapsed.dart';

import 'package:mobile/models/ride_request.dart';
import 'package:mobile/icons.dart';
import 'package:mobile/colors.dart';
import 'package:mobile/fonts.dart';

class RideRequestList extends StatelessWidget {
  final List<RideRequest> requests;

  const RideRequestList(this.requests, {Key? key}) : super(key: key);

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
              foregroundImage: NetworkImage(
                requests[index].profilePicture,
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
                        requests[index].pickupLocation,
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
                        requests[index].dropoffLocation,
                        overflow: TextOverflow.ellipsis,
                        style: BlipFonts.outline,
                      ),
                    ),
                  ],
                )
              ],
            ),
            trailing: Text(
              TimeElapsed.fromDateTime(requests[index].requestedOn),
              style: BlipFonts.outline,
            ),
          ),
        );
      },
      itemCount: requests.length,
    );
  }
}
