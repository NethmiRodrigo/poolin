import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:poolin/cubits/active_ride_cubit.dart';
import 'package:poolin/cubits/auth_cubit.dart';
import 'package:poolin/cubits/current_user_cubit.dart';
import 'package:poolin/cubits/matching_rides_cubit.dart';

import 'package:poolin/cubits/ride_offer_cubit.dart';
import 'package:poolin/cubits/ride_request_cubit.dart';
import 'package:poolin/splash.dart';
import 'package:poolin/theme.dart';

import 'package:onesignal_flutter/onesignal_flutter.dart';

Future<void> main() async {
  await dotenv.load();
  if (defaultTargetPlatform == TargetPlatform.android) {
    AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
  }
  //Remove this method to stop OneSignal Debugging
  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

  OneSignal.shared.setAppId(dotenv.env['ONE_SIGNAL_APP_ID']!);

// The promptForPushNotificationsWithUserResponse function will show the iOS or Android push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
  OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
    print("Accepted permission: $accepted");
  });

  OneSignal.shared.setNotificationWillShowInForegroundHandler(
      (OSNotificationReceivedEvent event) {
    // Will be called whenever a notification is received in foreground
    // Display Notification, pass null param for not displaying the notification
    event.complete(event.notification);
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RideOfferCubit>(
          create: (context) => RideOfferCubit(),
        ),
        BlocProvider<ActiveRideCubit>(
          create: (context) => ActiveRideCubit(),
        ),
        BlocProvider<RideRequestCubit>(
          create: (context) => RideRequestCubit(),
        ),
        BlocProvider<CurrentUserCubit>(
          create: (context) => CurrentUserCubit(),
        ),
        BlocProvider<MatchingOffersCubit>(
          create: (context) => MatchingOffersCubit(),
        ),
        BlocProvider<AuthStateCubit>(
          create: (context) => AuthStateCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'Poolin',
        theme: AppTheme().themeData,
        home: const SplashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
