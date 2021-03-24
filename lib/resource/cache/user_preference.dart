import 'package:shared_preferences/shared_preferences.dart';

class UserPreference {
  static const checkLoginString = "loggedInstatus";

  Future<bool> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    bool loggedInstatus = prefs.getBool(checkLoginString) ?? false;

    return loggedInstatus;
  }

  changeLoginStatus(bool newValue) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(checkLoginString, newValue);
  }
}
