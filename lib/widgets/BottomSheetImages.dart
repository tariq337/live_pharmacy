import 'package:live_pharmacy/Unit/Language.dart';
import 'package:live_pharmacy/Unit/const.dart';
import 'package:live_pharmacy/widgets/TextUnit.dart';
import 'package:flutter/material.dart';

Future<void> BottomSheetImage(
    {required BuildContext context,
    required Function onCameraClick,
    required Function onStudioClick}) async {
  return await showModalBottomSheet(
      context: context,
      builder: (context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            decoration: BoxDecoration(
              color: modeControll.ThemeModeValue ? Colors.white : Colors.black,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0)),
            ),
            child: Wrap(
              alignment: WrapAlignment.end,
              crossAxisAlignment: WrapCrossAlignment.end,
              children: [
                ListTile(
                  leading: const Icon(Icons.camera_alt_outlined),
                  title: TextUnit.TextsubTitel(
                    text: language[modeControll.LanguageValue]["camera"],
                  ),
                  onTap: () async {
                    await onCameraClick();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.image),
                  title: TextUnit.TextsubTitel(
                      text: language[modeControll.LanguageValue]["studio"]),
                  onTap: () async {
                    await onStudioClick();
                  },
                ),
              ],
            ),
          ),
        );
      });
}
