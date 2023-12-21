import 'package:live_pharmacy/Unit/const.dart';

import 'package:live_pharmacy/widgets/TextUnit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget TextFieldWidget(
    {required TextInputType textInputType,
    int? length,
    int? max,
    double? circle,
    Color? color,
    double? height,
    double? width,
    bool? border,
    double? size,
    bool? circleBorder,
    EdgeInsetsGeometry? contentPadding,
    Widget? widget,
    List<TextInputFormatter>? inputFormatters,
    void Function()? ontap,
    void Function(String)? onchanged,
    String? Function(String?)? validator,
    bool? obscureText,
    required TextEditingController textEditingController,
    required String text}) {
  return Container(
      height: height,
      width: width,
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.all(0),
      child: TextFormField(
          scrollPadding: const EdgeInsets.all(0),
          inputFormatters: inputFormatters,
          onTap: ontap,
          onChanged: onchanged,
          controller: textEditingController,
          keyboardType: textInputType,
          obscureText: obscureText ?? false,
          minLines: length,
          maxLines: length,
          maxLength: max,
          validator: validator,
          style: TextStyle(
              fontSize: size,
              fontFamily: TextUnit.textFonts,
              color: modeControll.ThemeModeValue
                  ? Colors.black54
                  : Colors.white54),
          decoration: InputDecoration(
              contentPadding: contentPadding ??
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              errorStyle: const TextStyle(
                fontFamily: TextUnit.textFonts,
                color: Colors.redAccent,
              ),
              icon: widget,
              suffix: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: InkWell(
                  onTap: () {
                    textEditingController.text = "";
                  },
                  child: const Icon(
                    Icons.clear,
                    size: 15,
                  ),
                ),
              ),
              hintStyle: TextStyle(
                  fontFamily: TextUnit.textFonts,
                  fontSize: size ?? 13,
                  color: modeControll.ThemeModeValue
                      ? Colors.black54
                      : Colors.white54),
              hintText: text,
              enabledBorder: (border ?? false)
                  ? (circleBorder ?? false)
                      ? OutlineInputBorder(
                          borderRadius: BorderRadius.circular(circle ?? 7),
                          borderSide:
                              const BorderSide(color: Colors.transparent))
                      : null
                  : InputBorder.none,
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(circle ?? 7),
                  borderSide:
                      const BorderSide(color: Colors.redAccent, width: .3)),
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(circle ?? 7),
                  borderSide:
                      const BorderSide(color: Colors.redAccent, width: .3)),
              focusedBorder: (border ?? false)
                  ? (circleBorder ?? false)
                      ? OutlineInputBorder(
                          borderRadius: BorderRadius.circular(circle ?? 7),
                          borderSide:
                              const BorderSide(color: Colors.transparent))
                      : null
                  : InputBorder.none,
              filled: true,
              hoverColor: color,
              fillColor: color ?? const Color(0x07000000))));
}




  /* return SizedBox(
    width: width,
    height: height,
    child: Column(
      children: [
        Expanded(
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: color,
                border: (border ?? false)
                    ? null
                    : Border.all(color: Colors.black12, width: 1),
                borderRadius: BorderRadius.circular(4)),
            child: TextFormField(
                onTap: ontap,
                onChanged: onchanged,
                controller: textEditingController,
                keyboardType: textInputType,
                minLines: length,
                maxLines: length,
                maxLength: max,
                validator: validator,
                style: TextStyle(
                    fontSize: TextInputType.phone == textInputType ? 12 : null,
                    fontFamily: TextUnit.textFonts,
                    color: Colors.black54),
                decoration: InputDecoration(
                  errorStyle: TextStyle(
                    fontSize: TextInputType.phone == textInputType ? 12 : null,
                    fontFamily: TextUnit.textFonts,
                    color: classColors.STATICS[3],
                  ),
                  icon: widget,
                  suffix: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: InkWell(
                      onTap: () {
                        textEditingController.text = "";
                      },
                      child: const Icon(
                        Icons.clear,
                        size: 15,
                      ),
                    ),
                  ),
                  labelStyle: const TextStyle(
                      fontFamily: TextUnit.textFonts,
                      fontSize: 13,
                      color: Colors.black54),
                  labelText: text,
                  border: (border ?? false)
                      ? (circleBorder ?? false)
                          ? const OutlineInputBorder()
                          : null
                      : InputBorder.none,
                )),
          ),
        ),
      ],
    ),
  ); */

