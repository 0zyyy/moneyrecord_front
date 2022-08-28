import 'dart:convert';

import 'package:untitled/utils/app_api.dart';
import 'package:untitled/utils/app_const.dart';
import 'package:untitled/utils/app_request.dart';

class UserService {
  static Future<Map?> Login(String email, String password) async {
    try {
      Map? response = await AppRequest.post("${ApiClient.baseUrl}/api/v1/login",
          jsonEncode({"email": email, "password": password}),
          headers: {"Content-Type": "application/json"});
      print(response);
      return response;
    } catch (e) {
      print(e);
    }
  }

  static Future<Map?> Register(
      String nama, String email, String password) async {
    try {
      Map? response = await AppRequest.post(
          "${ApiClient.baseUrl}/api/v1/register",
          jsonEncode({"email": email, "nama": nama, "password": password}));
      print(response);
      return response;
    } catch (e) {
      print(e);
    }
  }
}
