import 'package:live_pharmacy/UI/Storage/ApiStoragePage.dart';
import 'package:live_pharmacy/UI/Storage/PutProduct.dart';
import 'package:live_pharmacy/UI/Storage/StrorageBodyPage.dart';
import 'package:live_pharmacy/Unit/unitColor.dart';
import 'package:live_pharmacy/controll/StoreController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Unit/const.dart';

class StoragePage extends StatefulWidget {
  const StoragePage({super.key});

  @override
  State<StoragePage> createState() => _StoragePageState();
}

class _StoragePageState extends State<StoragePage> {
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: prodactpageController,
      physics: const NeverScrollableScrollPhysics(),
      children: const [StorageBodyPage(), ApiStoragePage()],
    );
  }
}
