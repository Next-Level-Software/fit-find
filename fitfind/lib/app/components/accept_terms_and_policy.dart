import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';

import '../constants/app_constants.dart';
import '../widgets/custom_buttons.dart';

class TermsAndConditionsWidget extends StatefulWidget {
  final bool? isChecked;
  final ValueChanged<bool?>? onChanged;

  const TermsAndConditionsWidget({Key? key, this.isChecked, this.onChanged})
      : super(key: key);

  @override
  State<TermsAndConditionsWidget> createState() =>
      TermsAndConditionsWidgetState();
}

class TermsAndConditionsWidgetState extends State<TermsAndConditionsWidget> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Checkbox(
          fillColor: WidgetStateProperty.resolveWith<Color>(
            (states) {
              if (states.contains(WidgetState.selected)) {
                return Theme.of(context).primaryColor;
              }
              return Colors.grey.shade300;
            },
          ),
          value: widget.isChecked ?? isChecked,
          onChanged: widget.onChanged ??
              (bool? value) {
                setState(() {
                  isChecked = value ?? false;
                });
              },
          side: const BorderSide(
            color: Colors.transparent,
            width: 1.0,
          ),
        ),
        TextButton(
          style: ButtonStyle(
            overlayColor: WidgetStateProperty.all(
              Colors.white.withOpacity(0),
            ),
          ),
          onPressed: () {
            // Handle "Terms and Conditions" click
            Dialog errorDialog = Dialog(
              insetPadding: const EdgeInsets.all(kPadding),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(kBorderRadius),
              ),
              child: registrationDoneModal(context),
            );
            showDialog(
                barrierColor: Colors.black.withOpacity(0.9),
                context: Get.context!,
                useSafeArea: true,
                builder: (BuildContext context) => errorDialog);
          },
          child: Text(
            "I accept terms and conditions",
            style: Get.textTheme.bodyMedium?.copyWith(
              decoration: TextDecoration.underline,
              decorationColor: AppColors.primaryBlackColor,
              color: AppColors.primaryBlackColor,
            ),
          ),
        ),
      ],
    );
  }
}

registrationDoneModal(BuildContext context) {
  return SingleChildScrollView(
    padding: EdgeInsets.all(kPadding),
    child: Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: CustomIconButton(
            iconData: HeroIcons.x_mark,
            // backgroundColor: Colors.transparent,color: Colors.red,
            onTap: () {
              Get.back();
            },
          ),
        ),
        Gap(8),
        Text(
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis eleifend ante dui, vel lobortis risus egestas vitae. Donec pulvinar vestibulum facilisis. Fusce auctor finibus est eu mattis. In efficitur dapibus eros pharetra congue. Morbi nulla justo, ultrices non ullamcorper at, condimentum ut sapien. In hac habitasse platea dictumst. Donec pellentesque finibus dolor sit amet, adipiscing elit. Aliquam semper venenatis ante eu euismod. Aliquam semper maximus euismod. Nunc non dolor et nunc iaculis malesuada quis nec odio. Curabitur faucibus justo lectus, nec pretium risus tempus sapien eu tristique posuere. Morbi ipsum magna, id ullamcorper metus tincidunt quis. Sed ornare, leo in ullamcorper tincidunt, nunc mauris porttitor erat, sit amet cursus erat erat imperdiet leo. Pellentesque a suscipit est. Suspendisse potenti. Duis sit amet justo vehicula ex suscipit tempus.",
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}
