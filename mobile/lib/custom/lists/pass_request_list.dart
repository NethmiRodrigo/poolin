import 'package:flutter/material.dart';
import 'package:time_elapsed/time_elapsed.dart';

import 'package:mobile/fonts.dart';
import 'package:mobile/models/passenger_request.dart';

class PassengerRequestList extends StatelessWidget {
  final List<PassengerRequest> requests;

  const PassengerRequestList(this.requests, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            title: Text(
              requests[index].rider,
              style: BlipFonts.label,
            ),
            subtitle: const Text(
              'has requested to join you',
              style: BlipFonts.label,
            ),
            trailing: Text(
              TimeElapsed.fromDateTime(requests[index].date),
              style: BlipFonts.outline,
            ),
          ),
        );
      },
      itemCount: requests.length,
    );
  }
}
