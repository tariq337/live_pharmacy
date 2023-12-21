import 'package:live_pharmacy/controll/ModeControll.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../controll/ConnectionController.dart';

final modeControll = Get.find<ModeControll>();

final connectionController = Get.find<ConnectionController>();

PageController pageController = PageController(initialPage: 0);

PageController prodactpageController = PageController(initialPage: 0);

late Box<bool> modBox;

late Box<String> keyBox;

late Box<Map<dynamic, dynamic>> purBox;

late Box<Map<dynamic, dynamic>> storeBox;

late Box<Map<dynamic, dynamic>> sessionBox;

late Box<Map<dynamic, dynamic>> userBox;
