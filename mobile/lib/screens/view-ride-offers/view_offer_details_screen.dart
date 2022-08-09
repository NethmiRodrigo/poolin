import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobile/colors.dart';
import 'package:mobile/fonts.dart';
import 'package:mobile/screens/view-ride-offers/timeline.dart';
import 'package:mobile/screens/view-ride-offers/user_card.dart';

class ViewRideOfferDetails extends StatefulWidget {
  const ViewRideOfferDetails({Key? key}) : super(key: key);

  @override
  State<ViewRideOfferDetails> createState() => _ViewRideOfferDetailsState();
}

class _ViewRideOfferDetailsState extends State<ViewRideOfferDetails> {
  static const LatLng _center = LatLng(6.9271, 79.8612);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const CircleAvatar(
            backgroundColor: BlipColors.white,
            child: Icon(Icons.arrow_back, color: BlipColors.black),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: [
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return SizedBox(
                height: constraints.maxHeight / 2,
                child: const GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: _center,
                    zoom: 12.0,
                  ),
                  mapType: MapType.normal,
                ),
              );
            },
          ),
          DraggableScrollableSheet(
            initialChildSize: 1 / 2,
            minChildSize: 1 / 2,
            maxChildSize: 1 / 2,
            builder: (context, scrollController) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                child: Column(
                  children: [
                    const UserCard(),
                    const Divider(
                      color: BlipColors.grey,
                      indent: 8.0,
                      endIndent: 8.0,
                    ),
                    const Expanded(child: RideOfferTimeline()),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 10.0),
                      child: Row(
                        children: [
                          const Text(
                            "Rs. 350.00",
                            style: BlipFonts.title,
                          ),
                          const Spacer(
                            flex: 1,
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(BlipColors.black),
                            ),
                            child: Text(
                              "Select Ride",
                              style: BlipFonts.label.merge(
                                const TextStyle(color: BlipColors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
