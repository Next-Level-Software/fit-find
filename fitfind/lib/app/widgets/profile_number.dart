import 'package:icons_plus/icons_plus.dart';

import '/app/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class NumbersWidget extends StatelessWidget {
  NumbersWidget({
    super.key,
    required this.text1,
    this.function1,
    required this.value1,
    required this.text2,
    this.function2,
    required this.value2,
    required this.text3,
    this.function3,
    required this.value3,
  });
  String text1;
  Function()? function1;
  String value1;
  String text2;
  Function()? function2;
  String value2;
  String text3;
  Function()? function3;
  String value3;

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          buildButton(context, value1, text1, function1),
          buildDivider(),
          buildButton(context, value2, text2, function2),
          buildDivider(),
          buildButton(context, value3, text3, function3),
        ],
      );
  Widget buildDivider() => SizedBox(
        height: 24,
        child: const VerticalDivider(),
      );

  Widget buildButton(
    BuildContext context,
    String value,
    String text,
    Function()? press,
  ) =>
      MaterialButton(
        padding: const EdgeInsets.symmetric(vertical: 4),
        onPressed: press,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(children: [
              Text(
                value,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              if (text == 'Rating'.tr) const Gap(2),
              if (text == 'Rating'.tr)
                const Icon(
                  EvaIcons.star,
                  color: AppColors.orange,
                ),
            ]),
            const Gap(8),
            Row(
              children: [
                Text(
                  text,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold, color: AppColors.black50),
                ),
                // if (text == 'Rating') const SpaceW2(),
                // if (text == 'Rating')
                //   const Icon(
                //     EvaIcons.chevronRightOutline,
                //     color: AppColors.grey,
                //   ),
              ],
            ),
          ],
        ),
      );
}
