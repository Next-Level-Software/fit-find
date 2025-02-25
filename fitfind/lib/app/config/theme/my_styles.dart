import 'package:flutter/material.dart';
// import 'package:sizer/sizer.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/app/constants/app_constants.dart';

import 'dark_theme_colors.dart';
import 'my_fonts.dart';
import 'light_theme_colors.dart';

class MyStyles {
  ///icons theme
  static IconThemeData getIconTheme({required bool isLightTheme}) =>
      IconThemeData(
        color: isLightTheme
            ? LightThemeColors.iconColor
            : DarkThemeColors.iconColor,
      );

  /// input theme
  static InputDecorationTheme getInputTheme({required bool isLightTheme}) =>
      InputDecorationTheme(
        prefixIconColor: isLightTheme
            ? LightThemeColors.primaryColor
            : DarkThemeColors.primaryColor,
        suffixIconColor: isLightTheme
            ? LightThemeColors.primaryColor
            : DarkThemeColors.primaryColor,
        focusColor: isLightTheme
            ? LightThemeColors.primaryColor
            : DarkThemeColors.primaryColor,
      );

  ///app bar theme
  static AppBarTheme getAppBarTheme({required bool isLightTheme}) =>
      AppBarTheme(
        elevation: 0,
        foregroundColor: isLightTheme
            ? LightThemeColors.appBarIconsColor
            : DarkThemeColors.appBarIconsColor,
        toolbarTextStyle:
            getTextTheme(isLightTheme: isLightTheme).bodyLarge!.copyWith(
                  color: isLightTheme
                      ? LightThemeColors.appBarIconsColor
                      : DarkThemeColors.appBarIconsColor,
                  fontSize: MyFonts.appBarTittleSize,
                ),
        titleTextStyle:
            getTextTheme(isLightTheme: isLightTheme).titleLarge!.copyWith(
                  color: isLightTheme
                      ? LightThemeColors.appBarIconsColor
                      : DarkThemeColors.appBarIconsColor,
                  fontSize: MyFonts.appBarTittleSize,
                ),
        centerTitle: true,
        actionsIconTheme: IconThemeData(
          color: isLightTheme
              ? LightThemeColors.appBarIconsColor
              : DarkThemeColors.appBarIconsColor,
        ),
        iconTheme: IconThemeData(
          color: isLightTheme
              ? LightThemeColors.appBarIconsColor
              : DarkThemeColors.appBarIconsColor,
        ),
        backgroundColor: isLightTheme
            ? LightThemeColors.appBarColor
            : DarkThemeColors.appBarColor,
      );

  ///text theme
  static TextTheme getTextTheme({required bool isLightTheme}) => TextTheme(
        bodyLarge: MyFonts.bodyTextStyle.copyWith(
          fontSize: MyFonts.bodyLarge,
        ),
        bodyMedium: MyFonts.bodyTextStyle.copyWith(
          fontSize: MyFonts.bodyMedium,
        ),
        bodySmall: MyFonts.bodyTextStyle.copyWith(
          fontSize: MyFonts.bodySmall,
          color: AppColors.primaryBlackColor,
        ),
        displayLarge: MyFonts.headlineTextStyle.copyWith(
          fontSize: MyFonts.displayLarge,
        ),
        displayMedium: MyFonts.headlineTextStyle.copyWith(
          fontSize: MyFonts.displayMedium,
        ),
        displaySmall: MyFonts.headlineTextStyle.copyWith(
          fontSize: MyFonts.displaySmall,
        ),
        labelLarge: MyFonts.bodyTextStyle.copyWith(
          fontSize: MyFonts.labelLarge,
        ),
        labelMedium: MyFonts.bodyTextStyle.copyWith(
          fontSize: MyFonts.labelMedium,
        ),
        labelSmall: MyFonts.bodyTextStyle.copyWith(
          fontSize: MyFonts.labelSmall,
        ),
        titleLarge: MyFonts.bodyTextStyle.copyWith(
          fontSize: MyFonts.titleLarge,
        ),
        titleMedium: MyFonts.bodyTextStyle.copyWith(
          fontSize: MyFonts.titleMedium,
        ),
        titleSmall: MyFonts.bodyTextStyle.copyWith(
          fontSize: MyFonts.titleSmall,
        ),
        // button:
        //     MyFonts.buttonTextStyle.copyWith(fontSize: MyFonts.buttonTextSize),
        // bodyText1: (MyFonts.bodyTextStyle).copyWith(
        //   fontWeight: FontWeight.bold,
        //   fontSize: MyFonts.body1TextSize,
        //   color: isLightTheme
        //       ? LightThemeColors.bodyTextColor
        //       : DarkThemeColors.bodyTextColor,
        // ),
        // bodyText2: (MyFonts.bodyTextStyle).copyWith(
        //   fontSize: MyFonts.body2TextSize,
        //   color: isLightTheme
        //       ? LightThemeColors.bodyTextColor
        //       : DarkThemeColors.bodyTextColor,
        // ),
        // headline1: (MyFonts.headlineTextStyle).copyWith(
        //   fontSize: MyFonts.headline1TextSize,
        //   fontWeight: FontWeight.bold,
        //   color: isLightTheme
        //       ? LightThemeColors.headlinesTextColor
        //       : DarkThemeColors.headlinesTextColor,
        // ),
        // headline2: (MyFonts.headlineTextStyle).copyWith(
        //   fontSize: MyFonts.headline2TextSize,
        //   fontWeight: FontWeight.bold,
        //   color: isLightTheme
        //       ? LightThemeColors.headlinesTextColor
        //       : DarkThemeColors.headlinesTextColor,
        // ),
        // headline3: (MyFonts.headlineTextStyle).copyWith(
        //   fontSize: MyFonts.headline3TextSize,
        //   fontWeight: FontWeight.bold,
        //   color: isLightTheme
        //       ? LightThemeColors.headlinesTextColor
        //       : DarkThemeColors.headlinesTextColor,
        // ),
        // headline4: (MyFonts.headlineTextStyle).copyWith(
        //   fontSize: MyFonts.headline4TextSize,
        //   fontWeight: FontWeight.bold,
        //   color: isLightTheme
        //       ? LightThemeColors.headlinesTextColor
        //       : DarkThemeColors.headlinesTextColor,
        // ),
        // headline5: (MyFonts.headlineTextStyle).copyWith(
        //   fontSize: MyFonts.headline5TextSize,
        //   fontWeight: FontWeight.bold,
        //   color: isLightTheme
        //       ? LightThemeColors.headlinesTextColor
        //       : DarkThemeColors.headlinesTextColor,
        // ),
        // headline6: (MyFonts.headlineTextStyle).copyWith(
        //   fontSize: MyFonts.headline6TextSize,
        //   fontWeight: FontWeight.bold,
        //   color: isLightTheme
        //       ? LightThemeColors.headlinesTextColor
        //       : DarkThemeColors.headlinesTextColor,
        // ),
        // caption: TextStyle(
        //   color: isLightTheme
        //       ? LightThemeColors.captionTextColor
        //       : DarkThemeColors.captionTextColor,
        //   fontSize: MyFonts.captionTextSize,
        // ),
      );

  static ChipThemeData getChipTheme({required bool isLightTheme}) {
    return ChipThemeData(
      backgroundColor: isLightTheme
          ? LightThemeColors.chipBackground
          : DarkThemeColors.chipBackground,
      brightness: Brightness.light,
      labelStyle: getChipTextStyle(isLightTheme: isLightTheme),
      secondaryLabelStyle: getChipTextStyle(isLightTheme: isLightTheme),
      selectedColor: Colors.black,
      disabledColor: Colors.green,
      padding: EdgeInsets.all(5),
      secondarySelectedColor: Colors.purple,
    );
  }

  ///Chips text style
  static TextStyle getChipTextStyle({required bool isLightTheme}) {
    return MyFonts.chipTextStyle.copyWith(
      fontSize: MyFonts.chipTextSize,
      color: isLightTheme
          ? LightThemeColors.chipTextColor
          : DarkThemeColors.chipTextColor,
    );
  }

  // elevated button text style
  static WidgetStateProperty<TextStyle?>? getElevatedButtonTextStyle(
      bool isLightTheme,
      {bool isBold = true,
      double? fontSize}) {
    return WidgetStateProperty.resolveWith<TextStyle>(
      (Set<WidgetState> states) {
        if (states.contains(WidgetState.pressed)) {
          return MyFonts.buttonTextStyle.copyWith(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontSize: fontSize ?? MyFonts.buttonTextSize,
              color: isLightTheme
                  ? LightThemeColors.buttonTextColor
                  : DarkThemeColors.buttonTextColor);
        } else if (states.contains(WidgetState.disabled)) {
          return MyFonts.buttonTextStyle.copyWith(
              fontSize: fontSize ?? MyFonts.buttonTextSize,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: isLightTheme
                  ? LightThemeColors.buttonDisabledTextColor
                  : DarkThemeColors.buttonDisabledTextColor);
        }
        return MyFonts.buttonTextStyle.copyWith(
            fontSize: fontSize ?? MyFonts.buttonTextSize,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color: isLightTheme
                ? LightThemeColors.buttonTextColor
                : DarkThemeColors
                    .buttonTextColor); // Use the component's default.
      },
    );
  }

  //elevated button theme data
  static ElevatedButtonThemeData getElevatedButtonTheme(
          {required bool isLightTheme}) =>
      ElevatedButtonThemeData(
        style: ButtonStyle(
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
              //side: BorderSide(color: Colors.teal, width: 2.0),
            ),
          ),
          elevation: WidgetStateProperty.all(0),
          padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
              EdgeInsets.symmetric(vertical: 8.h)),
          textStyle: getElevatedButtonTextStyle(isLightTheme),
          backgroundColor: WidgetStateProperty.resolveWith<Color>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.pressed)) {
                return isLightTheme
                    ? LightThemeColors.buttonColor
                    : DarkThemeColors.buttonColor;
              } else if (states.contains(WidgetState.disabled)) {
                return isLightTheme
                    ? LightThemeColors.buttonDisabledColor
                    : DarkThemeColors.buttonDisabledColor;
              }
              return isLightTheme
                  ? LightThemeColors.buttonColor
                  : DarkThemeColors.buttonColor; // Use the component's default.
            },
          ),
        ),
      );

  //elevated button theme data
  static TextButtonThemeData getTextButtonTheme({required bool isLightTheme}) =>
      TextButtonThemeData(
        style: ButtonStyle(
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
              //side: BorderSide(color: Colors.teal, width: 2.0),
            ),
          ),
          elevation: WidgetStateProperty.all(0),
          padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
              EdgeInsets.symmetric(vertical: 8.h)),
          textStyle: getElevatedButtonTextStyle(isLightTheme),
          // backgroundColor: MaterialStateProperty.resolveWith<Color>(
          //   (Set<MaterialState> states) {
          //     if (states.contains(MaterialState.pressed)) {
          //       return isLightTheme
          //           ? LightThemeColors.primaryColor
          //           : DarkThemeColors.primaryColor;
          //     } else if (states.contains(MaterialState.disabled)) {
          //       return isLightTheme
          //           ? LightThemeColors.buttonDisabledColor
          //           : DarkThemeColors.buttonDisabledColor;
          //     }
          //     return isLightTheme
          //         ? LightThemeColors.primaryColor
          //         : DarkThemeColors
          //             .primaryColor; // Use the component's default.
          //   },
          // ),
        ),
      );
}
