import 'package:flutter/material.dart';
import 'package:mobile/colors.dart';
import 'package:mobile/custom/outline_button.dart';
import 'package:mobile/screens/view-ride-requests/reserve_request_screen.dart';
import 'package:mobile/utils/widget_functions.dart';

class RideRequestsList extends StatelessWidget {
  RideRequestsList({Key? key, required this.pendingRequests}) : super(key: key);
  List<dynamic> pendingRequests;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: pendingRequests.length,
      itemBuilder: (context, index) {
        return Row(
          children: [
            Container(
              width: 257,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              decoration: const BoxDecoration(
                color: BlipColors.orange,
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      if (pendingRequests[index]['avatar'] != null)
                        CircleAvatar(
                          backgroundImage:
                              NetworkImage(pendingRequests[index]['avatar']),
                        ),
                      if (pendingRequests[index]['avatar'] == null)
                        const CircleAvatar(
                          backgroundImage: AssetImage('assets/images/user.jpg'),
                        ),
                      Text(
                        pendingRequests[index]['fname'],
                        style: Theme.of(context).textTheme.labelLarge!.merge(
                              const TextStyle(color: Colors.white),
                            ),
                      ),
                      Text(
                        '+ Rs. ${pendingRequests[index]['price']} ',
                        style: Theme.of(context).textTheme.headlineLarge!.merge(
                              const TextStyle(color: Colors.white),
                            ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      OutlineButton(
                          onPressedAction: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ReserveRequestScreen(
                                  request: pendingRequests[index],
                                ),
                              ),
                            );
                          },
                          text: "View Request",
                          color: BlipColors.white),
                    ],
                  ),
                ],
              ),
            ),
            addHorizontalSpace(16),
          ],
        );
      },
    );
  }
}
