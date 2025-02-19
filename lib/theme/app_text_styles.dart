import 'package:flutter/material.dart';

// All app text font size
class FontSize {
  static double font30 = 30;
  static double font24 = 24;
  static double font20 = 20;
  static double font18 = 18;
  static double font16 = 16;
  static double font14 = 14;
  static double font13 = 13;
  static double font12 = 12.5;
  static double font10 = 10;
}

// all App label to input or checkbox
Widget appLabel(String text) => Text(
      text,
      style: AppTextStyle.bold(FontWeight.w400, fontSize: FontSize.font12),
    );

// All app text Style
class AppTextStyle {
  static String boldFamilyFont = 'Satoshi-Bold';
  static String mediumFamilyFont = 'Satoshi-Medium';
  static String lightFamilyFont = 'Satoshi-Light';

  static TextStyle bold(FontWeight fontWeight,
      {double? fontSize, Color color = const Color.fromARGB(255, 13, 14, 13)}) {
    return TextStyle(
      color: color,
      fontFamily: boldFamilyFont,
      fontWeight: fontWeight,
      fontSize: fontSize ?? FontSize.font24,
    );
  }

  static TextStyle medium(FontWeight fontWeight,
      {double? fontSize, Color color = const Color.fromARGB(255, 13, 14, 13)}) {
    return TextStyle(
      color: color,
      fontFamily: mediumFamilyFont,
      fontWeight: fontWeight,
      fontSize: fontSize ?? FontSize.font16,
    );
  }

  static TextStyle light(FontWeight fontWeight,
      {double? fontSize, Color color = const Color.fromARGB(255, 13, 14, 13)}) {
    return TextStyle(
      color: color,
      fontFamily: lightFamilyFont,
      fontWeight: fontWeight,
      fontSize: fontSize ?? FontSize.font16,
    );
  }
}




// class AppTextStyles {
  // static TextStyle heading = GoogleFonts.raleway(
  //   fontSize: 18,
  //   fontWeight: FontWeight.bold,
  // );

  // static TextStyle subHeading = GoogleFonts.raleway(
  //   fontSize: 16,
  //   fontWeight: FontWeight.w600,
  // );

  // static TextStyle body = GoogleFonts.raleway(
  //   fontSize: 14,
  // );

  // static TextStyle small = GoogleFonts.raleway(
  //   fontSize: 12,
  //   color: AppColors.black,
  // );
// }
