library;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

part 'api_paths.dart';
part 'colors.dart';
part 'image_paths.dart';

const String appName = "FitFinds";

// const String defaultCurrency = 'د.ك.';
const String defaultCurrency = 'KWD';
//todo : Khidamat API key
const String API_KEY = 'AIzaSyC94J-DyyTmx2euRAXKF4nz9FY2BprL8l8';

// const String defaultCountries = 'country:us';
// const List<String> countriesList = ['us'];
const String defaultCountries = 'country:kw|country:pk';
const List<String> countriesList = ['kw', 'pk'];

const String initialCountry = 'KW';
const String initialCountryDialCode = '965';

const kBorderRadius = 10.0;
const kSpacing = 10.0;
const kPadding = 18.0;

double kBottomPadding(BuildContext context) {
  return MediaQuery.of(context).padding.bottom;
}

double kTopPadding(BuildContext context) {
  return MediaQuery.of(context).padding.top;
}

double kRightPadding(BuildContext context) {
  return MediaQuery.of(context).padding.right;
}

double kLeftPadding(BuildContext context) {
  return MediaQuery.of(context).padding.left;
}

String? get stylishFontFamily => GoogleFonts.italiana().fontFamily;
