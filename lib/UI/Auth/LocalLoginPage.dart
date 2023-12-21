import 'package:live_pharmacy/UI/Auth/ServerLoginPage.dart';
import 'package:live_pharmacy/UI/Auth/localRegister.dart';
import 'package:live_pharmacy/UI/HomePage.dart';
import 'package:live_pharmacy/Unit/unitColor.dart';
import 'package:live_pharmacy/widgets/LoadeingPopWidget.dart';
import 'package:live_pharmacy/widgets/Messge.dart';
import 'package:live_pharmacy/widgets/TextEditingDialog.dart';
import 'package:live_pharmacy/widgets/TextFieldWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Unit/Language.dart';
import '../../Unit/const.dart';
import '../../controll/UserController.dart';
import '../../widgets/TextUnit.dart';

class LocalLoginPage extends StatefulWidget {
  const LocalLoginPage({super.key});

  @override
  State<LocalLoginPage> createState() => _LocalLoginPageState();
}

class _LocalLoginPageState extends State<LocalLoginPage> {
  TextEditingController nameText = TextEditingController();
  TextEditingController passwordText = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  UserController userController = Get.find<UserController>();
  final TextEditingController _controller = TextEditingController();

  Future<void> Session() async {
    String time = DateTime.now().toString();
    await sessionBox.put(time, {
      "login": true,
      "logout": false,
      "timestamp": time,
      "userName": userController.userItem.value.name
    });
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
                      height: 470,
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
                                    ["localLogin"]),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: 500,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.person,
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
                                      circleBorder: true,
                                      textInputType: TextInputType.name,
                                      textEditingController: nameText,
                                      text: language[modeControll.LanguageValue]
                                          ["auth"][0]),
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
                            const SizedBox(
                              height: 5,
                            ),
                            IconButton(
                                onPressed: () async {
                                  bool chickd = false;
                                  await TextEditingDialog(
                                      context: context,
                                      title:
                                          "ادخل الرمز 0000 لتاكيد تسجيل الخروج من السيرفر",
                                      hintText: "ادخل الرمز",
                                      controller: _controller,
                                      onClickOK: (v) {
                                        chickd = true;
                                        _controller.text = v;
                                        Navigator.of(context).pop();
                                      },
                                      onClickNotOK: () {
                                        chickd = false;
                                        Navigator.of(context).pop();
                                      });
                                  if (chickd) {
                                    if (_controller.text == "0000") {
                                      keyBox.delete("apiKey");
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  const ServerLoginPage()),
                                          (Route<dynamic> route) => false);
                                    } else {
                                      Messge.error(
                                          "الرمز {${_controller.text}} غير صحيح",
                                          context);
                                    }
                                  }
                                },
                                icon: const Icon(
                                  Icons.logout,
                                  size: 27,
                                  color: Colors.black45,
                                )),
                            const Spacer(),
                            TextUnit.TextButtonSpcfic(
                                onTop: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          const localRegisterPage()));
                                },
                                color: Colors.lightBlueAccent,
                                text: language[modeControll.LanguageValue]
                                    ["localRegister"]),
                            const SizedBox(
                              height: 10,
                            ),
                            InkWell(
                              onTap: () async {
                                if (_formKey.currentState!.validate()) {
                                  await userController.localLogin(
                                      name: nameText.text,
                                      password: passwordText.text);

                                  if (userController
                                      .errorMessag.value.isEmpty) {
                                    await Session();
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                const HomePage()));
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
