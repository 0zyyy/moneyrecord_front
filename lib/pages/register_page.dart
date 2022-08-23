import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/services/user_service.dart';
import 'package:untitled/utils/app_asset.dart';
import 'package:untitled/utils/app_color.dart';
import 'package:untitled/utils/app_fonts.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController namaController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  register() async{
    Map? response = await UserService.Register(
        namaController.text, emailController.text, passController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Get.toNamed('/login');
            },
            child: Icon(Icons.arrow_back)),
      ),
      backgroundColor: AppColor.bg,
      body: LayoutBuilder(builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        'REGISTER',
                        style: AppFont.primaryTextStyle,
                      ),
                      SizedBox(),
                      Form(
                        key: formKey,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Column(
                            children: [
                              Image.asset(AppAsset.logo),
                              SizedBox(height: 20,),
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
                              SizedBox(height: 20,),
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
                              SizedBox(height: 20,),
                            ],
                          ),
                        ),
                      ),
                      Material(
                        color: AppColor.primary,
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        child: InkWell(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          onTap: () => register(),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Text("Register",
                                style: AppFont.primaryTextStyle.copyWith(
                                    fontSize: 16, color: AppColor.secondary)),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                    padding: EdgeInsets.fromLTRB(16, 16, 16, 20),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Belum punya akun? ",
                            style: AppFont.secondaryTextStyle.copyWith(
                              color: Colors.black26,
                            ),
                          ),
                          GestureDetector(
                              onTap: () {
                                Get.snackbar("Bakekok", "bakekok",
                                    showProgressIndicator: true);
                              },
                              child: Text(
                                "Daftar",
                                style: AppFont.secondaryTextStyle,
                              ))
                        ])),
              ],
            ),
          ),
        );
      }),
    );
  }
}
