import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/app/constants/app_constants.dart';

Widget customBottomBar({
  required Widget widget,
  double? padding,
  Color? backgroundColor,
  bool? isBorder,
}) {
  var theme = Get.theme;

  return Container(
    padding: EdgeInsets.all(padding ?? kPadding),
    decoration: BoxDecoration(
      color: backgroundColor ?? theme.cardColor,
      border: isBorder ?? true
          ? Border(
              top: BorderSide(
                color: theme.splashColor,
              ),
            )
          : null,
    ),
    child: SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [widget],
      ),
    ),
  );
}
