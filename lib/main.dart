import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:untitled/data/model/user_model.dart';
import 'package:untitled/pages/add_history.dart';
import 'package:untitled/pages/home_page.dart';
import 'package:untitled/pages/login_page.dart';
import 'package:untitled/pages/register_page.dart';
import 'package:untitled/utils/app_color.dart';
import 'package:untitled/utils/session.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(name: '/login', page: () => LoginPage()),
        GetPage(name: '/register', page: () => RegisterPage()),
        GetPage(name: '/home', page: () => HomePage())
      ],
      theme: ThemeData.light().copyWith(
        primaryColor: AppColor.primary,
        colorScheme: const ColorScheme.light(
          primary: AppColor.bgColor1,
          secondary: AppColor.bgColor2,
        ),
        appBarTheme: const AppBarTheme(
            backgroundColor: AppColor.primary, foregroundColor: Colors.white),
      ),
      home: FutureBuilder(
          future: Session.getUser(),
          builder: (context, AsyncSnapshot<User> snapshot) {
            if (snapshot.data != null && snapshot.data!.idUser != null) {
              return HomePage();
            }
            return AddHistoryPage();
          }),
    );
  }
}
