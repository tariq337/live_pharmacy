import 'dart:io';

import 'package:live_pharmacy/Unit/const.dart';
import 'package:live_pharmacy/Unit/unitColor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controll/UserController.dart';
import 'Auth/LocalLoginPage.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({super.key});

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  int index = 0;
  UserController userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: unitColor.bgColor, borderRadius: BorderRadius.circular(11)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 20,
          ),
          DrawerItem(
            click: (index == 0),
            icon: Icons.home_filled,
            onTap: () {
              pageController.animateToPage(0,
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeIn);
              setState(() {
                index = 0;
              });
            },
          ),
          const SizedBox(
            height: 10,
          ),
          DrawerItem(
            click: (index == 1),
            icon: Icons.store,
            onTap: () {
              pageController.animateToPage(1,
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeIn);
              setState(() {
                index = 1;
              });
            },
          ),
          const SizedBox(
            height: 10,
          ),
          DrawerItem(
            click: (index == 2),
            icon: Icons.notification_important,
            onTap: () {
              pageController.animateToPage(2,
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeIn);
              setState(() {
                index = 2;
              });
            },
          ),
          const SizedBox(
            height: 10,
          ),
          DrawerItem(
            click: (index == 3),
            icon: Icons.receipt,
            onTap: () {
              pageController.animateToPage(3,
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeIn);
              setState(() {
                index = 3;
              });
            },
          ),
          const SizedBox(
            height: 10,
          ),
          DrawerItem(
            click: (index == 4),
            icon: Icons.person,
            onTap: () {
              pageController.animateToPage(4,
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeIn);
              setState(() {
                index = 4;
              });
            },
          ),
          const Spacer(),
          DrawerItem(
            click: false,
            icon: Icons.language,
            onTap: () {
              modeControll.languageToggle();
            },
          ),
          const SizedBox(
            height: 10,
          ),
          DrawerItem(
            click: false,
            icon: Icons.logout,
            onTap: () async {
              String time = DateTime.now().toString();
              await sessionBox.put(time, {
                "login": false,
                "logout": true,
                "timestamp": time,
                "userName": userController.userItem.value.name
              });
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          const LocalLoginPage()),
                  (Route<dynamic> route) => false);
            },
          ),
          const SizedBox(
            height: 10,
          ),
          Obx(() {
            return DrawerItem(
                click: (index == 5),
                icon: Icons.wifi,
                onTap: () {
                  pageController.animateToPage(5,
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.easeIn);
                  setState(() {
                    index = 5;
                  });
                },
                color: connectionController.isconnection.value
                    ? Colors.green[800]
                    : Colors.redAccent);
          }),
          const SizedBox(
            height: 10,
          ),
          DrawerItem(
            color: Colors.red,
            click: true,
            icon: Icons.power_settings_new,
            onTap: () async {
              String time = DateTime.now().toString();
              await sessionBox.put(time, {
                "login": false,
                "logout": true,
                "timestamp": time,
                "userName": userController.userItem.value.name
              });
              exit(0);
            },
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}

class DrawerItem extends StatefulWidget {
  Function()? onTap;
  bool click;
  IconData icon;
  Color? color;
  DrawerItem(
      {super.key,
      required this.icon,
      required this.onTap,
      required this.click,
      this.color});

  @override
  State<DrawerItem> createState() => _DrawerItemState();
}

class _DrawerItemState extends State<DrawerItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            color: widget.click
                ? (widget.color ?? Colors.white).withOpacity(.3)
                : Colors.transparent),
        child: Icon(
          widget.icon,
          color: widget.color ??
              (widget.click ? Colors.white : unitColor.NEUTRAL[3]),
          size: 23,
        ),
      ),
    );
  }
}
