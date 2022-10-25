import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poolin/cubits/active_ride_cubit.dart';
import 'package:poolin/custom/lists/close_friends_list.dart';
import 'package:poolin/custom/lists/ride_offer_list.dart';
import 'package:poolin/icons.dart';
import 'package:poolin/custom/toggle_to_driver.dart';
import 'package:poolin/custom/ride_countdown.dart';
import 'package:poolin/models/friend.dart';
import 'package:poolin/models/ride_offer.dart';
import 'package:poolin/models/ride_type_model.dart';
import 'package:poolin/screens/shared/ride/destination_screen.dart';
import 'package:poolin/utils/widget_functions.dart';
import 'package:poolin/fonts.dart';
import '../../colors.dart';

class RiderHomeScreen extends StatefulWidget {
  const RiderHomeScreen({Key? key}) : super(key: key);

  @override
  State<RiderHomeScreen> createState() => _RiderHomeScreenState();
}

class _RiderHomeScreenState extends State<RiderHomeScreen> {
  int endTime = DateTime.now().millisecondsSinceEpoch +
      const Duration(days: 1, hours: 2, minutes: 30).inMilliseconds;
  late ActiveRideCubit activeRideCubit;

  final List<RideOffer> _rideOffers = [
    RideOffer(
      id: '1',
      startLocation: 'University of Colombo School of Computing',
      destination: 'Fort Railway Station',
      offeredOn: DateTime.now(),
      rideDate: DateTime.now(),
      estimatedArrivalTime: DateTime.now(),
      profilePicture: 'https://i.ibb.co/qgVMXFS/profile-icon-9.png',
    ),
    RideOffer(
      id: '2',
      startLocation: 'Negambo town',
      destination: 'Baththaramulla',
      offeredOn: DateTime.now().subtract(const Duration(hours: 5)),
      rideDate: DateTime.now(),
      estimatedArrivalTime: DateTime.now(),
      profilePicture: 'https://i.ibb.co/qgVMXFS/profile-icon-9.png',
    ),
    RideOffer(
      id: '3',
      startLocation: 'Piliyandala',
      destination: 'Nugegoda Bus stand',
      offeredOn: DateTime.now().subtract(const Duration(minutes: 15)),
      rideDate: DateTime.now(),
      estimatedArrivalTime: DateTime.now(),
      profilePicture: 'https://i.ibb.co/qgVMXFS/profile-icon-9.png',
    ),
    RideOffer(
      id: '4',
      startLocation: 'Negambo town',
      destination: 'Baththaramulla',
      offeredOn: DateTime.now().subtract(const Duration(minutes: 15)),
      rideDate: DateTime.now(),
      estimatedArrivalTime: DateTime.now(),
    ),
  ];
  final List<Friend> _friends = [
    Friend(
        id: '1',
        firstName: 'Dulaj',
        lastName: 'Doe',
        profilePicture: 'https://i.ibb.co/qgVMXFS/profile-icon-9.png'),
    Friend(
        id: '2',
        firstName: 'Induwara',
        lastName: 'Anderson',
        profilePicture: 'https://i.ibb.co/qgVMXFS/profile-icon-9.png'),
    Friend(
        id: '3',
        firstName: 'Sarah',
        lastName: 'Doe',
        profilePicture: 'https://i.ibb.co/qgVMXFS/profile-icon-9.png'),
    Friend(
        id: '4',
        firstName: 'Nethmi',
        lastName: 'Anderson',
        profilePicture: 'https://i.ibb.co/qgVMXFS/profile-icon-9.png'),
  ];
  bool isRiding = false; //rider is riding if he currently has a ride

  @override
  void initState() {
    super.initState();
    activeRideCubit = BlocProvider.of<ActiveRideCubit>(context);
    checkForScheduledRideReq();
  }

  void checkForScheduledRideReq() {
    if (activeRideCubit.state.id != null && activeRideCubit.state.type == RideType.request) {
      setState(() {
        isRiding = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    const double padding = 16;
    final Size size = MediaQuery.of(context).size;
    const sidePadding = EdgeInsets.symmetric(horizontal: padding);

    return Scaffold(
      body: SingleChildScrollView(
        padding: sidePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            addVerticalSpace(48),
            const Align(
              alignment: Alignment.topRight,
              child: ToggleToDriver(true),
            ),
            addVerticalSpace(16),
            Text(
              isRiding ? 'A ride is scheduled for you' : 'Looking for a ride?',
              style: BlipFonts.title,
            ),
            addVerticalSpace(16),
            isRiding
                ? RideCountDown(endTime)
                : Container(
                    width: size.width,
                    padding: const EdgeInsets.all(0),
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: BlipColors.orange,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 16,
                            bottom: 16,
                            left: 16,
                          ),
                          child: SizedBox(
                            width: size.width * 0.7,
                            child: Text(
                              'See who else is travelling your way',
                              style: BlipFonts.labelBold.merge(
                                  const TextStyle(color: BlipColors.white)),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomRight,
                          child: IconButton(
                            icon: const Icon(
                              BlipIcons.arrowRight,
                              size: 20,
                              color: BlipColors.white,
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DestinationScreen(
                                      rideType: RideType.request,
                                    ),
                                  ));
                            },
                          ),
                        )
                      ],
                    ),
                  ),
            addVerticalSpace(24),
            const Text(
              'Find out where your friends are headed',
              style: BlipFonts.title,
            ),
            addVerticalSpace(8),
            CloseFriendsList(_friends),
            addVerticalSpace(16),
            const Text(
              'Ride offers',
              style: BlipFonts.title,
            ),
            SizedBox(
              height: size.height * 0.4,
              child: RideOfferList(_rideOffers),
            ),
          ],
        ),
      ),
    );
  }
}
