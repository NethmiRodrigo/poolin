import 'package:flutter/material.dart';
import 'package:mobile/models/friend.dart';
import 'package:mobile/models/ride_offer.dart';
import 'package:mobile/models/ride_request.dart';
import 'package:time_elapsed/time_elapsed.dart';

import 'package:mobile/fonts.dart';

class CloseFriendsList extends StatelessWidget {
  final List<Friend> friends;

  const CloseFriendsList(this.friends, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    const double padding = 16;

    return SizedBox(
      height: size.height * 0.12,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (ctx, index) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 25,
                  foregroundImage: NetworkImage(
                    friends[index].profilePicture,
                  ),
                ),
                const SizedBox(height: 8),
                Text(friends[index].firstName, style: BlipFonts.outlineBold,),
              ],
            ),
          );
        },
        itemCount: friends.length,
      ),
    );
  }
}
