import 'package:shared_preferences/shared_preferences.dart';

Future<bool> saveCookie(String cookie) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool result = await prefs.setString('cookie', cookie);

  return result;
}
