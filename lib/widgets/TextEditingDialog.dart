import 'package:live_pharmacy/Unit/Language.dart';
import 'package:live_pharmacy/Unit/const.dart';
import 'package:live_pharmacy/widgets/TextUnit.dart';
import 'package:flutter/material.dart';

Future<void> TextEditingDialog(
    {required BuildContext context,
    required String title,
    required String hintText,
    required TextEditingController controller,
    required Function onClickOK,
    TextInputType? textInputType,
    required Function onClickNotOK}) async {
  controller.text = "";
  await showDialog(
      context: context,
      builder: (context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            title: TextUnit.TextNormle(text: title, size: 17),
            content: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              height: 53,
              child: TextField(
                controller: controller,
                keyboardType: textInputType ?? TextInputType.number,
                style: TextStyle(
                    fontFamily: TextUnit.textFonts,
                    fontSize: 15,
                    color: modeControll.ThemeModeValue
                        ? Colors.black
                        : Colors.white),
                decoration: InputDecoration(
                    hintStyle: TextStyle(
                        fontFamily: TextUnit.textFonts,
                        fontSize: 13,
                        color: modeControll.ThemeModeValue
                            ? Colors.black54
                            : Colors.white54),
                    hintText: hintText,
                    border: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(5),
                        ),
                        borderSide: BorderSide(
                            width: 1,
                            color: modeControll.ThemeModeValue
                                ? Colors.black54
                                : Colors.white54))),
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () async {
                    if (controller.text.isNotEmpty) {
                      onClickOK(controller.text);
                    }
                  },
                  child: TextUnit.TextNormle(
                      text: language[modeControll.LanguageValue]["dialog"][0],
                      size: 14,
                      color: Colors.green)),
              TextButton(
                  onPressed: () {
                    onClickNotOK();
                  },
                  child: TextUnit.TextNormle(
                      text: language[modeControll.LanguageValue]["dialog"][1],
                      size: 14,
                      color: Colors.redAccent))
            ],
          ),
        );
      });
}
