

import '../config/translations/strings_enum.dart';
import '../utils/spaces.dart';
import '../widgets/custom_buttons.dart';
import '/app/constants/app_constants.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ndialog/ndialog.dart';

enum AlertType {
  success,
  warning,
  error,
  dismiss,
}

class CustomAlert {
  static showDefaultAlert({
    required BuildContext context,
    Icon? icon,
    String? title,
    String? dismissText,
    Color? dismissColor,
    String? confirmText,
    Color? confirmColor,
    String? content,
    Widget? contents,
    AlertType? alertType,
    Function()? onDismiss,
    Function()? onConfirm,
    bool dismissOnConfirm = true,
    bool dismissOnDismiss = true,
    bool? isDismissible,
    List<Widget>? actions,
  }) {
    var theme = Get.theme;

    NAlertDialog(
      blur: .5,
      dismissable: isDismissible,
      dialogStyle: DialogStyle(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kBorderRadius),
          side: BorderSide(color: theme.splashColor),
        ),
        titleDivider: true,
        borderRadius: BorderRadius.circular(kBorderRadius),
        contentPadding: const EdgeInsets.all(kPadding),
        backgroundColor: theme.cardColor,
      ),
      title: Row(
        children: [
          if (icon != null) icon,
          if (icon != null) const SpaceW8(),
          Expanded(
            child: Text(
              title ??
                  (alertType == AlertType.error
                      ? Strings.ERROR.tr
                      : alertType == AlertType.warning
                          ? Strings.WARNING.tr
                          : alertType == AlertType.success
                              ? Strings.SUCCESS.tr
                              : ""),
              style: theme.textTheme.headlineSmall,
            ),
          ),
        ],
      ),
      content: contents ??
          (content == null
              ? null
              : Text(
                  content,
                  style: theme.textTheme.bodyMedium,
                )),
      actions: actions ??
          [
            CustomTextButton(
              text: dismissText ?? Strings.DISMISS.tr,
              onPress: () {
                if (dismissOnDismiss == true &&
                    isAnyAlertDialogOpened(context)) {
                  Navigator.of(context).pop();
                }

                onDismiss?.call();
              },
              // background: theme.splashColor.withOpacity(.2),
              background: dismissColor == null
                  ? Colors.transparent
                  : dismissColor.withOpacity(.2),
              color: dismissColor ?? Get.theme.hintColor,
              borderRadius: 0,
            ),
            if (alertType != AlertType.dismiss)
              CustomTextButton(
                text: confirmText ?? Strings.CONFIRM.tr,
                onPress: () {
                  if (dismissOnConfirm == true &&
                      isAnyAlertDialogOpened(context)) {
                    Navigator.of(context).pop();
                  }

                  onConfirm?.call();
                },
                borderRadius: 0,
                background: confirmColor == null
                    ? Colors.transparent
                    : confirmColor.withOpacity(.2),
                color: confirmColor ??
                    (alertType == AlertType.error
                        ? AppColors.dangerDark
                        : alertType == AlertType.warning
                            ? AppColors.warning
                            : alertType == AlertType.success
                                ? AppColors.success
                                : null),
              ),
          ],
    ).show(context);
  }

  static isAnyAlertDialogOpened(BuildContext context) =>
      ModalRoute.of(context)?.isCurrent != true;
}
