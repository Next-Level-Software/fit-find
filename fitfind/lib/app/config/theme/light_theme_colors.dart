import 'package:flutter/material.dart';

class LightThemeColors {
  //dark swatch
  // static const Color primaryColor = Color(0xFF6b63ff);

  static Color customPrimaryColor = const Color(0xFF00ADAE);
  // static Color customPrimaryColor = const Color(0xFF34c38f);
  // static Color customPrimaryColor = const Color(0xFF69b52e);
  static Color customSecondaryColor = const Color(0xFF27D3EE);

  static Color primaryColor = customPrimaryColor;
  static Color accentColor = primaryColor;

  //APPBAR
  // static Color appBarColor = const Color(0xFFe65203);
  static Color appBarColor = scaffoldBackgroundColor;
  static const Color shadowColor = Color(0xFF101828);

  //SCAFFOLD
  static const Color scaffoldBackgroundColor = Color(0xFFFFFFFF); //? White
  static const Color scaffoldBackgroundColorLightGey = Color(0xFFF9F9F9); //? Light Gray
  // static const Color scaffoldBackgroundColor = Color(F8F8F8); //? Off-White
  // static const Color scaffoldBackgroundColor = Color(0xFFF7F8FA); //? Light Blue
  // static const Color scaffoldBackgroundColor = Color(0xFFEDEDED); //? Pale Gray
  // static const Color scaffoldBackgroundColor = Color(0xFFF0F0F0); //? Light Gray
  // static const Color scaffoldBackgroundColor = Color(0xFFFAFAFA); //? Off white
  // static const Color scaffoldBackgroundColor = Color(0xFFF4F4F4);

  static const Color backgroundColor = Colors.white;
  static const Color dividerColor = Color(0xffD2D3D6);
  static const Color cardColor = Color(0xffffffff);

  //ICONS
  static Color appBarIconsColor = Color(0xFF595959);
  static const Color iconColor = Color(0xFF595959);

  //BUTTON
  static Color buttonColor = primaryColor;
  static const Color buttonTextColor = Color(0xFF595959);
  static const Color buttonDisabledColor = Colors.grey;
  static const Color buttonDisabledTextColor = Color(0xFF595959);

  //TEXT
  static const Color bodyTextColor = Color(0xFF595959);
  static const Color headlinesTextColor = Color(0xFF595959);
  static const Color captionTextColor = Colors.grey;
  static const Color hintTextColor = Color(0xff686868);

  //chip
  static Color chipBackground = primaryColor;
  static const Color chipTextColor = Color(0xFF595959);

  // progress bar indicator
  // static const Color progressIndicatorColor = Color(0xFF40A76A);
  static Color progressIndicatorColor = primaryColor;
}
