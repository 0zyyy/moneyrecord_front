import 'package:get/get.dart';
import 'package:untitled/presentation/controller/c_history.dart';
import 'package:untitled/presentation/controller/c_home.dart';
import 'package:untitled/presentation/controller/c_user.dart';
import 'package:untitled/services/history_service.dart';
import 'package:untitled/services/user_service.dart';

Future<void> init() async {
  //controllers
  Get.lazyPut(() => HomeController());
  Get.lazyPut(() => UserController());
  Get.lazyPut(() => HistoryController());

  //services
  Get.lazyPut(() => HistoryService());
  Get.lazyPut(() => UserService());
}
