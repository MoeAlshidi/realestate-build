import 'package:flutter/material.dart';

class CustomColors {
  static const KmainColor = Color(0xff3478D1);
  static const KredColor = Color(0xffD9552A);
}

class CustomTextStyle {
  static const KHeaders = TextStyle(
    color: CustomColors.KmainColor,
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );
  static const KHugeFormLabes = TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.w700,
    color: Color(0xff0E3D63),
  );
  static const KsmallReg = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );
}
