import 'dart:convert';

import 'package:authentication_app_with_provider/resource/models/blog_model.dart';
import 'package:authentication_app_with_provider/resource/network/check_internet.dart';
import 'package:authentication_app_with_provider/resource/network/network_calls.dart';
import 'package:flutter/cupertino.dart';

import 'blogs_provider.dart';

class EachBlogProvider with ChangeNotifier {
  BlogModel blog;

  BlogStatus blogStatus = BlogStatus.loading;

  final _api = ApiCalls();

  Future<void> loadABlog(String id) async {
    if (!await CheckInternet.checkInternet()) {
      blogStatus = BlogStatus.networkError;
      notifyListeners();
      return;
    }
    try {
      blogStatus = BlogStatus.loading;
      notifyListeners();

      final response = await _api.loadABlog(id);
      final responseData = json.decode(response.body);
      print(responseData);

      blog = BlogModel.fromJson(responseData);
      blogStatus = BlogStatus.loaded;
      notifyListeners();
    } catch (e) {
      print("an error occured $e");
      blogStatus = BlogStatus.error;
      notifyListeners();
    }
  }
}
