import 'dart:convert';
import 'dart:io';

import 'package:authentication_app_with_provider/resource/cache/user_preference.dart';
import 'package:authentication_app_with_provider/resource/network/end_points.dart';
import 'package:http/http.dart' as http;

class ApiCalls {
  Future<Map<String, String>> getHeader() async {
    final userPref = await UserPreference.getInstance();
    final token = userPref.getSavedToken();

    final header = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    };
    return header;
  }

  Future<http.Response> login(String email, String password) async {
    final url = Uri.parse(EndPoints.login);
    final body = json.encode({"email": email, "password": password});
    final response = await http.post(url, body: body);
    return response;
  }

  Future<http.Response> loadAllBlogs() async {
    final url = Uri.parse(EndPoints.getBlogs);
    final header = await getHeader();
    final response = await http.get(url, headers: header);
    return response;
  }

  Future<http.Response> loadABlog(String id) async {
    final url = Uri.parse("${EndPoints.getBlogs}/$id");
    final header = await getHeader();
    final response = await http.get(url, headers: header);
    return response;
  }
}
