import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/cubits/current_user_cubit.dart';

import 'package:mobile/custom/lists/close_friends_list.dart';
import 'package:mobile/custom/lists/ride_offer_list.dart';
import 'package:mobile/icons.dart';
import 'package:mobile/custom/toggle_to_driver.dart';
import 'package:mobile/custom/ride_countdown.dart';
import 'package:mobile/models/friend.dart';
import 'package:mobile/models/ride_offer.dart';
import 'package:mobile/models/ride_type_model.dart';
import 'package:mobile/screens/shared/ride/destination_screen.dart';
import 'package:mobile/services/auth_service.dart';
import 'package:mobile/utils/widget_functions.dart';
import 'package:mobile/fonts.dart';
import '../../colors.dart';
import '../../models/user_model.dart';

class RiderHomeScreen extends StatefulWidget {
  const RiderHomeScreen({Key? key}) : super(key: key);

  @override
  State<RiderHomeScreen> createState() => _RiderHomeScreenState();
}

class _RiderHomeScreenState extends State<RiderHomeScreen> {
  int endTime = DateTime.now().millisecondsSinceEpoch +
      const Duration(days: 1, hours: 2, minutes: 30).inMilliseconds;
  late User currentUser = User(
    firstName: '',
    lastName: '',
    email: '',
    gender: '',
  );

  final List<RideOffer> _rideOffers = [
    RideOffer(
      id: '1',
      startLocation: 'University of Colombo School of Computing',
      destination: 'Fort Railway Station',
      offeredOn: DateTime.now(),
      rideDate: DateTime.now(),
      estimatedArrivalTime: DateTime.now(),
      profilePicture: 'https://i.pravatar.cc/300?img=1',
    ),
    RideOffer(
      id: '2',
      startLocation: 'Negambo town',
      destination: 'Baththaramulla',
      offeredOn: DateTime.now().subtract(const Duration(hours: 5)),
      rideDate: DateTime.now(),
      estimatedArrivalTime: DateTime.now(),
      profilePicture: 'https://i.pravatar.cc/300?img=4',
    ),
    RideOffer(
      id: '3',
      startLocation: 'Piliyandala',
      destination: 'Nugegoda Bus stand',
      offeredOn: DateTime.now().subtract(const Duration(minutes: 15)),
      rideDate: DateTime.now(),
      estimatedArrivalTime: DateTime.now(),
      profilePicture: 'https://i.pravatar.cc/300?img=3',
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
        profilePicture: 'https://i.pravatar.cc/300?img=4'),
    Friend(
        id: '2',
        firstName: 'Induwara',
        lastName: 'Anderson',
        profilePicture: 'https://i.pravatar.cc/300?img=3'),
    Friend(
        id: '3',
        firstName: 'Sarah',
        lastName: 'Doe',
        profilePicture: 'https://i.pravatar.cc/300?img=22'),
    Friend(
        id: '4',
        firstName: 'Nethmi',
        lastName: 'Anderson',
        profilePicture: 'https://i.pravatar.cc/300?img=1'),
    Friend(
        id: '5',
        firstName: 'Azma',
        lastName: 'Doe',
        profilePicture: 'https://i.pravatar.cc/300?img=5'),
    Friend(
        id: '6',
        firstName: 'Dulaj',
        lastName: 'Anderson',
        profilePicture: 'https://i.pravatar.cc/300?img=6'),
  ];
  bool isRiding = false; //rider is riding if he currently has a ride

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
  }

  Future<void> _getCurrentUser() async {
    Response res = await getCurrentUser();
    currentUser = User.fromJson(res.data);
  }

  @override
  Widget build(BuildContext context) {
    const double padding = 16;
    final Size size = MediaQuery.of(context).size;
    const sidePadding = EdgeInsets.symmetric(horizontal: padding);

    final CurrentUserCubit currentUserCubit =
        BlocProvider.of<CurrentUserCubit>(context);

    currentUserCubit.setFirstName(currentUser.firstName);
    currentUserCubit.setLastName(currentUser.lastName);
    currentUserCubit.setEmail(currentUser.email);
    currentUserCubit.setGender(currentUser.gender);
    currentUserCubit.setStars(currentUser.stars);
    currentUserCubit.setProfilePic(currentUser.profilePicURL);
    currentUserCubit.setIsVerified(currentUser.isVerified);

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
            const Text(
              'Looking for a ride?',
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
                                    builder: (context) => DestinationScreen(rideType: RideType.request,),
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
