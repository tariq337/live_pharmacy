import 'package:live_pharmacy/Unit/const.dart';
import 'package:get/get.dart';

class ModeControll extends GetxController {
  RxBool languageMode = true.obs;
  RxBool themeMode = true.obs;
  @override
  void onInit() {
    super.onInit();
    getdata();
  }

  getdata() {
    languageMode(modBox.get("language", defaultValue: true));
    themeMode(modBox.get("theme", defaultValue: true));
  }

  bool get ThemeModeValue => themeMode.value;

  bool get LanguageValue => languageMode.value;

  void languageToggle() {
    languageMode(!languageMode.value);
    modBox.put("language", languageMode.value);
  }

  void themeToggle() {
    themeMode(!themeMode.value);
    modBox.put("theme", themeMode.value);
  }
}
