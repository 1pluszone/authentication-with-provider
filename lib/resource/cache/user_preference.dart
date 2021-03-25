import 'package:shared_preferences/shared_preferences.dart';

class UserPreference {
  static const checkLoginString = "loggedInstatus";
  static const tokenString = "token";

  Future<bool> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    bool loggedInstatus = prefs.getBool(checkLoginString) ?? false;

    return loggedInstatus;
  }

  Future<void> changeLoginStatus(bool newValue) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(checkLoginString, newValue);
  }

  Future<String> getSavedToken() async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString(tokenString);

    return token;
  }

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(tokenString, token);
  }
}
