import 'package:live_pharmacy/UI/Storage/PutProduct.dart';
import 'package:live_pharmacy/Unit/Language.dart';
import 'package:live_pharmacy/Unit/UrlData.dart';
import 'package:live_pharmacy/Unit/const.dart';
import 'package:live_pharmacy/Unit/unitColor.dart';
import 'package:live_pharmacy/widgets/LoadeingPopWidget.dart';
import 'package:live_pharmacy/widgets/Messge.dart';
import 'package:live_pharmacy/widgets/TextFieldWidget.dart';
import 'package:live_pharmacy/widgets/TextUnit.dart';
import 'package:drop_shadow/drop_shadow.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controll/StoreController.dart';
import '../../model/ProductModel.dart';
import '../../widgets/TableWidget.dart';

class StorageBodyPage extends StatefulWidget {
  const StorageBodyPage({
    super.key,
  });

  @override
  State<StorageBodyPage> createState() => _StorageBodyPageState();
}

class _StorageBodyPageState extends State<StorageBodyPage> {
  StoreController storeController = Get.put(StoreController());
  TextEditingController searchControll = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  _getData() {
    if (purBox.values.toList().isEmpty && sessionBox.values.toList().isEmpty) {
      storeController.Synchroniz(true);

      storeController.getMyProduct();
    } else {
      storeController.Synchroniz(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    _getData();

    return Obx(() {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: unitColor.NEUTRAL[4],
          borderRadius: BorderRadius.circular(20),
        ),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: storeController.Synchroniz.value
                ? LoadeingPopWidget(
                    isLoadeing: storeController.isLoading.value,
                    error: storeController.errorMessag.value,
                    reloade: () {
                      storeController.getMyProduct();
                    },
                    child: Stack(children: [
                      Container(
                          padding: const EdgeInsets.all(16),
                          alignment: Alignment.topCenter,
                          child: ListView(
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
                                            onTap: () {
                                              if (searchControll
                                                  .text.isNotEmpty) {
                                                storeController
                                                    .searchStoregByName(
                                                        name: searchControll
                                                            .text);
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
                                        contentPadding:
                                            const EdgeInsets.all(10),
                                        textInputType: TextInputType.name,
                                        textEditingController: searchControll,
                                        text:
                                            language[modeControll.LanguageValue]
                                                ["search"]),
                                  ),
                                ),
                              ),
                              TableWidget(
                                  titel: [
                                    language[modeControll.LanguageValue]
                                        ["titel"][0],
                                    language[modeControll.LanguageValue]
                                        ["titel"][1],
                                    language[modeControll.LanguageValue]
                                        ["titel"][2],
                                    language[modeControll.LanguageValue]
                                        ["titel"][3],
                                    language[modeControll.LanguageValue]
                                        ["titel"][4],
                                  ],
                                  data: [
                                    for (Details details in (storeController
                                            .listStoregProdact.value.details ??
                                        []))
                                      [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              height: 20,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  color:
                                                      (details.active ?? false)
                                                          ? Colors.green
                                                          : Colors.grey,
                                                  shape: BoxShape.circle),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Image.network(
                                              UrlData.imageUrl(
                                                  details.imageUrl ?? ""),
                                              height: 70,
                                              width: 70,
                                              errorBuilder:
                                                  (context, error, _) =>
                                                      const Icon(
                                                Icons
                                                    .image_not_supported_outlined,
                                                size: 32,
                                              ),
                                            ),
                                          ],
                                        ),
                                        TextUnit.TextsubTitel(
                                            text: details.name ?? ""),
                                        TextUnit.TextsubTitel(
                                            text: details.price.toString()),
                                        TextUnit.TextsubTitel(
                                            text: details.number.toString()),
                                        TextUnit.TextsubTitel(
                                            text: (details.exDate ?? "_")
                                                .split(' ')[0]),
                                      ]
                                  ],
                                  onTopRow: (int index) {
                                    storeController.putProdact(storeController
                                        .listStoregProdact
                                        .value
                                        .details![index]);
                                    storeController.isPutProdact(true);
                                    storeController.isAdd(true);
                                  }),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          )),
                      Positioned(
                          bottom: 10,
                          left: modeControll.LanguageValue ? 10 : null,
                          right: modeControll.LanguageValue ? null : 10,
                          child: FloatingActionButton(
                            backgroundColor: unitColor.bgColor,
                            onPressed: () {
                              prodactpageController.animateToPage(1,
                                  duration: const Duration(milliseconds: 600),
                                  curve: Curves.easeIn);
                            },
                            child: const Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          )),
                      if (storeController.isAdd.value)
                        PutProduct(
                            seve: (Map<String, dynamic> prodact) async {
                              storeController.isAdd(false);

                              await storeController.putProduct(
                                  product: prodact);
                              if (storeController
                                  .errorPopMessag.value.isNotEmpty) {
                                Messge.error(
                                    storeController.errorPopMessag.value,
                                    context);
                                storeController.errorPopMessag.value = "";
                              } else {
                                Messge.notification(
                                    language[modeControll.LanguageValue]["don"],
                                    context,
                                    color: Colors.greenAccent);
                                await storeController.getMyProduct();
                              }
                            },
                            delete: (String id) async {
                              storeController.isAdd(false);

                              await storeController.deleteProdact(id: id);
                              if (storeController
                                  .errorPopMessag.value.isNotEmpty) {
                                Messge.error(
                                    storeController.errorPopMessag.value,
                                    context);
                                storeController.errorPopMessag.value = "";
                              } else {
                                await storeController.getMyProduct();
                              }
                            },
                            clear: () {
                              storeController.isAdd(false);
                            },
                            putProdact: storeController.isPutProdact.value,
                            prodact: storeController.putProdact.value)
                    ]),
                  )
                : Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,
                    child: TextUnit.TextButtonSpcfic(
                        text: language[modeControll.LanguageValue]
                            ["synchroniz"],
                        color: unitColor.bgColor,
                        onTop: () {
                          pageController.animateToPage(5,
                              duration: const Duration(milliseconds: 600),
                              curve: Curves.easeIn);
                        }),
                  )),
      );
    });
  }
}
