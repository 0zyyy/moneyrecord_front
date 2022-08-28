import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';
import 'package:untitled/data/model/user_model.dart';
import 'package:untitled/helper/dependencies.dart' as dp;
import 'package:untitled/pages/add_history.dart';
import 'package:untitled/pages/history_page.dart';
import 'package:untitled/pages/home_page.dart';
import 'package:untitled/pages/login_page.dart';
import 'package:untitled/pages/register_page.dart';
import 'package:untitled/presentation/controller/c_home.dart';
import 'package:untitled/utils/app_color.dart';
import 'package:untitled/utils/session.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dp.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (context) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        getPages: [
          GetPage(
              name: '/login',
              page: () => LoginPage(),
              transition: Transition.fadeIn),
          GetPage(name: '/register', page: () => RegisterPage()),
          GetPage(name: '/home', page: () => HomePage()),
          GetPage(name: "/history", page: () => HistoryPage()),
          GetPage(name: "/tambah", page: () => AddHistoryPage()),
        ],
        theme: ThemeData.light().copyWith(
          primaryColor: AppColor.primary,
          colorScheme: const ColorScheme.light(
              primary: AppColor.bgColor1,
              secondary: AppColor.bgColor2,
              background: AppColor.bgColor1),
          appBarTheme: const AppBarTheme(
              backgroundColor: AppColor.primary, foregroundColor: Colors.white),
        ),
        home: FutureBuilder(
            future: Session.getUser(),
            builder: (context, AsyncSnapshot<User> snapshot) {
              if (snapshot.data != null && snapshot.data!.idUser != null) {
                return HomePage();
              }
              return LoginPage();
            }),
      );
    });
  }
}
