import 'package:live_pharmacy/UI/Order/OrderBody.dart';
import 'package:live_pharmacy/UI/Order/OrderPurchasing.dart';
import 'package:live_pharmacy/Unit/unitColor.dart';
import 'package:live_pharmacy/controll/UserController.dart';
import 'package:drop_shadow/drop_shadow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_listener/flutter_barcode_listener.dart';
import 'package:get/get.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../Unit/Language.dart';
import '../../Unit/const.dart';
import '../../Unit/printable_data.dart';
import '../../controll/PurchasingController.dart';
import '../../controll/StoreController.dart';
import '../../widgets/Messge.dart';
import '../../widgets/TextFieldWidget.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  StoreController storeController = Get.put(StoreController());
  TextEditingController searchControll = TextEditingController();
  PurchasingController purchasingController = Get.put(PurchasingController());
  UserController userController = Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: double.infinity,
      child: Obx(() {
        return BarcodeKeyboardListener(
          bufferDuration: const Duration(milliseconds: 200),
          onBarcodeScanned: (barcode) {
            if (barcode == "-1") return;
            storeController.getByBarCode(barCode: barcode);
          },
          child: Column(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        flex: 7,
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
                                  child: TextFieldWidget(
                                      width: 700,
                                      widget: InkWell(
                                          onTap: () {
                                            if (searchControll.text.isEmpty) {
                                              storeController
                                                  .listOrderProdact([]);
                                            } else {
                                              storeController.searchByName(
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
                                ),
                              ),
                            ),
                            Expanded(
                              child: OrderBody(
                                AddtoCardItem: (Map<String, dynamic> map) {
                                  storeController.AddtoCard(map);
                                },
                                listOrderProdact:
                                    storeController.listOrderProdact.value,
                              ),
                            ),
                          ],
                        )),
                    Expanded(
                        flex: 3,
                        child: OrderPurchasing(
                          Add: (int index) {
                            storeController.Add(index);
                          },
                          Reduce: (int index) {
                            storeController.Reduce(index);
                          },
                          carts: storeController.carts.value,
                          removeAll: () {
                            storeController.removeAll();
                          },
                          print: (String phon) async {
                            List products = [];
                            Map<dynamic, dynamic> sales = {
                              "phoneNumber": phon,
                              "products": [],
                              "timestamp": DateTime.now().toString(),
                              "userName": userController.userItem.value.name
                            };
                            List data = [];
                            for (var element in storeController.carts.value) {
                              double mintotal =
                                  element["price"] * element["number"];
                              products
                                  .add([element["name"], element["number"]]);
                              data.add([
                                "الشفاء",
                                element["number"],
                                mintotal.toStringAsFixed(2)
                              ]);
                            }
                            sales["products"] = products;

                            await purchasingController.addPurchasing(
                                purchasing: sales);
                            await storeController.updateAllProdact(
                                prodacts: storeController.carts.value);
                            await printDoc(data,
                                storeController.getTotal().toStringAsFixed(2));
                            storeController.removeAll();
                            Messge.notification(
                                language[modeControll.LanguageValue]["don"],
                                context,
                                color: Colors.greenAccent);
                          },
                          total: storeController.getTotal().toStringAsFixed(2),
                        )),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Future<void> printDoc(List data, String total) async {
    final image = await imageFromAssetBundle(
      "assets/image/logo.png",
    );
    final font = await fontFromAssetBundle('assets/fonts/Amiri.ttf');
    final doc = pw.Document();
    doc.addPage(pw.Page(
        pageFormat: PdfPageFormat.roll80,
        build: (pw.Context context) {
          return buildPrintableData(image, data, total, font);
        }));
    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => doc.save(),
        name: DateTime.now().toString());
  }
}
