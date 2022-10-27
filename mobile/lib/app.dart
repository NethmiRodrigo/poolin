import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:poolin/colors.dart';
import 'package:poolin/cubits/auth_cubit.dart';
import 'package:poolin/screens/rate_users/rate_driver_screen.dart';
import 'package:poolin/screens/shared/ride/ride_history.dart';
import 'package:poolin/screens/user/profile/user_profile_screen.dart';
import 'package:poolin/services/interceptor/is_loggedin.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late PersistentTabController _controller;
  bool _hideNavBar = false;

  @override
  void initState() {
    super.initState();
    checkLoggedIn();
    _controller = PersistentTabController(initialIndex: 0);
  }

  checkLoggedIn() async {
    bool value = await isUserLoggedIn();
    if (!value) {
      setState(() {
        _hideNavBar = true;
      });
    }
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
        icon: const Icon(FluentIcons.person_20_filled),
        activeColorPrimary: BlipColors.orange,
        inactiveColorPrimary: BlipColors.black,
      ),
    ];
  }

  List<Widget> _buildScreens() {
    return [
      const RateDriverScreen(),
      const RideHistory(),
      const UserProfileScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthStateCubit, AuthState>(
      listener: (context, state) {
        if (!state.isLoggedIn) {
          setState(() {
            _hideNavBar = true;
          });
        }
      },
      builder: (context, state) => PersistentTabView(
        context,
        hideNavigationBar: _hideNavBar,
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
        navBarStyle: NavBarStyle.style6,
      ),
    );
  }
}
