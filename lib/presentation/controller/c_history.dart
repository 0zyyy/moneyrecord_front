import 'package:get/get.dart';
import 'package:untitled/services/history_service.dart';

import '../../data/model/history_model.dart';

class HistoryController extends GetxController {
  final _list = <History>[].obs;
  List<History> get list => _list.value;

  final _isAdded = false.obs;
  bool get isAdded => _isAdded.value;
  getList(idUser, token) async {
    _list.value = await HistoryService.History(idUser, token);
    update();
    //
    // Future.delayed(const Duration(milliseconds: 900), () {
    //   _loading.value = false;
    //   update();
    // });
  }

  addHistory(idUser, token) async {
    _isAdded.value = await HistoryService.addHistory(3, token);
    update();
    if (isAdded) {
      return true;
    }
    return false;
  }
}
