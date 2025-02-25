import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../widgets/custom_buttons.dart';

// ignore: must_be_immutable
class HaveAccount extends StatelessWidget {
  HaveAccount({
    super.key,
    this.color,
    this.linkColor,
    required this.text1,
    required this.text2,
    required this.onPressed,
  });
  final Color? color, linkColor;
  final String text1, text2;
  Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text1,
          style: TextStyle(color: color ?? Colors.white),
        ),
        // Gap(4),
        CustomTextButton(
          horizontalSpace: 0,
          alignment: Alignment.centerLeft,
          text: text2,
          onPress: onPressed ?? () {},
          background: Colors.transparent,
          color: color ?? Colors.white,
          showUnderline: true,
        ),
      ],
    );
  }
}
