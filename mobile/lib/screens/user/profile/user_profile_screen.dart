import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poolin/colors.dart';
import 'package:poolin/cubits/active_ride_cubit.dart';
import 'package:poolin/cubits/auth_cubit.dart';
import 'package:poolin/cubits/current_user_cubit.dart';
import 'package:poolin/models/user_model.dart';
import 'package:poolin/screens/login/login_screen.dart';
import 'package:poolin/screens/user/update-profile/edit_profile_screen.dart';
import 'package:poolin/services/auth_service.dart';
import 'package:poolin/utils/widget_functions.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  UserProfileScreenState createState() {
    return UserProfileScreenState();
  }
}

class UserProfileScreenState extends State<UserProfileScreen> {
  late CurrentUserCubit userCubit;
  bool isLoading = true;

  @override
  void initState() {
    userCubit = BlocProvider.of<CurrentUserCubit>(context);
    getUserDetails();
    super.initState();
  }

  getUserDetails() async {
    Response response = await getCurrentUser();
    User loggedInUser = User.fromJson(response.data);
    userCubit.setUser(
      loggedInUser.id,
      loggedInUser.firstName,
      loggedInUser.lastName,
      loggedInUser.gender,
      loggedInUser.email.toString(),
    );
    setState(() {
      isLoading = false;
    });
  }

  //build buttons
  Widget buildButton({
    required String title,
    required IconData icon,
    required IconData icon2,
    required VoidCallback onClicked,
  }) =>
      TextButton(
        style: ElevatedButton.styleFrom(
          // foregroundColor: BlipColors.black,
          // backgroundColor: BlipColors.white,
          padding: const EdgeInsets.all(16.0),
        ),
        onPressed: onClicked,
        child: Row(children: [
          Icon(
            icon,
            size: 24,
          ),
          const SizedBox(width: 12),
          Text(title),
          const Spacer(),
          Icon(
            icon2,
            size: 16,
          ),
        ]),
      );

  @override
  Widget build(BuildContext context) {
    CurrentUserCubit currentUser = BlocProvider.of<CurrentUserCubit>(context);
    ActiveRideCubit activeRideCubit = BlocProvider.of<ActiveRideCubit>(context);
    final Size size = MediaQuery.of(context).size;
    const double padding = 16;
    const sidePadding = EdgeInsets.symmetric(horizontal: padding);
    AuthStateCubit authState = BlocProvider.of<AuthStateCubit>(context);
    return Scaffold(
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: BlipColors.orange,
              ),
            )
          : SizedBox(
              width: size.width,
              height: size.height,
              child: Padding(
                padding: sidePadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    addVerticalSpace(48),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Profile',
                          style: Theme.of(context).textTheme.headline3!.merge(
                              const TextStyle(
                                  color: Colors.black, fontSize: 24)),
                        ),
                      ],
                    ),
                    addVerticalSpace(24),
                    Container(
                      alignment: Alignment.center,
                      child: SizedBox(
                        height: 115,
                        width: 115,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            currentUser.getUser().profilePicURL != null
                                ? CircleAvatar(
                                    backgroundColor: BlipColors.lightGrey,
                                    backgroundImage: NetworkImage(
                                        currentUser.getUser().profilePicURL!),
                                  )
                                : const CircleAvatar(
                                    backgroundColor: BlipColors.lightGrey,
                                    backgroundImage: NetworkImage(
                                        "https://zaytandzaatar.com.au/wp-content/uploads/2022/08/Deafult-Profile-Pitcher.png.webp"),
                                  ),
                            Positioned(
                              bottom: 0,
                              right: -10,
                              child: SizedBox(
                                height: 46,
                                width: 46,
                                child: TextButton(
                                  onPressed: () {},
                                  child: Image.asset(
                                      "assets/images/iconverified.png"),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    addVerticalSpace(4),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        "${currentUser.state.firstName} ${currentUser.state.lastName}",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .merge(const TextStyle(color: Colors.black)),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    addVerticalSpace(24),
                    buildButton(
                        title: 'My Details',
                        icon: FontAwesomeIcons.user,
                        onClicked: () => {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const EditProfileScreen()),
                              )
                            },
                        icon2: Icons.arrow_forward_ios),
                    addVerticalSpace(16),
                    buildButton(
                        title: 'Close Friends',
                        icon: FontAwesomeIcons.userGroup,
                        onClicked: () => {},
                        icon2: Icons.arrow_forward_ios),
                    addVerticalSpace(16),
                    buildButton(
                        title: 'Friend Requests',
                        icon: FontAwesomeIcons.userPlus,
                        onClicked: () => {},
                        icon2: Icons.arrow_forward_ios),
                    addVerticalSpace(16),
                    buildButton(
                        title: 'Vehicle Information',
                        icon: FontAwesomeIcons.car,
                        onClicked: () => {},
                        icon2: Icons.arrow_forward_ios),
                    addVerticalSpace(16),
                    buildButton(
                        title: 'Ride Visibility',
                        icon: FontAwesomeIcons.magnifyingGlassLocation,
                        onClicked: () => {},
                        icon2: Icons.arrow_forward_ios),
                    addVerticalSpace(16),
                    buildButton(
                        title: 'Log Out',
                        icon: FontAwesomeIcons.arrowRightFromBracket,
                        onClicked: () {
                          logout();
                          authState.setLoggedIn(false);
                          activeRideCubit.reset();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ));
                        },
                        icon2: Icons.arrow_forward_ios),
                  ],
                ),
              ),
            ),
    );
  }
}
