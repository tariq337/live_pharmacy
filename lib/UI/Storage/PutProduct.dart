import 'package:live_pharmacy/Unit/Language.dart';
import 'package:live_pharmacy/Unit/const.dart';
import 'package:live_pharmacy/Unit/unitColor.dart';
import 'package:live_pharmacy/model/ProductModel.dart';
import 'package:live_pharmacy/widgets/TextFieldWidget.dart';
import 'package:live_pharmacy/widgets/TextUnit.dart';
import 'package:flutter/material.dart';

import '../../Unit/UrlData.dart';

class PutProduct extends StatefulWidget {
  bool putProdact;
  Details prodact;
  Function(Map<String, dynamic>) seve;
  Function(String id) delete;
  void Function() clear;

  PutProduct(
      {super.key,
      required this.delete,
      required this.putProdact,
      required this.clear,
      required this.prodact,
      required this.seve});

  @override
  State<PutProduct> createState() => _PutProductState();
}

class _PutProductState extends State<PutProduct> {
  TextEditingController numberEditing = TextEditingController();
  DateTime? _currentDate;
  bool active = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    numberEditing.text = (widget.prodact.number ?? 0).toString();
    _currentDate =
        DateTime.parse(widget.prodact.exDate ?? "2023-12-13 10:30:00");
    active = widget.prodact.active ?? false;
  }

  Future<void> _pickDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _currentDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null && pickedDate != _currentDate) {
      setState(() {
        _currentDate = pickedDate;
        widget.prodact.exDate = _currentDate.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.black.withOpacity(.3),
      ),
      child: Container(
          width: 400,
          height: MediaQuery.of(context).size.height * .8,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: unitColor.NEUTRAL[4],
              borderRadius: BorderRadius.circular(7)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          widget.clear();
                        },
                        icon: const Icon(
                          Icons.clear,
                          size: 17,
                        )),
                    IconButton(
                        onPressed: () {
                          widget.delete(widget.prodact.id ?? "");
                        },
                        icon: const Icon(
                          Icons.delete,
                          size: 27,
                          color: Colors.redAccent,
                        )),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(11),
                  child: Image.network(
                    UrlData.imageUrl(widget.prodact.imageUrl ?? ""),
                    width: 120,
                    height: 120,
                    errorBuilder: (Context, _, __) => SizedBox(
                      width: 120,
                      height: 120,
                      child: Icon(
                        Icons.image_not_supported,
                        color: unitColor.NEUTRAL[1],
                        size: 61,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextUnit.SpanText(
                  FirstText: language[modeControll.LanguageValue]["product"][0],
                  SecntText: widget.prodact.name ?? ""),
              const Divider(),
              TextUnit.SpanText(
                  FirstText: language[modeControll.LanguageValue]["product"][1],
                  SecntText: widget.prodact.price.toString()),
              const Divider(),
              TextUnit.SpanText(
                  FirstText: language[modeControll.LanguageValue]["product"][5],
                  SecntText: widget.prodact.barCode ?? ""),
              const Spacer(),
              SizedBox(
                width: 250,
                child: SwitchListTile.adaptive(
                  value: active,
                  onChanged: (v) {
                    setState(() {
                      active = v;
                    });
                  },
                  secondary: TextUnit.TextsubTitel(
                      text: language[modeControll.LanguageValue]["product"][6]),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.center,
                child: TextFieldWidget(
                    width: 250,
                    textInputType: TextInputType.number,
                    textEditingController: numberEditing,
                    text: language[modeControll.LanguageValue]["product"][2],
                    circleBorder: true,
                    border: true),
              ),
              const SizedBox(
                height: 10,
              ),
              Align(
                  alignment: Alignment.center,
                  child: TextUnit.TextButtonSpcfic(
                      text: (widget.prodact.exDate ?? "0000-00-00 00:00:00"),
                      onTop: () async {
                        await _pickDate();
                      },
                      color: (widget.prodact.exDate ?? "").isNotEmpty
                          ? Colors.blueAccent
                          : Colors.grey)),
              const Spacer(),
              Align(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () {
                    widget.seve({
                      "active": active,
                      "id": widget.prodact.id,
                      "number": int.parse(numberEditing.text),
                      "exDate": widget.prodact.exDate.toString()
                    });
                  },
                  child: Container(
                    width: 300,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color: unitColor.bgColor,
                        borderRadius: BorderRadius.circular(7)),
                    child: TextUnit.TextsubTitel(
                        text: language[modeControll.LanguageValue]["next"],
                        color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              )
            ],
          )),
    );
  }
}
