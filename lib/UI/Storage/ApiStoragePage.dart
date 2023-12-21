import 'dart:developer';

import 'package:live_pharmacy/Unit/unitColor.dart';
import 'package:live_pharmacy/model/ProductModel.dart';
import 'package:live_pharmacy/widgets/Messge.dart';
import 'package:live_pharmacy/widgets/TextUnit.dart';
import 'package:drop_shadow/drop_shadow.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Unit/Language.dart';
import '../../Unit/const.dart';
import '../../controll/StoreController.dart';
import '../../widgets/ProductItem.dart';
import '../../widgets/TextEditingDialog.dart';
import '../../widgets/TextFieldWidget.dart';

class ApiStoragePage extends StatefulWidget {
  const ApiStoragePage({super.key});

  @override
  State<ApiStoragePage> createState() => _ApiStoragePageState();
}

class _ApiStoragePageState extends State<ApiStoragePage> {
  StoreController storeController = Get.find<StoreController>();
  TextEditingController searchControll = TextEditingController();
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Obx(() {
        return ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            height: double.infinity,
            color: unitColor.NEUTRAL[3],
            padding: const EdgeInsets.all(10),
            child: Column(
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
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                prodactpageController.animateToPage(0,
                                    duration: const Duration(milliseconds: 600),
                                    curve: Curves.easeIn);
                              },
                              icon: const Icon(
                                Icons.arrow_back,
                                size: 31,
                              )),
                          TextFieldWidget(
                              width: 700,
                              widget: InkWell(
                                  onTap: () {
                                    if (searchControll.text.isNotEmpty) {
                                      storeController.searchAPIByName(
                                          name: searchControll.text);
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
                              text: language[modeControll.LanguageValue]
                                  ["search"]),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: storeController.isLoading.value
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : storeController.isLoading.value
                            ? Center(
                                child: TextUnit.TextTitel(
                                    text: storeController.errorMessag.value,
                                    color: Colors.redAccent),
                              )
                            : (storeController.apiProducts.value.details ?? [])
                                    .isEmpty
                                ? const Center(
                                    child: Icon(
                                      Icons.grid_off_outlined,
                                      size: 55,
                                      color: Colors.black38,
                                    ),
                                  )
                                : GridView.builder(
                                    shrinkWrap: true,
                                    itemCount: (storeController
                                                .apiProducts.value.details ??
                                            [])
                                        .length,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 5,
                                      crossAxisSpacing: 16,
                                      mainAxisSpacing: 16,
                                      childAspectRatio: .8,
                                    ),
                                    itemBuilder: (BuildContext context, index) {
                                      Details product = (storeController
                                              .apiProducts.value.details ??
                                          [])[index];
                                      return InkWell(
                                        onTap: () async {
                                          bool chick = false;
                                          await TextEditingDialog(
                                              context: context,
                                              title: product.name ?? "",
                                              hintText: language[modeControll
                                                  .LanguageValue]["dialog"][2],
                                              controller: _controller,
                                              onClickOK: (String num) {
                                                _controller.text = num;
                                                chick = true;
                                                Navigator.of(context).pop();
                                              },
                                              onClickNotOK: () {
                                                chick = false;
                                                Navigator.of(context).pop();
                                              });

                                          if (chick) {
                                            product.number =
                                                int.parse(_controller.text);
                                            log(product.toJson().toString());

                                            await storeController.setProduct(
                                                product: product.toJson());
                                            if (storeController.errorPopMessag
                                                .value.isNotEmpty) {
                                              Messge.error(
                                                  storeController
                                                      .errorPopMessag.value,
                                                  this.context);
                                              storeController
                                                  .errorMessag.value = "";
                                            } else {
                                              Messge.notification(
                                                  language[modeControll
                                                      .LanguageValue]["don"],
                                                  this.context,
                                                  color: Colors.greenAccent);
                                            }
                                          }
                                        },
                                        child: ProductItem(
                                          api: true,
                                          name: product.name ?? "",
                                          image: product.imageUrl ?? "",
                                          price: product.price ?? 0,
                                        ),
                                      );
                                    }),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
