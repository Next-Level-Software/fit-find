import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/local/my_shared_pref.dart';
import '../translations/localization_service.dart';

// todo configure text family and size
class MyFonts {
  // return the right font depending on app language
  static TextStyle get getAppFontType =>
      LocalizationService.supportedLanguagesFontsFamilies[
          MySharedPref.getCurrentLocal().languageCode]!;

  // headlines text font
  static TextStyle get headlineTextStyle => getAppFontType;

  // body text font
  static TextStyle get bodyTextStyle => getAppFontType;

  // button text font
  static TextStyle get buttonTextStyle => getAppFontType;

  // app bar text font
  static TextStyle get appBarTextStyle => getAppFontType;

  // chips text font
  static TextStyle get chipTextStyle => getAppFontType;

  // appbar font size
  static double get appBarTittleSize => 18.sp;

  // body font size
  static double get body1TextSize => 13.sp;
  static double get body2TextSize => 13.sp;

  // headlines font size
  static double get headline1TextSize => 50.sp;
  static double get headline2TextSize => 40.sp;
  static double get headline3TextSize => 30.sp;
  static double get headline4TextSize => 25.sp;
  static double get headline5TextSize => 20.sp;
  static double get headline6TextSize => 17.sp;

  //button font size
  static double get buttonTextSize => 16.sp;

  //caption font size
  static double get captionTextSize => 13.sp;

  //chip font size
  static double get chipTextSize => 10.sp;

  static double get bodyLarge => 16.sp;
  static double get bodyMedium => 14.sp;
  static double get bodySmall => 12.sp;
  static double get displayLarge => 57.sp;
  static double get displayMedium => 45.sp;
  static double get displaySmall => 36.sp;
  static double get labelLarge => 14.sp;
  static double get labelMedium => 12.sp;
  static double get labelSmall => 10.sp;
  static double get titleLarge => 32.sp;
  static double get titleMedium => 28.sp;
  static double get titleSmall => 24.sp;
}
