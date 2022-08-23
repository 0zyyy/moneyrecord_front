import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:untitled/utils/app_request.dart';

class HistoryService {
  static History(int idUser) async {
    try {
      Map? response = await AppRequest.post(
          'http://192.168.0.23:8080/api/v1/search/history',
          jsonEncode({"id_user": idUser, "date": ""}));
      print(response);

      return response;
    } catch (e) {
      print(e);
    }
  }

  static Future<Map?> Analysis(int idUser) async {
    try {
      Map? response = await AppRequest.post(
          'http://192.168.0.23:8080/api/v1/anal',
          jsonEncode({"id_user": idUser, "date": "2022-06-21"}));
      if (response == null) {
        return {
          "meta": {
            "message": "Failed to fetch anal",
            "code": 500,
            "status": "failed"
          },
          "data": {
            "today": 0.0,
            "yesterday": 0.0,
            "week": [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0],
            "month": {"income": 0.0, "outcome": 00.0}
          }
        };
      }
      return response;
    } catch (e) {
      print(e);
    }
  }
}
