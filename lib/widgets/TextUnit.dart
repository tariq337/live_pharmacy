import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import '../Unit/const.dart';

class TextUnit {
  static const String textFonts = "Almarai";

  static TextTitel(
          {required String text,
          Color? color,
          TextAlign? textAlign,
          int? maxLines}) =>
      AutoSizeText(
        text,
        minFontSize: 5,
        maxLines: maxLines,
        textAlign: textAlign,
        style: TextStyle(
            fontFamily: textFonts,
            fontSize: 17,
            color: color ??
                (modeControll.ThemeModeValue ? Colors.black : Colors.white),
            fontWeight: FontWeight.bold),
      );

  static TextNormle({required String text, Color? color, double? size}) => Text(
        text,
        style: TextStyle(
            fontFamily: textFonts,
            fontSize: size,
            color: color ??
                (modeControll.ThemeModeValue ? Colors.black : Colors.white),
            fontWeight: FontWeight.bold),
      );

  static TextButtonSpcfic(
          {required String text,
          Color? color,
          double? size,
          required Function onTop}) =>
      TextButton(
        onPressed: () {
          onTop();
        },
        child: AutoSizeText(
          text,
          minFontSize: 5,
          style: TextStyle(
              fontFamily: textFonts,
              fontSize: size ?? 15,
              color: color ??
                  (modeControll.ThemeModeValue ? Colors.black : Colors.white),
              fontWeight: FontWeight.bold),
        ),
      );
  static TextsubTitel(
          {required String text, Color? color, int? length, int? maxLines}) =>
      AutoSizeText(
        text.length >= (length ?? 0)
            ? (text.substring(0, length) + ((length ?? 0) > 0 ? ".." : ""))
            : text,
        minFontSize: 5,
        maxLines: maxLines,
        style: TextStyle(
            fontFamily: textFonts,
            fontSize: 15,
            color: color ??
                (modeControll.ThemeModeValue ? Colors.black54 : Colors.white54),
            fontWeight: FontWeight.bold),
      );

  static Textsub(
          {required String text, Color? color, double? size, int? maxLines}) =>
      AutoSizeText(
        text,
        minFontSize: 5,
        maxLines: maxLines,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontFamily: textFonts,
          fontSize: size ?? 14,
          color: color ??
              (modeControll.ThemeModeValue ? Colors.black45 : Colors.white38),
        ),
      );

  static Textspcfic(
          {required String text,
          int? maxLines,
          Color? color,
          double? size,
          TextAlign? textAlign,
          FontWeight? fontWeight}) =>
      AutoSizeText(
        text,
        maxLines: maxLines,
        minFontSize: 5,
        textAlign: textAlign,
        style: TextStyle(
          fontWeight: fontWeight,
          fontFamily: textFonts,
          fontSize: size ?? 13,
          color: color,
        ),
      );

  static SpanText(
      {required String FirstText,
      Color? SecntColor,
      required String SecntText,
      double? width,
      double? size,
      double? height}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: AutoSizeText(FirstText,
                textAlign: TextAlign.start,
                minFontSize: 1,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: textFonts,
                  fontSize: size ?? 13,
                  color: (modeControll.ThemeModeValue
                      ? Colors.black
                      : Colors.white),
                )),
          ),
          const AutoSizeText(" "),
          Expanded(
            child: AutoSizeText(SecntText,
                minFontSize: 1,
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: textFonts,
                  fontSize: size ?? 13,
                  color: SecntColor ??
                      (modeControll.ThemeModeValue
                          ? Colors.black
                          : Colors.white),
                )),
          ),
        ],
      ),
    );
  }
}
