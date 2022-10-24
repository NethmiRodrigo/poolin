import 'package:flutter/material.dart';
import 'package:poolin/colors.dart';
import 'package:poolin/custom/timeline.dart';
import 'package:poolin/fonts.dart';
import 'package:jiffy/jiffy.dart';
import 'package:poolin/screens/view-profile/rider_profile_screen.dart';

class ConfirmedRequestsList extends StatelessWidget {
  ConfirmedRequestsList({Key? key, required this.confirmedRequests})
      : super(key: key);
  List<dynamic> confirmedRequests;

  @override
  Widget build(BuildContext context) {
    return Timeline(
      indicators: <Widget>[
        for (var request in confirmedRequests)
          if (request['avatar'] != null)
            CircleAvatar(
              backgroundImage: NetworkImage(request['avatar']),
            )
          else
            const CircleAvatar(
              backgroundImage: AssetImage('assets/images/user.jpg'),
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
                Text(request['fname'] + " " + request['lname'],
                    style: BlipFonts.outline),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  decoration: BoxDecoration(
                    color: BlipColors.lightBlue,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    ("gets on at ${request['pickup']} at ${Jiffy(request['starttime']).format("h:mm a").split(" ").join('')}")
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
