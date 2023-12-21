import 'dart:developer';

import 'package:live_pharmacy/Unit/Language.dart';
import 'package:live_pharmacy/Unit/UrlData.dart';
import 'package:live_pharmacy/model/UserModel.dart';
import 'package:live_pharmacy/server/DioSever.dart';
import 'package:live_pharmacy/Unit/const.dart';
import 'package:get/get.dart';

class UserController extends GetxController with DioServer {
  RxBool isLoading = false.obs;
  RxString errorMessag = "".obs;
  Rx<ListUser> listUser = ListUser().obs;
  Rx<UserModel> userItem = UserModel().obs;

  Future<void> localRegister({required Map<dynamic, dynamic> map}) async {
    runLoadeing();
    if (!userBox.containsKey(map["name"])) {
      await userBox.put(map['name'], map);
    } else {
      errorMessag(language[modeControll.LanguageValue]["authError"][0]);
    }

    stopLoadeing();
  }

  Future<void> localLogin(
      {required String name, required String password}) async {
    runLoadeing();

    if (userBox.containsKey(name)) {
      userItem.value = UserModel.fromMap(map: userBox.get(name)!);
      if (userItem.value.password != password) {
        errorMessag(language[modeControll.LanguageValue]["authError"][1]);
      }
    } else {
      errorMessag(language[modeControll.LanguageValue]["authError"][1]);
    }

    stopLoadeing();
  }

  Future<void> localPutUser({required Map<String, dynamic> map}) async {
    runLoadeing();

    if (userBox.containsKey(userItem.value.name)) {
      await userBox.delete(userItem.value.name);
      await userBox.put(map["name"], map.cast());
      userItem.value = UserModel.fromMap(map: userBox.get(map["name"])!);
    } else {
      errorMessag("404");
    }

    stopLoadeing();
  }

  void localLogout() {
    userItem.value = UserModel();
  }

  Future<void> login({required String email, required String password}) async {
    runLoadeing();
    log(UrlData.login);
    await post(
        url: UrlData.login,
        key: "login",
        data: {"email": email, "password": password});
  }

  runLoadeing() {
    isLoading(true);
    errorMessag("");
  }

  stopLoadeing() {
    isLoading(false);
  }

  @override
  void error(String error) {
    // TODO: implement error
    super.error(error);
    errorMessag(error);
    stopLoadeing();
  }

  @override
  void output(String key, data) async {
    // TODO: implement output
    super.output(key, data);
    await keyBox.put("apiKey", data["apiKey"]);

    stopLoadeing();
  }
}
