import 'package:live_pharmacy/Unit/Language.dart';
import 'package:live_pharmacy/Unit/const.dart';
import 'package:live_pharmacy/Unit/unitColor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controll/UserController.dart';
import '../../widgets/TextEditingDialog.dart';
import '../../widgets/TextUnit.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  UserController userController = Get.find<UserController>();
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: unitColor.NEUTRAL[4], shape: BoxShape.circle),
            child: Icon(
              Icons.perm_identity,
              size: 65,
              color:
                  modeControll.ThemeModeValue ? Colors.black54 : Colors.white54,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.all(16),
            alignment: Alignment.center,
            width: 700,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: unitColor.NEUTRAL[4]),
            child: Column(
              children: [
                ItemWidget(
                    title: language[modeControll.LanguageValue]["auth"][0] +
                        ": " +
                        (userController.userItem.value.name ?? ""),
                    onTap: () async {
                      Map<String, dynamic> data =
                          userController.userItem.value.toJson();
                      bool chick = false;
                      await TextEditingDialog(
                          context: context,
                          title: language[modeControll.LanguageValue]["auth"]
                              [0],
                          hintText: language[modeControll.LanguageValue]["auth"]
                              [0],
                          controller: _controller,
                          onClickOK: (String v) {
                            _controller.text = v;
                            chick = true;
                            Navigator.of(context).pop();
                          },
                          onClickNotOK: () {
                            chick = false;
                            Navigator.of(context).pop();
                          });
                      if (chick) {
                        data["name"] = _controller.text;
                        await userController.localPutUser(map: data);
                      }
                    }),
                const SizedBox(
                  height: 10,
                ),
                ItemWidget(
                    title: language[modeControll.LanguageValue]["auth"][1] +
                        ": " +
                        (userController.userItem.value.phoneNumber ?? ""),
                    onTap: () async {
                      Map<String, dynamic> data =
                          userController.userItem.value.toJson();
                      bool chick = false;
                      await TextEditingDialog(
                          context: context,
                          title: language[modeControll.LanguageValue]["auth"]
                              [1],
                          hintText: language[modeControll.LanguageValue]["auth"]
                              [1],
                          controller: _controller,
                          onClickOK: (String v) {
                            _controller.text = v;
                            chick = true;
                            Navigator.of(context).pop();
                          },
                          onClickNotOK: () {
                            chick = false;
                            Navigator.of(context).pop();
                          });
                      if (chick) {
                        data["phone"] = _controller.text;
                        await userController.localPutUser(map: data);
                      }
                    }),
                const SizedBox(
                  height: 10,
                ),
                ItemWidget(
                    title: language[modeControll.LanguageValue]["auth"][2] +
                        ": " +
                        ("********"),
                    onTap: () async {
                      Map<String, dynamic> data =
                          userController.userItem.value.toJson();
                      bool chick = false;
                      await TextEditingDialog(
                          context: context,
                          title: language[modeControll.LanguageValue]["auth"]
                              [2],
                          hintText: language[modeControll.LanguageValue]["auth"]
                              [2],
                          controller: _controller,
                          onClickOK: (String v) {
                            _controller.text = v;
                            chick = true;
                            Navigator.of(context).pop();
                          },
                          onClickNotOK: () {
                            chick = false;
                            Navigator.of(context).pop();
                          });
                      if (chick) {
                        data["password"] = _controller.text;
                        await userController.localPutUser(map: data);
                      }
                    }),
              ],
            ),
          ),
        ],
      );
    });
  }

  Widget ItemWidget(
      {required String title, String? text, required void Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 700,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
            color: unitColor.NEUTRAL[4],
            borderRadius: BorderRadius.circular(7)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 300,
              child: TextUnit.TextsubTitel(text: text ?? title),
            ),
            const Icon(
              Icons.navigate_next_outlined,
              color: unitColor.bgColor,
              size: 27,
            ),
          ],
        ),
      ),
    );
  }
}
