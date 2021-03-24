import 'package:flutter/material.dart';
import '../resource/cache/user_preference.dart';

class UserProvider with ChangeNotifier {
  LoggedInStatus status = LoggedInStatus.unknown;
  void checkLoginStatus() async {
    final userPref = UserPreference();

    bool loggedInStatus = await userPref.checkLoginStatus();
    if (loggedInStatus) {
      status = LoggedInStatus.loggedIn;
      notifyListeners();
    } else {
      status = LoggedInStatus.loggedOut;
      notifyListeners();
    }
  }
}

enum LoggedInStatus { unknown, loggedIn, loggedOut }
