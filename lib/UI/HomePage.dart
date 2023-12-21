import 'package:live_pharmacy/UI/NotificationPage.dart';
import 'package:live_pharmacy/UI/Order/OrderPage.dart';
import 'package:live_pharmacy/UI/Server/ServerPage.dart';
import 'package:live_pharmacy/UI/Storage/StoragePage.dart';
import 'package:live_pharmacy/UI/User/UserPage.dart';
import 'package:live_pharmacy/Unit/const.dart';
import 'package:live_pharmacy/Unit/unitColor.dart';
import 'package:flutter/material.dart';
import 'package:live_pharmacy/UI/DrawerPage.dart';
import 'package:get/get.dart';

import 'Purchasing/PurchasingPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: unitColor.NEUTRAL[3],
      body: Obx(() {
        return Directionality(
            textDirection: modeControll.LanguageValue
                ? TextDirection.rtl
                : TextDirection.ltr,
            child: Row(children: [
              const DrawerPage(),
              Expanded(
                  child: PageView(
                controller: pageController,
                scrollDirection: Axis.vertical,
                physics: const NeverScrollableScrollPhysics(),
                children: const [
                  OrderPage(), //0
                  StoragePage(), //1
                  NotificationPage(), //2
                  PurchasePage(), //3
                  UserPage(), //4
                  ServerPage() //5
                ],
              )),
            ]));
      }),
    );
  }
}
