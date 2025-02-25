import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';

class CustomReadMoreText extends StatelessWidget {
  const CustomReadMoreText({
    super.key,
    required this.text,
    this.textStyle,
    this.trimMode = TrimMode.Length,
    this.trimLines = 6,
    this.trimLength = 250,
  });

  final String text;
  final TextStyle? textStyle;
  final TrimMode trimMode;
  final int trimLines;
  final int trimLength;

  @override
  Widget build(BuildContext context) {
    return ReadMoreText(
      text,
      style: textStyle ?? Get.textTheme.bodyMedium,
      trimMode: trimMode,
      trimLines: trimLines,
      trimLength: trimLength,
      trimExpandedText: 'Read less'.tr,
      trimCollapsedText: 'Read more'.tr,
      moreStyle: Get.textTheme.bodyLarge!.copyWith(
        color: Get.theme.primaryColor,
      ),
      lessStyle: Get.textTheme.bodyLarge!.copyWith(
        color: Get.theme.primaryColor,
      ),
    );
  }
}
