import 'package:live_pharmacy/Unit/Language.dart';
import 'package:live_pharmacy/Unit/UrlData.dart';
import 'package:live_pharmacy/Unit/const.dart';
import 'package:live_pharmacy/Unit/unitColor.dart';
import 'package:live_pharmacy/widgets/LoadeingPopWidget.dart';
import 'package:live_pharmacy/widgets/TextFieldWidget.dart';
import 'package:live_pharmacy/widgets/TextUnit.dart';
import 'package:drop_shadow/drop_shadow.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../controll/StoreController.dart';
import '../../model/ProductModel.dart';
import '../../widgets/TableWidget.dart';
import '../Unit/print_product.dart';
import '../widgets/TextEditingDialog.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({
    super.key,
  });

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  StoreController storeController = Get.put(StoreController());
  TextEditingController numberControll =
      TextEditingController(text: 10.toString());
  TextEditingController dateControll = TextEditingController();
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    storeController.getAlarmProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: unitColor.NEUTRAL[4],
          borderRadius: BorderRadius.circular(20),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: LoadeingPopWidget(
            isLoadeing: storeController.isLoading.value,
            error: storeController.errorMessag.value,
            reloade: () {
              storeController.runLoadeing();
              storeController.getAlarmProduct();
            },
            child: Container(
                padding: const EdgeInsets.all(16),
                alignment: Alignment.topCenter,
                child: ListView(
                  children: [
                    Align(
                      alignment: modeControll.LanguageValue
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Row(
                        children: [
                          DropShadow(
                            blurRadius: 4,
                            offset: const Offset(0, 4),
                            color: unitColor.bgColor.withOpacity(.4),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 20),
                              child: TextFieldWidget(
                                  width: 200,
                                  widget: InkWell(
                                      onTap: () async {
                                        storeController.runLoadeing();

                                        if (numberControll.text.isNotEmpty) {
                                          await storeController.getAlarmProduct(
                                              number: int.parse(
                                                  numberControll.text));
                                        } else {
                                          await storeController
                                              .getAlarmProduct();
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
                                  textEditingController: numberControll,
                                  text: language[modeControll.LanguageValue]
                                      ["titel"][3]),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          DropShadow(
                            blurRadius: 4,
                            offset: const Offset(0, 4),
                            color: unitColor.bgColor.withOpacity(.4),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 20),
                              child: TextFieldWidget(
                                  width: 200,
                                  widget: InkWell(
                                      onTap: () async {
                                        if (dateControll.text.isNotEmpty) {
                                          await storeController
                                              .getAlarmDateProduct(
                                                  number: int.parse(
                                                      dateControll.text));
                                        } else {
                                          await storeController
                                              .getAlarmProduct();
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
                                  textEditingController: dateControll,
                                  text: language[modeControll.LanguageValue]
                                      ["titel"][4]),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          InkWell(
                              onTap: () async {
                                List<String> data = [];
                                for (Details details in (storeController
                                        .listnotificationProdact
                                        .value
                                        .details ??
                                    [])) {
                                  data.add(details.name ?? "");
                                }
                                bool chick = false;
                                await TextEditingDialog(
                                    context: context,
                                    title: language[modeControll.LanguageValue]
                                        ["doctitel"],
                                    hintText:
                                        language[modeControll.LanguageValue]
                                            ["doctitel"],
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

                                await _printDoc(data, _controller.text);
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 10),
                                decoration: BoxDecoration(
                                    color: unitColor.bgColor,
                                    borderRadius: BorderRadius.circular(7)),
                                child: const Icon(
                                  Icons.print,
                                  size: 27,
                                  color: Colors.white,
                                ),
                              ))
                        ],
                      ),
                    ),
                    TableWidget(titel: [
                      language[modeControll.LanguageValue]["titel"][0],
                      language[modeControll.LanguageValue]["titel"][1],
                      language[modeControll.LanguageValue]["titel"][2],
                      language[modeControll.LanguageValue]["titel"][3],
                      language[modeControll.LanguageValue]["titel"][4],
                    ], data: [
                      for (Details details in (storeController
                              .listnotificationProdact.value.details ??
                          []))
                        [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                    color: (details.active ?? false)
                                        ? Colors.green
                                        : Colors.grey,
                                    shape: BoxShape.circle),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Image.network(
                                UrlData.imageUrl(details.imageUrl ?? ""),
                                height: 70,
                                width: 70,
                              ),
                            ],
                          ),
                          TextUnit.TextsubTitel(text: details.name ?? ""),
                          TextUnit.TextsubTitel(text: details.price.toString()),
                          TextUnit.TextsubTitel(
                              text: details.number.toString()),
                          TextUnit.TextsubTitel(
                              text: (details.exDate ?? "_").split(' ')[0]),
                        ]
                    ], onTopRow: (int index) {}),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                )),
          ),
        ),
      );
    });
  }

  Future<void> _printDoc(List data, String total) async {
    // final image = await imageFromAssetBundle(
    // "assets/image/logo.png",
    // );
    final font = await fontFromAssetBundle('assets/fonts/Amiri.ttf');
    final doc = pw.Document();
    doc.addPage(pw.Page(
        pageFormat: PdfPageFormat.roll80,
        build: (pw.Context context) {
          return buildPrintableProduct(
              //image,
              data,
              total,
              font);
        }));
    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => doc.save(),
        name: DateTime.now().toString());
  }
}
