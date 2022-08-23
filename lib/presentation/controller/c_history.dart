import 'package:get/get.dart';
import 'package:untitled/services/history_service.dart';

import '../../data/model/history_model.dart';

class HistoryController extends GetxController{
  final _list = <History>[].obs;
  List<History> get list => _list.value;

  getList(idUser) async {

    _list.value = await HistoryService.History(idUser);
    update();
    //
    // Future.delayed(const Duration(milliseconds: 900), () {
    //   _loading.value = false;
    //   update();
    // });
  }

 }
