import 'package:flutter/material.dart';
import 'package:mobile/colors.dart';
import 'package:mobile/custom/timeline.dart';
import 'package:mobile/fonts.dart';
import 'package:jiffy/jiffy.dart';
import 'package:mobile/screens/view-profile/rider_profile_screen.dart';

class ConfirmedRequestsList extends StatelessWidget {
  ConfirmedRequestsList({Key? key, required this.confirmedRequests})
      : super(key: key);
  List<dynamic> confirmedRequests;

  @override
  Widget build(BuildContext context) {
    return Timeline(
      indicators: <Widget>[
        for (var request in confirmedRequests)
          CircleAvatar(
            backgroundColor: BlipColors.lightGrey,
            foregroundImage: NetworkImage(request['avatar'] ??
                'https://i.ibb.co/qgVMXFS/profile-icon-9.png'),
          )
      ],
      children: <Widget>[
        for (var request in confirmedRequests)
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      RiderProfileScreen(id: request["user_id"]),
                ),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(request['firstname'] + " " + request['lastname'],
                    style: BlipFonts.outline),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  decoration: BoxDecoration(
                    color: BlipColors.lightBlue,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    ("gets on at ${request['pickup']['name']} at ${Jiffy(request['pickupTime']).format("h:mm a").split(" ").join('')}")
                        .toUpperCase(),
                    style: BlipFonts.taglineBold
                        .merge(const TextStyle(color: BlipColors.blue)),
                  ),
                ),
              ],
            ),
          ),
        //
      ],
    );
  }
}
