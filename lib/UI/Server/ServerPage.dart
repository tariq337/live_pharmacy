import 'package:live_pharmacy/Unit/Language.dart';
import 'package:live_pharmacy/Unit/const.dart';
import 'package:live_pharmacy/Unit/unitColor.dart';
import 'package:live_pharmacy/widgets/TextUnit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ServerPage extends StatefulWidget {
  const ServerPage({super.key});

  @override
  State<ServerPage> createState() => _ServerPageState();
}

class _ServerPageState extends State<ServerPage> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 500,
            margin: const EdgeInsets.symmetric(vertical: 16),
            padding: const EdgeInsets.all(16),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: (connectionController.errorMessage.value.isEmpty &&
                        purBox.values.toList().isEmpty &&
                        sessionBox.values.toList().isEmpty)
                    ? unitColor.bgColor
                    : Colors.red,
                borderRadius: BorderRadius.circular(7)),
            child: TextUnit.TextTitel(
                color: Colors.white,
                text: (connectionController.errorMessage.value.isEmpty &&
                        purBox.values.toList().isEmpty &&
                        sessionBox.values.toList().isEmpty)
                    ? language[modeControll.LanguageValue]["synchronizDon"]
                    : connectionController.isLoadeing.value
                        ? language[modeControll.LanguageValue]["synchronizRun"]
                        : language[modeControll.LanguageValue]
                                ["errorSynchroniz"] +
                            " {${connectionController.errorMessage.value}}"),
          ),
          if (connectionController.isLoadeing.isFalse)
            if ((connectionController.errorMessage.value.isNotEmpty ||
                purBox.values.toList().isNotEmpty ||
                sessionBox.values.toList().isNotEmpty))
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: connectionController.errorMessage.value.isEmpty
                          ? unitColor.bgColor
                          : Colors.red,
                      shape: BoxShape.circle),
                  child: connectionController.isLoadeing.value
                      ? const CircularProgressIndicator(
                          strokeWidth: 30,
                          backgroundColor: Colors.white,
                        )
                      : IconButton(
                          onPressed: () async {
                            if (connectionController.isLoadeing.isFalse) {
                              await connectionController.passPurchasing();
                            }
                          },
                          icon: const Icon(
                            Icons.refresh_sharp,
                            color: Colors.white,
                            size: 52,
                          )))
        ],
      );
    });
  }
}
