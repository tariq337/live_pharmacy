import 'dart:developer';

import 'package:live_pharmacy/Unit/Language.dart';
import 'package:live_pharmacy/Unit/UrlData.dart';
import 'package:live_pharmacy/Unit/const.dart';
import 'package:live_pharmacy/model/PurchasingModel.dart';
import 'package:live_pharmacy/model/SalesModel.dart';
import 'package:live_pharmacy/server/DioSever.dart';
import 'package:get/get.dart';

class PurchasingController extends GetxController with DioServer {
  RxBool isLoadeing = false.obs;
  RxList<PurchasingModel> listPurchasing = <PurchasingModel>[].obs;
  RxString errorMessage = "".obs;
  Rx<SalesModel> sales = SalesModel().obs;

  void getPurchasing() {
    purBox.values.toList().forEach((element) {
      listPurchasing.value
          .add(PurchasingModel.fromJson(element.cast<String, dynamic>()));
    });
  }

  Future<void> addPurchasing(
      {required Map<dynamic, dynamic> purchasing}) async {
    runLoadeing();
    await purBox.put(purchasing["timestamp"].toString(), purchasing);
    stopLoadeing();
  }

  Future<void> deletePurchasing({required String key}) async {
    runLoadeing();
    if (purBox.containsKey(key)) {
      await purBox.delete(key);
    } else {
      errorMessage(language[modeControll.LanguageValue]["notFound"]);
    }

    stopLoadeing();
  }

  Future<void> searchByPhoneNumber({required String phoneNumber}) async {
    runLoadeing();
    log(UrlData.salesClines);
    await get(
        url: UrlData.salesClines,
        key: "searchByPhoneNumber",
        data: {"phoneNumber": phoneNumber},
        apiKey: true);
  }

  runLoadeing() {
    isLoadeing(true);
    errorMessage("");
  }

  stopLoadeing() {
    isLoadeing(false);
  }

  @override
  void error(String error) {
    // TODO: implement error
    super.error(error);
    errorMessage(error);
  }

  @override
  void output(String key, data) {
    // TODO: implement output
    super.output(key, data);
    log(data.toString());
    sales(SalesModel.fromJson(data));
  }
}
