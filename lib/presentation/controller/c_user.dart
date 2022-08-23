import 'package:get/get.dart';
import 'package:untitled/data/model/user_model.dart';

class UserController extends GetxController{
  final _data = User().obs;
  User get user => _data.value;
  setData(n) => _data.value = n;
}