import 'package:live_pharmacy/Unit/unitColor.dart';
import 'package:live_pharmacy/widgets/LoadeingPopWidget.dart';
import 'package:live_pharmacy/widgets/Messge.dart';
import 'package:live_pharmacy/widgets/TextFieldWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../Unit/Language.dart';
import '../../Unit/const.dart';
import '../../controll/UserController.dart';
import '../../widgets/TextUnit.dart';

class localRegisterPage extends StatefulWidget {
  const localRegisterPage({super.key});

  @override
  State<localRegisterPage> createState() => _localRegisterPageState();
}

class _localRegisterPageState extends State<localRegisterPage> {
  TextEditingController nameText = TextEditingController();
  TextEditingController phoneText = TextEditingController();
  TextEditingController password1Text = TextEditingController();
  TextEditingController password2Text = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  UserController userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: unitColor.NEUTRAL[3],
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: unitColor.NEUTRAL[3],
      ),
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
                      height: 580,
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
                                    ["localRegister"]),
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
                                    Icons.phone,
                                    color: unitColor.bgColor,
                                    size: 30,
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  TextFieldWidget(
                                      width: 400,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(9),
                                        FilteringTextInputFormatter.deny(
                                            RegExp('^0'))
                                      ],
                                      validator: (v) {
                                        if (((v ?? "").isEmpty) ||
                                            (v == null)) {
                                          return language[modeControll
                                              .LanguageValue]["authError"][2];
                                        }
                                        if (9 != (v).length) {
                                          return language[modeControll
                                              .LanguageValue]["authError"][4];
                                        } else {
                                          return null;
                                        }
                                      },
                                      color: unitColor.NEUTRAL[3],
                                      border: true,
                                      circleBorder: true,
                                      textInputType: TextInputType.phone,
                                      textEditingController: phoneText,
                                      text: language[modeControll.LanguageValue]
                                          ["auth"][1]),
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
                                        } else if (password1Text.text !=
                                            password2Text.text) {
                                          return language[modeControll
                                              .LanguageValue]["authError"][3];
                                        } else if (v.length <= 8) {
                                          return language[modeControll
                                              .languageMode]["authError"][5];
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
                                      textEditingController: password1Text,
                                      text: language[modeControll.LanguageValue]
                                          ["auth"][2]),
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
                                        } else if (password1Text.text !=
                                            password2Text.text) {
                                          return language[modeControll
                                              .LanguageValue]["authError"][3];
                                        } else if (v.length < 8) {
                                          return language[modeControll
                                              .languageMode]["authError"][5];
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
                                      textEditingController: password2Text,
                                      text: language[modeControll.LanguageValue]
                                          ["auth"][3]),
                                ],
                              ),
                            ),
                            const Spacer(),
                            TextUnit.TextButtonSpcfic(
                                onTop: () {
                                  Navigator.of(context).pop();
                                },
                                color: Colors.lightBlueAccent,
                                text: language[modeControll.LanguageValue]
                                    ["localLogin"]),
                            const SizedBox(
                              height: 10,
                            ),
                            InkWell(
                              onTap: () async {
                                if (_formKey.currentState!.validate()) {
                                  await userController.localRegister(map: {
                                    "name": nameText.text,
                                    "password": password1Text.text,
                                    "phone": "249${phoneText.text}",
                                  });
                                  if (userController
                                      .errorMessag.value.isEmpty) {
                                    Navigator.of(context).pop();
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
