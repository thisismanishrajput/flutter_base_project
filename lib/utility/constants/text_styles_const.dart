import 'package:flutter/material.dart';

mixin TextStylesConst {
  static const String fontFamilyPrimary = 'Spartan';
  static const String fontFamilySemiBold = 'spartan_semi_bold';
  static const String fontFamilyBold = 'spartan_bold';
  static const double fontSize8 = 8.0;
  static const double fontSize9 = 9.0;
  static const double fontSize10 = 10.0;
  static const double fontSize11 = 11.0;
  static const double fontSize12 = 12.0;
  static const double fontSize13 = 13.0;
  static const double fontSize14 = 14.0;
  static const double fontSize15 = 15.0;
  static const double fontSize16 = 16.0;
  static const double fontSize17 = 17.0;
  static const double fontSize18 = 18.0;
  static const double fontSize20 = 20.0;
  static const double fontSize22 = 22.0;
  static const double fontSize23 = 23.0;
  static const double fontSize24 = 24.0;
  static const double fontSize25 = 25.0;
  static const double fontSize26 = 26.0;
  static const double fontSize28 = 28.0;
  static const double fontSize30 = 30.0;
  static const double fontSize34 = 34.0;
  static const double fontSize36 = 36.0;

  static const TextStyle whiteNormalText18 = TextStyle(
      fontSize: fontSize16,
      color: Colors.white,
      fontFamily: fontFamilyPrimary,
      fontWeight: FontWeight.w400);




  static TextStyle blackText20({FontWeight fontWeight = FontWeight.normal}) {
    return TextStyle(
        fontSize: fontSize20,
        fontFamily: fontFamilyPrimary,
        color: Colors.black,
        fontWeight: fontWeight);
  }
  static TextStyle blackText23({FontWeight fontWeight = FontWeight.normal}) {
    return TextStyle(
        fontSize: fontSize22,
        color: Colors.black,
        fontFamily: fontFamilySemiBold,
        fontWeight: fontWeight);
  }
  static TextStyle blackText26({FontWeight fontWeight = FontWeight.normal}) {
    return TextStyle(
        fontSize: fontSize26,
        color: Colors.black,
        fontFamily: fontFamilyBold,
        fontWeight: fontWeight);
  }
  static TextStyle whiteText14({FontWeight fontWeight = FontWeight.normal}) {
    return TextStyle(
        fontFamily: fontFamilyPrimary,
        fontSize: fontSize14,
        color: Colors.white,
        fontWeight: fontWeight);
  }
  static TextStyle grey18_500({FontWeight fontWeight = FontWeight.w500}) {

    return TextStyle(
        fontFamily: fontFamilyPrimary,
        fontSize: fontSize16,
        color: Colors.grey.shade600,
        fontWeight: fontWeight);
  }
}
