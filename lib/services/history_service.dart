import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:untitled/utils/app_api.dart';
import 'package:untitled/utils/app_request.dart';

class HistoryService {
  static History(int idUser, String token) async {
    try {
      Map? response = await AppRequest.post(
          '${ApiClient.baseUrl}/api/v1/search/history',
          jsonEncode({"id_user": idUser, "date": ""}),
          headers: {"Authorization": "Bearer ${token}"});
      print(response);

      return response;
    } catch (e) {
      print(e);
    }
  }

  static Future<Map?> Analysis(int idUser, String token) async {
    try {
      Map? response = await AppRequest.post(
          '${ApiClient.baseUrl}/api/v1/anal',
          jsonEncode({
            "id_user": idUser,
            "date": DateFormat('yyyy-MM-dd').format(DateTime.now()),
          }),
          headers: {"Authorization": "Bearer " + token});
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

  static Future<bool> addHistory(int idUser, String token) async {
    try {
      Map? response = await AppRequest.post(
          '${ApiClient.baseUrl}/api/v1/history',
          jsonEncode({
            "id_user": idUser,
            "type": "Pengeluaran",
            "date": DateFormat('yyyy-MM-dd').format(DateTime.now()),
            "total": "100000",
            "details": '{"kimchi": "100000"}'
          }),
          headers: {"Authorization": "Bearer " + token});
      if (response!["meta"]["status"] == 200) {
        return true;
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
