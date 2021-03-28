import 'package:shared_preferences/shared_preferences.dart';

class UserPreference {
  static const checkLoginString = "loggedInstatus";
  static const tokenString = "token";

  static UserPreference instance;
  SharedPreferences preferences;

  UserPreference({this.preferences});

  static Future<UserPreference> getInstance() async {
    if (instance != null) {
      return instance;
    } else {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      return UserPreference(preferences: preferences);
    }
  }

  bool checkLoginStatus() {
    return preferences.getBool(checkLoginString) ?? false;
  }

  void changeLoginStatus(bool newValue) {
    preferences.setBool(checkLoginString, newValue);
  }

  String getSavedToken() {
    return preferences.getString(tokenString);
  }

  void saveToken(String token) {
    preferences.setString(tokenString, token);
  }

  void clearAll() {
    preferences.clear();
  }
}
