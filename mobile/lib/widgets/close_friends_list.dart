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
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemBuilder: (ctx, index) {
        return Card(
          child: Column(
            children: [
              CircleAvatar(
                radius: 20,
                foregroundImage: NetworkImage(
                  friends[index].profilePicture,
                ),
              ),
              Text(friends[index].firstName),
            ],
          ),
        );
      },
      itemCount: friends.length,
    );
  }
}
