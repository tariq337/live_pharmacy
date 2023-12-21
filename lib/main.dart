import 'package:desktop_window/desktop_window.dart';
import 'package:live_pharmacy/UI/Auth/LocalLoginPage.dart';
import 'package:live_pharmacy/UI/Auth/ServerLoginPage.dart';
import 'package:live_pharmacy/controll/ModeControll.dart';
import 'package:live_pharmacy/controll/UserController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:live_pharmacy/Unit/const.dart';

import 'controll/ConnectionController.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DesktopWindow.setFullScreen(true);
  await Hive.initFlutter();

  modBox = await Hive.openBox<bool>("mode");

  Get.put(ModeControll());

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _getData();
  }

  bool loading = true;

  _getData() async {
    storeBox = await Hive.openBox<Map<dynamic, dynamic>>("Storeg");
    userBox = await Hive.openBox<Map<dynamic, dynamic>>("Users");
    purBox = await Hive.openBox<Map<dynamic, dynamic>>("Purchasing");
    keyBox = await Hive.openBox<String>("key");
    sessionBox = await Hive.openBox<Map<dynamic, dynamic>>("session");
    Get.put(ConnectionController());
    Get.put(UserController());
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return MaterialApp(
          title: 'Demo',
          theme: ThemeData(useMaterial3: true),
          home: const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          ));
    }
    return GetMaterialApp(
      initialBinding: BindingsBuilder(() {
        Get.put(ModeControll());
      }),
      title: 'Demo',
      theme: modeControll.ThemeModeValue
          ? ThemeData(useMaterial3: true)
          : ThemeData.dark(useMaterial3: true),
      home: (keyBox.get("apiKey", defaultValue: "") ?? "").isEmpty
          ? const ServerLoginPage()
          : const LocalLoginPage(),
    );
  }
}
