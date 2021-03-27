import 'dart:convert';

import 'package:authentication_app_with_provider/resource/models/token_model.dart';
import 'package:authentication_app_with_provider/resource/network/network_calls.dart';
import 'package:authentication_app_with_provider/view/blog_list_screen.dart';
import 'package:authentication_app_with_provider/view/login_screen.dart';
import 'package:flutter/material.dart';
import '../resource/cache/user_preference.dart';

class UserProvider with ChangeNotifier {
  LoggedInStatus status = LoggedInStatus.unknown;

  final _api = ApiCalls();

  void checkLoginStatus(BuildContext context) async {
    final userPref = UserPreference();

    bool loggedInStatus = await userPref.checkLoginStatus();
    if (loggedInStatus) {
      status = LoggedInStatus.loggedIn;
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => BlogListScreen()));
    } else {
      status = LoggedInStatus.loggedOut;
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    }
    // notifyListeners();
  }

  Future<void> login(
      String email, String password, BuildContext context) async {
    try {
      final response = await _api.login(email, password);
      final responseData = json.decode(response.body);
      TokenModel tokenModel = TokenModel.fromJson(responseData);
      String token = tokenModel.token;
      final userPref = UserPreference();
      userPref.saveToken(token);
      userPref.changeLoginStatus(true);
//dismiss rolling
      //move to blog list screen
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => BlogListScreen()));
    } catch (e) {
      //dismiss rolling
      print("an error occured on login $e");
      status = LoggedInStatus.loggedOut;
    }
  }

  void logout() {
    final userPref = UserPreference();
    userPref.changeLoginStatus(false);
  }
}

enum LoggedInStatus { unknown, loggedIn, loggedOut }
