import 'package:live_pharmacy/UI/Auth/LocalLoginPage.dart';
import 'package:live_pharmacy/Unit/Language.dart';
import 'package:live_pharmacy/Unit/const.dart';
import 'package:live_pharmacy/Unit/unitColor.dart';
import 'package:live_pharmacy/controll/UserController.dart';
import 'package:live_pharmacy/widgets/Messge.dart';
import 'package:live_pharmacy/widgets/TextFieldWidget.dart';
import 'package:live_pharmacy/widgets/TextUnit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/LoadeingPopWidget.dart';

class ServerLoginPage extends StatefulWidget {
  const ServerLoginPage({super.key});

  @override
  State<ServerLoginPage> createState() => _ServerLoginPageState();
}

class _ServerLoginPageState extends State<ServerLoginPage> {
  TextEditingController emailText = TextEditingController();
  TextEditingController passwordText = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  UserController userController = Get.find<UserController>();
  bool validateEmail(String email) {
    // تعبير عادات البريد الإلكتروني
    final RegExp emailRegex =
        RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return emailRegex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: unitColor.NEUTRAL[3],
      body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Obx(() {
            return Directionality(
              textDirection: modeControll.ThemeModeValue
                  ? TextDirection.rtl
                  : TextDirection.ltr,
              child: LoadeingPopWidget(
                isLoadeing: userController.isLoading.value,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 400,
                      width: 600,
                      decoration: BoxDecoration(
                          color: unitColor.NEUTRAL[4],
                          borderRadius: BorderRadius.circular(11)),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            const FlutterLogo(
                              size: 70,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextUnit.TextTitel(
                                text: language[modeControll.LanguageValue]
                                    ["serverLogin"]),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: 500,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.email,
                                    color: unitColor.bgColor,
                                    size: 30,
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  TextFieldWidget(
                                      width: 400,
                                      validator: (v) {
                                        if (((v ?? "").isEmpty) ||
                                            (v == null)) {
                                          return language[modeControll
                                              .LanguageValue]["authError"][6];
                                        } else if (!validateEmail(
                                            emailText.text)) {
                                          return language[modeControll
                                              .LanguageValue]["authError"][7];
                                        } else {
                                          return null;
                                        }
                                      },
                                      color: unitColor.NEUTRAL[3],
                                      border: true,
                                      circleBorder: true,
                                      textInputType: TextInputType.name,
                                      textEditingController: emailText,
                                      text: language[modeControll.LanguageValue]
                                          ["auth"][4]),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: 500,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.lock,
                                    color: unitColor.bgColor,
                                    size: 30,
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  TextFieldWidget(
                                      width: 400,
                                      validator: (v) {
                                        if (((v ?? "").isEmpty) ||
                                            (v == null)) {
                                          return language[modeControll
                                              .LanguageValue]["authError"][2];
                                        } else {
                                          return null;
                                        }
                                      },
                                      color: unitColor.NEUTRAL[3],
                                      border: true,
                                      length: 1,
                                      obscureText: true,
                                      circleBorder: true,
                                      textInputType:
                                          TextInputType.visiblePassword,
                                      textEditingController: passwordText,
                                      text: language[modeControll.LanguageValue]
                                          ["auth"][2]),
                                ],
                              ),
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: () async {
                                if (_formKey.currentState!.validate()) {
                                  await userController.login(
                                      email: emailText.text,
                                      password: passwordText.text);
                                  if (userController
                                      .errorMessag.value.isEmpty) {
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                const LocalLoginPage()),
                                        (Route<dynamic> route) => false);
                                  } else {
                                    Messge.error(
                                        userController.errorMessag.value,
                                        context);
                                  }
                                }
                              },
                              child: Container(
                                height: 55,
                                width: 300,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: unitColor.bgColor,
                                    borderRadius: BorderRadius.circular(11)),
                                child: TextUnit.TextTitel(
                                    text: language[modeControll.languageMode]
                                        ["next"],
                                    color: Colors.white),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          })),
    );
  }
}
