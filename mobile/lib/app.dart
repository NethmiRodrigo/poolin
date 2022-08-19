import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:ionicons/ionicons.dart';
import 'package:mobile/colors.dart';
import 'package:mobile/screens/home/driver_home.dart';
import 'package:mobile/screens/home/rider_home.dart';
import 'package:mobile/screens/login/login_screen.dart';
import 'package:mobile/screens/shared/ride/destination_screen.dart';
import 'package:mobile/screens/user/profile/UserProfileScreen.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late PersistentTabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(FluentIcons.home_16_filled),
        activeColorPrimary: BlipColors.orange,
        inactiveColorPrimary: BlipColors.black,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(FeatherIcons.barChart),
        activeColorPrimary: BlipColors.orange,
        inactiveColorPrimary: BlipColors.black,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Ionicons.notifications),
        activeColorPrimary: BlipColors.orange,
        inactiveColorPrimary: BlipColors.black,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(FluentIcons.person_20_filled),
        activeColorPrimary: BlipColors.orange,
        inactiveColorPrimary: BlipColors.black,
      ),
    ];
  }

  List<Widget> _buildScreens() {
    return [
      const DriverHomeScreen(),
      const RiderHomeScreen(),
      DestinationScreen(),
      const UserProfileScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: Colors.white,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        stateManagement: true,
        hideNavigationBarWhenKeyboardShows: true,
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10.0),
          colorBehindNavBar: Colors.white,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: const ItemAnimationProperties(
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation(
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle: NavBarStyle.style1,
      ),
    );
  }
}
