import 'package:live_pharmacy/Unit/const.dart';
import 'package:live_pharmacy/Unit/unitColor.dart';
import 'package:live_pharmacy/widgets/TextUnit.dart';
import 'package:flutter/material.dart';

class Messge {
  static error(String meg, context) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text(
            meg,
            textAlign:
                modeControll.LanguageValue ? TextAlign.end : TextAlign.start,
            style: const TextStyle(
                fontFamily: TextUnit.textFonts,
                fontSize: 17,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          )));

  static notification(meg, context, {Color? color}) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: color ?? unitColor.NEUTRAL[4],
          content: Text(
            meg,
            textAlign:
                modeControll.LanguageValue ? TextAlign.end : TextAlign.start,
            style: const TextStyle(
                fontFamily: TextUnit.textFonts,
                fontSize: 17,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          )));
}
