import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../constants/app_constants.dart';

class CustomIndicator extends StatelessWidget {
  const CustomIndicator({
    super.key,
    this.svgImage,
    this.hintText,
    this.hintScale,
    this.hintText2,
    required this.hintValue,
    this.hintTextColor,
    this.hintValueColor,
    this.hintScaleColor,
    this.backgroundColor,
    this.width,
  });

  final String? svgImage, hintText, hintScale, hintText2;
  final String hintValue;
  final Color? hintTextColor, hintValueColor, hintScaleColor, backgroundColor;
  final Double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(kPadding),
      // height: 110,width: 100,
      constraints: BoxConstraints(
        minHeight: 70.h,
        minWidth: 70.h,
      ),
      //  if(width!=null)width: width??90,
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white,
        shape: BoxShape.circle,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (svgImage != null && svgImage!.isNotEmpty)
            SvgPicture.asset(svgImage!),
          if (hintText != null && hintText!.isNotEmpty)
            Text(
              hintText!,
              textAlign: TextAlign.center,
              style: Get.textTheme.labelSmall?.copyWith(
                color: hintTextColor ?? Get.theme.primaryColor,
                fontWeight: FontWeight.w900,
              ),
            ),
          // if (hintText2 != null && hintText2!.isNotEmpty)
          //   Text(
          //     hintText2!,
          //     style: Get.textTheme.labelSmall?.copyWith(
          //         color: hintTextColor ?? Get.theme.primaryColor,
          //         fontWeight: FontWeight.w400,
          //         fontSize: 9),
          //   ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  hintValue,
                  textAlign: TextAlign.center,
                  style: Get.textTheme.labelLarge?.copyWith(
                    color: hintValueColor ?? Colors.black54,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              if (hintScale != null && hintScale!.isNotEmpty) ...[
                Gap(3),
                Text(
                  hintScale!,
                  style: Get.textTheme.labelSmall?.copyWith(
                    color: hintScaleColor ?? Colors.black54,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
