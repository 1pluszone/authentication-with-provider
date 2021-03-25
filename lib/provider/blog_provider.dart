import 'package:authentication_app_with_provider/resource/network/network_calls.dart';
import 'package:flutter/cupertino.dart';

class BlogProvider with ChangeNotifier {
  BlogStatus blogStatus = BlogStatus.loading;

  final _api = ApiCalls();

  Future<void> loadAllBlogs() async {
    try {
      final response = await _api.loadAllBlogs();
      print(response.body);
      blogStatus = BlogStatus.loaded;
    } catch (e) {
      print("an error occured $e");
      blogStatus = BlogStatus.error;
    }
  }
}

enum BlogStatus { loading, loaded, error }
