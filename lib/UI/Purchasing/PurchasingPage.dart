import 'dart:developer';

import 'package:live_pharmacy/Unit/UrlData.dart';
import 'package:live_pharmacy/Unit/unitColor.dart';
import 'package:live_pharmacy/model/SalesModel.dart';
import 'package:live_pharmacy/widgets/TextUnit.dart';
import 'package:drop_shadow/drop_shadow.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Unit/Language.dart';
import '../../Unit/const.dart';
import '../../controll/PurchasingController.dart';
import '../../widgets/TextFieldWidget.dart';

class PurchasePage extends StatefulWidget {
  const PurchasePage({super.key});

  @override
  State<PurchasePage> createState() => _PurchasePageState();
}

class _PurchasePageState extends State<PurchasePage> {
  TextEditingController searchControll = TextEditingController();
  PurchasingController purchasingController = Get.put(PurchasingController());
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        child: Obx(() {
          log((purchasingController.sales.value.details ?? [])
              .length
              .toString());
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: modeControll.LanguageValue
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: DropShadow(
                  blurRadius: 4,
                  offset: const Offset(0, 4),
                  color: unitColor.bgColor.withOpacity(.4),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 20),
                    child: TextFieldWidget(
                        width: 700,
                        widget: InkWell(
                            onTap: () async {
                              if (validatePhoneNumber(searchControll.text)
                                  .isEmpty) {
                                purchasingController.sales(SalesModel());
                              } else {
                                await purchasingController.searchByPhoneNumber(
                                    phoneNumber: validatePhoneNumber(
                                        searchControll.text));
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: unitColor.NEUTRAL[4]),
                              child: const Icon(
                                Icons.search,
                                size: 17,
                                color: unitColor.bgColor,
                              ),
                            )),
                        border: true,
                        circleBorder: true,
                        circle: 7,
                        contentPadding: const EdgeInsets.all(10),
                        textInputType: TextInputType.name,
                        textEditingController: searchControll,
                        text: language[modeControll.LanguageValue]["auth"][1]),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                  child: (purchasingController.errorMessage.value.isNotEmpty)
                      ? Center(
                          child: Column(
                            children: [
                              TextUnit.TextTitel(
                                  text: purchasingController.errorMessage.value,
                                  color: Colors.redAccent),
                              const SizedBox(
                                height: 10,
                              ),
                              IconButton(
                                  onPressed: () async {
                                    if (validatePhoneNumber(searchControll.text)
                                        .isEmpty) {
                                      purchasingController.sales(SalesModel());
                                    } else {
                                      await purchasingController
                                          .searchByPhoneNumber(
                                              phoneNumber: validatePhoneNumber(
                                                  searchControll.text));
                                    }
                                  },
                                  icon: const Icon(
                                    Icons.replay,
                                    size: 52,
                                    color: Colors.redAccent,
                                  ))
                            ],
                          ),
                        )
                      : ListView(
                          children: [
                            Wrap(
                                children: List.generate(
                              (purchasingController.sales.value.details ?? [])
                                  .length,
                              (index) => Sales(purchasingController
                                      .sales.value.details![index].fields ??
                                  []),
                            ))
                          ],
                        ))
            ],
          );
        }));
  }

  Widget Sales(List<Fields> fields) {
    return Container(
      width: 330,
      margin: const EdgeInsets.all(10),
      alignment: Alignment.center,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: unitColor.NEUTRAL[4], borderRadius: BorderRadius.circular(7)),
      child: Column(
        children: List.generate(
            fields.length,
            (index) => Container(
                  padding: const EdgeInsets.all(10),
                  alignment: Alignment.center,
                  color: index % 2 == 0 ? unitColor.NEUTRAL[3] : null,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.network(
                        UrlData.imageUrl(fields[index].imageUrl ?? ""),
                        height: 70,
                        width: 70,
                        errorBuilder: (context, error, _) => const Icon(
                          Icons.image_not_supported_outlined,
                          size: 32,
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 70,
                        width: 100,
                        child: TextUnit.TextsubTitel(
                            text: fields[index].name ?? ""),
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 70,
                        width: 100,
                        child: TextUnit.TextsubTitel(
                            text: fields[index].number.toString()),
                      ),
                    ],
                  ),
                )),
      ),
    );
  }

  String validatePhoneNumber(String phoneNumber) {
    // إزالة أي مسافات في الرقم
    phoneNumber = phoneNumber.replaceAll(' ', '');

    // التحقق من أن الرقم يحتوي على 10 خانات ويبدأ بصفر
    if (phoneNumber.length == 10 && phoneNumber.startsWith('0')) {
      // حذف الصفر الأول وإضافة مفتاح السودان
      return '249${phoneNumber.substring(1)}';
    }

    // التحقق من أن الرقم يحتوي على 12 خانة ويبدأ بـ 249
    if (phoneNumber.length == 12 && phoneNumber.startsWith('249')) {
      // لا يوجد تغيير في الرقم
      return phoneNumber;
    }

    // إذا لم يتطابق الرقم مع أي من الحالتين المحددتين، سيتم إرجاع قيمة فارغة
    return '';
  }
}
