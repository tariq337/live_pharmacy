import 'package:live_pharmacy/Unit/Language.dart';
import 'package:live_pharmacy/Unit/const.dart';
import 'package:live_pharmacy/Unit/unitColor.dart';
import 'package:live_pharmacy/widgets/TextFieldWidget.dart';
import 'package:live_pharmacy/widgets/TextUnit.dart';
import 'package:drop_shadow/drop_shadow.dart';
import 'package:flutter/material.dart';

import '../../widgets/CartItem.dart';
import '../../widgets/TextEditingDialog.dart';

class OrderPurchasing extends StatefulWidget {
  List<Map<String, dynamic>> carts;
  String total;
  Function(int) Reduce;
  Function(int) Add;
  Function() removeAll;
  Function(String, String) print;

  OrderPurchasing(
      {super.key,
      required this.Add,
      required this.print,
      required this.Reduce,
      required this.carts,
      required this.removeAll,
      required this.total});

  @override
  State<OrderPurchasing> createState() => _OrderPurchasingState();
}

class _OrderPurchasingState extends State<OrderPurchasing> {
  final TextEditingController _controller = TextEditingController();
  TextEditingController controller = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      padding: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
          color: unitColor.NEUTRAL[4], borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextUnit.TextTitel(
                    text: language[modeControll.LanguageValue]["listSales"]),
                widget.carts.isNotEmpty
                    ? GestureDetector(
                        onTap: () {
                          widget.removeAll();
                          controller.text = "";
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.red.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(15)),
                          child: const Icon(
                            Icons.close,
                            color: Colors.red,
                          ),
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          ),
          const SizedBox(height: 10),
          widget.carts.isNotEmpty
              ? Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            verticalDirection: VerticalDirection.up,
                            children: [
                              ...List.generate(widget.carts.length, (index) {
                                Map<String, dynamic> cart = widget.carts[index];
                                return CartItem(
                                  onAdd: () {
                                    widget.Add(index);
                                  },
                                  onReduce: () {
                                    widget.Reduce(index);
                                  },
                                  cart: cart,
                                );
                              })
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      DropShadow(
                        blurRadius: 4,
                        offset: const Offset(0, 4),
                        color: unitColor.bgColor.withOpacity(.4),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
                          decoration: BoxDecoration(
                            color: unitColor.NEUTRAL[3],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              TextFieldWidget(
                                  onchanged: (v) {
                                    setState(() {});
                                  },
                                  textInputType: TextInputType.number,
                                  textEditingController: controller,
                                  text: language[modeControll.LanguageValue]
                                      ["Reduction"]),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextUnit.TextTitel(
                                    text: language[modeControll.LanguageValue]
                                        ['total'],
                                  ),
                                  TextUnit.TextTitel(
                                    text:
                                        'SD ${(double.parse(widget.total) - (double.parse(widget.total) * int.parse(controller.text == "" ? "0" : controller.text) / 100)).toStringAsFixed(2)}',
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              InkWell(
                                onTap: () async {
                                  bool chick = false;
                                  await TextEditingDialog(
                                      context: context,
                                      title:
                                          language[modeControll.LanguageValue]
                                              ["auth"][1],
                                      hintText:
                                          language[modeControll.LanguageValue]
                                              ["auth"][1],
                                      controller: _controller,
                                      onClickOK: (String num) {
                                        _controller.text = num;
                                        chick = true;
                                        Navigator.of(context).pop();
                                      },
                                      onClickNotOK: () {
                                        _controller.text = "0";
                                        chick = false;

                                        Navigator.of(context).pop();
                                      });
                                  if (controller.text.isEmpty) {
                                    controller.text = "";
                                  }
                                  widget.print(
                                      validatePhoneNumber(_controller.text),
                                      controller.text);
                                  controller.text = "";
                                },
                                child: Container(
                                  width: double.infinity,
                                  alignment: Alignment.center,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 15),
                                  decoration: BoxDecoration(
                                      color: unitColor.bgColor,
                                      borderRadius: BorderRadius.circular(15),
                                      boxShadow: [
                                        BoxShadow(
                                            color: unitColor.bgColor
                                                .withOpacity(0.3),
                                            offset: const Offset(0, 10),
                                            spreadRadius: 0,
                                            blurRadius: 10)
                                      ]),
                                  child: TextUnit.TextTitel(
                                      text: language[modeControll.LanguageValue]
                                          ["print"],
                                      color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
              : const Expanded(
                  child: Center(
                      child: Icon(
                  Icons.remove_shopping_cart_outlined,
                  size: 57,
                  color: Colors.black45,
                ))),
        ],
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
