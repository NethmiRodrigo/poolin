import 'package:shared_preferences/shared_preferences.dart';

Future<bool> isUserLoggedIn() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? cookie = prefs.getString('cookie');

  if (cookie == null) {
    return false;
  } else {
    return true;
  }
}
