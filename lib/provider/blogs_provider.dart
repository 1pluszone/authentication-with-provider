import 'dart:convert';

import 'package:authentication_app_with_provider/resource/models/blog_model.dart';
import 'package:authentication_app_with_provider/resource/network/check_internet.dart';
import 'package:authentication_app_with_provider/resource/network/network_calls.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

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
      blogs = await compute(parseMethod, response.body);
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
}

enum BlogStatus { loading, loaded, networkError, error }
