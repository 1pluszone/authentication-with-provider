import 'dart:convert';

import 'package:authentication_app_with_provider/resource/models/blog_model.dart';
import 'package:authentication_app_with_provider/resource/network/check_internet.dart';
import 'package:authentication_app_with_provider/resource/network/network_calls.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BlogsProvider with ChangeNotifier {
  BlogStatus blogStatus = BlogStatus.loading;
  List<BlogModel> blogs = [];

  final _api = ApiCalls();

  Future<void> loadAllBlogs() async {
    if (!await CheckInternet.checkInternet()) {
      blogStatus = BlogStatus.networkError;
      notifyListeners();
      return;
    }

    try {
      final response = await _api.loadAllBlogs();

      final Iterable responseData = json.decode(response.body);
      print(responseData);
      blogs = responseData
          .map<BlogModel>((blog) => BlogModel.fromJson(blog))
          .toList();
      //blogs = await compute(parseMethod, response.body);
      blogStatus = BlogStatus.loaded;
      notifyListeners();
    } catch (e) {
      print("an error occured $e");
      blogStatus = BlogStatus.error;
      notifyListeners();
    }
  }

  List<BlogModel> parseMethod(String responseBody) {
    final Iterable responseData = json.decode(responseBody);
    print(responseData);
    return responseData
        .map<BlogModel>((blog) => BlogModel.fromJson(blog))
        .toList();
  }

  Future<bool> onBackPressed(BuildContext context) {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit an App'),
            actions: <Widget>[
              new GestureDetector(
                onTap: () => Navigator.of(context).pop(false),
                child: Text("NO"),
              ),
              SizedBox(height: 16),
              new GestureDetector(
                onTap: () => SystemChannels.platform
                    .invokeListMethod("SystemNavigator.pop"), //for android
                child: Text("YES"),
              ),
            ],
          ),
        ) ??
        false;
  }
}

enum BlogStatus { loading, loaded, networkError, error }
