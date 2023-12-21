import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:live_pharmacy/Unit/Language.dart';
import 'package:live_pharmacy/Unit/UrlData.dart';
import 'package:live_pharmacy/Unit/const.dart';
import 'package:live_pharmacy/server/DioSever.dart';
import 'package:get/get.dart';

class ConnectionController extends GetxController with DioServer {
  RxBool isconnection = false.obs;
  RxBool isLoadeing = false.obs;

  RxString errorMessage = "".obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    connectionChick();
  }

  connectionChick() {
    Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      // Got a new connectivity status!
      if ((result == ConnectivityResult.wifi) ||
          (result == ConnectivityResult.ethernet)) {
        isconnection(true);

        if (!isLoadeing.value) {
          await passPurchasing();
        }
      } else {
        isconnection(false);
        errorMessage(language[modeControll.LanguageValue]["NoConnection"]);
      }
    });
  }

  Future<void> passPurchasing() async {
    log("message");
    runLoadeing();
    List<Map<String, dynamic>> purchasings = [];
    purBox.values.toList().forEach((element) {
      purchasings.add({
        "products": element["products"],
        "timestamp": element["timestamp"],
        "userName": element["userName"],
        "phoneNumber": element["phoneNumber"]
      });
    });
    List<Map<String, dynamic>> userSession = [];

    sessionBox.values.toList().forEach((element) {
      userSession.add({
        "login": element["login"],
        "logout": element["logout"],
        "timestamp": element["timestamp"],
        "userName": element["userName"]
      });
    });
    if (userSession.isNotEmpty) {
      await post(
          url: UrlData.records,
          key: "recordSession",
          apiKey: true,
          data: {"records": userSession},
          outIn: true,
          outPutdata: (data) async {
            for (var element in userSession) {
              log(sessionBox.keys.toString());
              log(element["timestamp"]);
              await sessionBox.delete(element["timestamp"]);
            }
          },
          errorData: (error) {
            log(error);
            errorMessage(error);
          });
    }
    if (purchasings.isNotEmpty) {
      await post(
          url: UrlData.sales,
          key: "passPurchasing",
          apiKey: true,
          data: {"sales": purchasings},
          outIn: true,
          outPutdata: (data) async {
            for (var element in purchasings) {
              log(purBox.keys.toString());
              log(element["timestamp"]);
              await purBox.delete(element["timestamp"]);
            }
          },
          errorData: (error) {
            errorMessage(error);
          });
    }
    if (errorMessage.value.isEmpty &&
        (purBox.values.toList().isNotEmpty ||
            sessionBox.values.toList().isNotEmpty)) {
      log("${purBox.values.toList()}  ${sessionBox.values.toList()}");
      await passPurchasing();
    }
    stopLoadeing();
  }

  runLoadeing() {
    isLoadeing(true);
    errorMessage("");
  }

  stopLoadeing() {
    isLoadeing(false);
  }
}
