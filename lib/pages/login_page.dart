import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/data/model/user_model.dart';
import 'package:untitled/pages/register_page.dart';
import 'package:untitled/services/user_service.dart';
import 'package:untitled/utils/app_asset.dart';
import 'package:untitled/utils/app_color.dart';
import 'package:untitled/utils/session.dart';
import 'package:untitled/widgets/loading_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoading = false;
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  login() async {
    Map? response =
        await UserService.Login(emailController.text, passController.text);
    String msg = response?["meta"]["message"] == null
        ? ''
        : response!["meta"]["message"];
    if (msg == '') {
      Get.snackbar("Ada kesalahan", "Terjadi kesalahan pada server");
    } else if (response?["meta"]["code"] == 200) {
      response?["data"]["id_user"] = response?["data"]["id_user"].toString();
      Session.saveUser(User.fromJson(response?["data"]));
      setState(() {
        isLoading = !isLoading;
      });
      Future.delayed(Duration(seconds: 2), () {
        Get.toNamed('home');
        setState(() {
          isLoading = !isLoading;
        });
      });
    } else if (response!["meta"]["code"] == 422) {
      Get.snackbar(msg, "Username atau password salah",
          backgroundColor: Colors.redAccent);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bg,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(),
                  Form(
                    key: formKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        children: [
                          Image.asset(AppAsset.logo),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: emailController,
                            validator: (value) =>
                                value == '' ? 'Jangan kosong' : null,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              fillColor: AppColor.primary.withOpacity(0.5),
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none,
                              ),
                              hintText: 'email',
                              isDense: true,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 16,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: passController,
                            validator: (value) =>
                                value == '' ? 'Jangan kosong' : null,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            obscureText: true,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              fillColor: AppColor.primary.withOpacity(0.5),
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none,
                              ),
                              hintText: 'password',
                              isDense: true,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 16,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          isLoading
                              ? LoadingButton()
                              : Material(
                                  color: AppColor.primary,
                                  borderRadius: BorderRadius.circular(30),
                                  child: InkWell(
                                    onTap: () => login(),
                                    borderRadius: BorderRadius.circular(30),
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 40, vertical: 16),
                                      child: Text(
                                        'LOGIN',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Belum punya akun? ',
                          style: TextStyle(fontSize: 16),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => const RegisterPage());
                          },
                          child: const Text(
                            'Register',
                            style: TextStyle(
                              color: AppColor.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
