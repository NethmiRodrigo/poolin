import 'package:flutter/material.dart';
import 'package:poolin/colors.dart';
import 'package:poolin/custom/outline_button.dart';
import 'package:poolin/fonts.dart';
import 'package:poolin/screens/view-ride-requests/reserve_request_screen.dart';
import 'package:poolin/utils/widget_functions.dart';

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
                      CircleAvatar(
                        backgroundColor: BlipColors.lightGrey,
                        foregroundImage: NetworkImage(pendingRequests[index]
                                ['avatar'] ??
                            'https://i.ibb.co/qgVMXFS/profile-icon-9.png'),
                      ),
                      Text(
                        pendingRequests[index]['fname'],
                        style: Theme.of(context).textTheme.labelLarge!.merge(
                              const TextStyle(color: Colors.white),
                            ),
                      ),
                      Text(
                        '+ Rs. ${pendingRequests[index]['price']} ',
                        style: BlipFonts.labelBold.merge(
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
