import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '/app/constants/app_constants.dart';
import 'package:gap/gap.dart';
import 'package:like_button/like_button.dart';

enum IconPosition {
  leading,
  trailing,
}

class CustomButton extends StatelessWidget {
  CustomButton({
    super.key,
    required this.text,
    this.onPress,
    this.color,
    this.isOutlined = false,
    this.isDisabled = false,
    this.icon,
    this.width,
    this.fontSize,
    this.textColor,
    this.borderColor,
    this.backgroundColor,
    this.borderRadius,
    this.isSmallText = false,
    this.showSkeleton = false,
    this.iconPosition = IconPosition.leading,
  }) {
    color ??= Get.theme.progressIndicatorTheme.color;
  }

  CustomButton.primary({
    super.key,
    required this.text,
    this.onPress,
    this.isOutlined = false,
    this.isDisabled = false,
    this.icon,
    this.width,
    this.fontSize,
    this.textColor,
    this.borderRadius,
    this.borderColor,
    this.backgroundColor,
    this.isSmallText = false,
    this.showSkeleton = false,
    this.iconPosition = IconPosition.leading,
  }) {
    color = Get.theme.primaryColor;
  }

  String text;
  VoidCallback? onPress;
  Color? color, backgroundColor;
  Color? textColor, borderColor;
  BorderRadiusGeometry? borderRadius;
  bool? isOutlined;
  bool? isDisabled = false;
  double? width;
  double? fontSize;
  IconData? icon;
  bool? isSmallText;
  bool? showSkeleton;
  IconPosition iconPosition;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    // double height = isSmallText == true ? 35 : 50;

    return Container(
      width: width,
      // height: Get.height*.06,
      decoration: BoxDecoration(
        // border: Border.all(
        //   color: borderColor ??
        //       (isOutlined == false
        //           ? Colors.transparent
        //           : AppColors.primaryOutlinedColor),
        // ),
        // gradient: LinearGradient(
        //   colors: [
        //     isDisabled == true
        //         ? theme.disabledColor
        //         : isOutlined != true
        //             ? (color ?? theme.primaryColor)
        //             : Colors.transparent,
        //     isDisabled == true
        //         ? theme.disabledColor
        //         : isOutlined != true
        //             ? (color?.withOpacity(.8) ??
        //                 theme.primaryColor.withOpacity(.8))
        //             : Colors.transparent,
        //   ],
        //   begin: Alignment.topCenter,
        //   end: Alignment.bottomCenter,
        // ),
        color: isDisabled == true
            ? theme.disabledColor
            : isOutlined != true
                ? (color ?? (Get.theme.primaryColor))
                : Colors.transparent,

        borderRadius: borderRadius ?? BorderRadius.circular(12),
      ),
      child: ElevatedButton(
        style: ButtonStyle(
          elevation: WidgetStateProperty.all(0),
          padding: WidgetStateProperty.all(EdgeInsets.symmetric(
              vertical: isSmallText == true
                  ? isOutlined == true
                      ? 16
                      : kSpacing
                  : kPadding)),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: borderRadius ??
                  BorderRadius.circular(
                    kBorderRadius * 4,
                  ),
              side: BorderSide(
                color: isDisabled == true
                    ? theme.disabledColor.withOpacity(.1)
                    : (isOutlined == true
                        ? borderColor ?? AppColors.primaryOutlinedColor
                        : color ?? (theme.primaryColor)),
              ),
            ),
          ),
          backgroundColor: WidgetStateProperty.all(
            Colors.transparent,
          ),
          overlayColor: WidgetStateProperty.all(
            isOutlined == true
                ? (color?.withOpacity(.2) ?? AppColors.primaryOutlinedColor)
                : textColor == null
                    ? AppColors.white.withOpacity(.2)
                    : null,
          ),
        ),
        onPressed: isDisabled == true ? null : onPress,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isSmallText == true ? const Gap(12) : const Gap(16),
            iconPosition == IconPosition.leading
                ? icon != null
                    ? Icon(
                        icon,
                        color: isOutlined == true
                            ? color ?? AppColors.white
                            : textColor ?? AppColors.white,
                      )
                    : const SizedBox()
                : const SizedBox(),
            icon != null
                ? isSmallText == true
                    ? const Gap(4)
                    : const Gap(8)
                : const SizedBox(),
            if (icon == null)
              Expanded(
                flex: 1,
                child: Center(
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: isOutlined == true
                          ? color ?? AppColors.white
                          : textColor ?? AppColors.white,
                      fontSize: fontSize ?? (isSmallText == true ? 14 : 18),
                    ),
                  ),
                ),
              ),
            if (icon != null)
              Center(
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isOutlined == true
                        ? color ?? AppColors.white
                        : textColor ?? AppColors.white,
                    fontSize: fontSize ?? (isSmallText == true ? 14 : 18),
                  ),
                ),
              ),
            isSmallText == true ? const Gap(12) : const Gap(16),
            iconPosition == IconPosition.trailing
                ? icon != null
                    ? Icon(
                        icon,
                        color: isOutlined == true
                            ? color ?? AppColors.white
                            : textColor ?? AppColors.white,
                      )
                    : const SizedBox()
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
class CustomElevatedButton extends StatelessWidget {
  final Function()? onPressed;
  final String? text;
  final IconData? icon;
  final Color? color,textColor;

  CustomElevatedButton({this.onPressed, this.text, this.icon, this.color,this.textColor});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent, // Make sure Material is transparent
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(12), // Ensures ripple follows shape
        splashColor: Colors.grey.withOpacity(0.3), // Custom splash color
        child: Container(
          width: Get.width * 0.9,
          padding: EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: color ?? Colors.transparent,
            border: Border.all(color: AppColors.primaryOutlinedColor), // Change to your primary color
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Gap(20),
              if (icon != null) ...[
                Icon(icon, color: Colors.black),
                SizedBox(width: 10),
              ],
              Expanded(
                child: Text(
                  text ?? "",
                  textAlign: TextAlign.center,
                  style: TextStyle(color:textColor?? Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    required this.text,
    this.svgIcon,
    this.color,
    this.iconColor,
    required this.onPress,
    this.background,
    this.enable = true,
    this.icon,
    this.borderRadius,
    this.height,
    this.showUnderline = false,
    this.iconPosition = IconPosition.trailing,
    this.showSkeleton = false,
    this.isSmall = false,
    this.spaceBetween,
    this.horizontalSpace,
    this.borderWidth,
    this.borderColor,
    this.isOutlined = false,
    this.width,
    this.isSolid = false,
    this.alignment = Alignment.center, // Default alignment is center
  });

  // Additional constructor for outlined buttons
  const CustomTextButton.outline({
    super.key,
    required this.text,
    required this.onPress,
    this.svgIcon,
    this.color,
    this.iconColor,
    this.borderRadius,
    this.isSmall = false,
    this.icon,
    this.iconPosition = IconPosition.trailing,
    this.showUnderline = false,
    this.spaceBetween,
    this.horizontalSpace,
    this.borderWidth,
    this.borderColor,
    this.width,
    this.height,
    this.alignment = Alignment.center, // Default to center
  })  : background = Colors.transparent,
        enable = true,
        isOutlined = true,
        isSolid = false,
        showSkeleton = false;

  // Common properties

  final String text;
  final Widget? svgIcon;
  final Color? color;
  final Color? iconColor;
  final Color? background;
  final Function() onPress;
  final bool enable;
  final bool isOutlined;
  final bool isSolid;
  final bool isSmall;
  final bool showUnderline;
  final IconPosition iconPosition;
  final bool showSkeleton;
  final IconData? icon;
  final double? borderRadius;
  final double? spaceBetween;
  final double? horizontalSpace;
  final double? borderWidth, width;
  final Color? borderColor;
  final double? height;
  final Alignment alignment; // Alignment property

  @override
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    double length;
    if (isSmall) {
      length = 30.h;
    } else {
      length = 43.h;
    }

    return Align(
      alignment: alignment,
      child: Container(
        width: width, // Use width if provided
        constraints: BoxConstraints(
          maxWidth:
              alignment == Alignment.center || alignment == Alignment.centerLeft
                  ? width ?? double.infinity // Respect the width
                  : double.infinity,
        ),
        height: height ?? length, // Set height for the button
        child: TextButton(
          onPressed: enable ? onPress : null,
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(
              _getBackgroundColor(theme),
            ),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(borderRadius ?? kBorderRadius / 2),
                side: BorderSide(
                  color: borderColor ??
                      (isOutlined
                          ? color ?? theme.splashColor
                          : Colors.transparent),
                  width: borderWidth ?? 1,
                ),
              ),
            ),
            overlayColor: WidgetStateProperty.all(_getOverlayColor(theme)),
          ),
          child: _buildButtonContent(theme),
        ),
      ),
    );
  }

  // Helper methods for better readability
  Color _getBackgroundColor(ThemeData theme) {
    if (!enable) {
      return theme.scaffoldBackgroundColor.withOpacity(.1);
    }
    if (isSolid) {
      return background ?? theme.primaryColor;
    }
    if (isOutlined) {
      return Colors.transparent;
    }
    return background ??
        (color == null ? theme.cardColor : color!.withOpacity(.2));
  }

  Color _getOverlayColor(ThemeData theme) {
    if (!enable) {
      return theme.disabledColor.withOpacity(.1);
    }
    if (isSolid) {
      return theme.splashColor;
    }
    return color?.withOpacity(.1) ??
        (theme.textTheme.bodyLarge?.color ?? Colors.black).withOpacity(.1);
  }

  Widget _buildButtonContent(ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Gap(horizontalSpace ?? 0),
        if (svgIcon != null && iconPosition == IconPosition.leading) ...[
          svgIcon ?? SizedBox(),
          _buildGap(),
        ],
        if (icon != null && iconPosition == IconPosition.leading) ...[
          Icon(icon, size: isSmall ? 15 : 20, color: _getIconColor(theme)),
          _buildGap(),
        ],
        Text(
          text,
          style: TextStyle(
            fontSize: isSmall ? 12 : 14,
            color: _getTextColor(theme),
            decoration: showUnderline ? TextDecoration.underline : null,
            decorationColor: _getTextColor(theme),
            decorationThickness: 2,
          ),
        ),
        if (svgIcon != null && iconPosition == IconPosition.trailing) ...[
          svgIcon ?? SizedBox(),
          _buildGap(),
        ],
        if (icon != null && iconPosition == IconPosition.trailing) ...[
          _buildGap(),
          Icon(icon, size: isSmall ? 15 : 20, color: _getIconColor(theme)),
        ],
        Gap(horizontalSpace ?? 0),
      ],
    );
  }

  Widget _buildGap() {
    return spaceBetween == null
        ? (isSmall ? const Gap(2) : const Gap(8))
        : SizedBox(width: spaceBetween);
  }

  Color _getIconColor(ThemeData theme) {
    return iconColor ??
        (color ?? (theme.textTheme.bodyLarge?.color ?? Colors.black));
  }

  Color _getTextColor(ThemeData theme) {
    if (!enable) {
      return Colors.black.withOpacity(.5);
    }
    if (isSolid) {
      return theme.cardColor;
    }
    return color ?? (theme.textTheme.bodyLarge?.color ?? Colors.black);
  }
}

class CustomIconButton extends StatelessWidget {
  final IconData? iconData;
  final Widget? iconWidget;
  final Function()? onTap;
  final Color? backgroundColor;
  final String? tooltip;
  final bool isOutlined;
  final bool isRounded;
  final bool showShadow;
  final bool isSmall;
  final double? borderRadius;
  final double? iconSize;
  final Color? color;
  final int? badge;
  final double? height, width;

  // Default solid constructor
  const CustomIconButton({
    super.key,
    this.iconData,
    this.iconWidget,
    this.onTap,
    this.backgroundColor,
    this.isRounded = true,
    this.showShadow = false,
    this.isSmall = false,
    this.color,
    this.tooltip,
    this.borderRadius,
    this.isOutlined = false,
    this.badge,
    this.height,
    this.iconSize,
    this.width,
  });
  // Outline constructor
  const CustomIconButton.outline({
    super.key,
    this.iconData,
    this.iconWidget,
    this.onTap,
    this.backgroundColor,
    this.isRounded = true,
    this.showShadow = false,
    this.isSmall = false,
    this.color,
    this.borderRadius,
    this.tooltip,
    this.badge,
    this.height,
    this.iconSize,
    this.width,
  }) : isOutlined = true;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    double kHeight = isSmall ? 35 : 45;
    double horizontalSpaces = isSmall ? 35 : 45;

    return Container(
      height: height ?? kHeight,
      width: width ?? horizontalSpaces,
      decoration: BoxDecoration(
        shape: isRounded ? BoxShape.circle : BoxShape.rectangle,
        color: isOutlined
            ? Colors.transparent
            : backgroundColor ?? theme.cardColor,
        borderRadius: isRounded
            ? null
            : BorderRadius.circular(borderRadius ?? kBorderRadius),
        border: Border.all(
          color: isOutlined
              ? color ?? backgroundColor ?? theme.primaryColor
              : Colors.transparent,
          width: 1,
        ),
        boxShadow: showShadow
            ? [
                BoxShadow(
                  blurRadius: 7,
                  spreadRadius: 1,
                  color: theme.disabledColor.withOpacity(.3),
                ),
              ]
            : [],
      ),
      child: Tooltip(
        message: tooltip ?? "",
        child: Material(
          color: Colors.transparent,
          shape: isRounded ? const CircleBorder() : null,
          child: InkWell(
            customBorder: isRounded ? const CircleBorder() : null,
            splashColor:
                color?.withOpacity(.1) ?? theme.primaryColor.withOpacity(.1),
            highlightColor: Colors.black.withOpacity(.1),
            borderRadius: isRounded ? null : BorderRadius.circular(12),
            onTap: onTap,
            child: Align(
              alignment: Alignment.center,
              child: Badge(
                isLabelVisible: badge != null,
                smallSize: 7,
                alignment: const AlignmentDirectional(1.1, -1),
                backgroundColor: Colors.red,
                textColor: color,
                child: iconWidget ??
                    Icon(
                      iconData,
                      color: color ?? theme.primaryColor,
                      size: iconSize ?? (isSmall ? 20 : null),
                    ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomLikeButton extends StatelessWidget {
  const CustomLikeButton({
    super.key,
    this.onTap,
    this.color,
    this.outlineIcon,
    this.solidIcon,
  });

  final Future<bool?> Function(bool)? onTap;
  final Color? color;
  final IconData? outlineIcon;
  final IconData? solidIcon;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Get.theme;

    return CustomIconButton.outline(
      color: color,
      iconWidget: Center(
        child: LikeButton(
          padding: const EdgeInsets.only(left: 3),
          circleColor: CircleColor(
            start: (color ?? theme.primaryColor).withOpacity(.7),
            end: (color ?? theme.primaryColor).withOpacity(.2),
          ),
          bubblesColor: BubblesColor(
            dotPrimaryColor: (color ?? theme.primaryColor).withOpacity(.7),
            dotSecondaryColor: (color ?? theme.primaryColor).withOpacity(.2),
          ),
          isLiked: false,
          likeBuilder: (val) {
            return Icon(
              val
                  ? solidIcon ?? Icons.favorite
                  : outlineIcon ?? Icons.favorite_outline,
              color: (color ?? theme.primaryColor),
            );
          },
          onTap: onTap,
        ),
      ),
    );
  }
}

// =================================================================
// Custom
// =================================================================

class CustomSavedIcon extends StatelessWidget {
  const CustomSavedIcon({
    super.key,
    required this.value,
    this.tooltip,
  });

  final String value;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    return CustomIconButton(
      // iconData: getSavedIconData(value),
      tooltip: tooltip ?? value,
      color: value.toLowerCase() == 'home'
          ? Colors.teal
          : value.toLowerCase() == 'office' || value.toLowerCase() == 'work'
              ? Colors.indigo
              : value.toLowerCase() == 'school' ||
                      value.toLowerCase() == 'college'
                  ? Colors.green
                  : value.toLowerCase() == 'coffee' ||
                          value.toLowerCase() == 'restaurant'
                      ? Colors.amber
                      : value.toLowerCase() == 'airport'
                          ? Colors.purple
                          : value.toLowerCase() == 'hospital'
                              ? const Color(0xFF87CEEB)
                              : Get.theme.primaryColor,
      backgroundColor: value.toLowerCase() == 'home'
          ? Colors.teal.withOpacity(.2)
          : value.toLowerCase() == 'office' || value.toLowerCase() == 'work'
              ? Colors.indigo.withOpacity(.2)
              : value.toLowerCase() == 'school' ||
                      value.toLowerCase() == 'college'
                  ? Colors.green.withOpacity(.2)
                  : value.toLowerCase() == 'coffee' ||
                          value.toLowerCase() == 'restaurant'
                      ? Colors.amber.withOpacity(.2)
                      : value.toLowerCase() == 'airport'
                          ? Colors.purple.withOpacity(.2)
                          : value.toLowerCase() == 'hospital'
                              ? const Color(0xFF87CEEB).withOpacity(.2)
                              : Get.theme.primaryColor.withOpacity(.2),
    );
  }
}

// IconData getSavedIconData(
//   value, {
//   bool isBold = true,
// }) {
//   return value.toLowerCase() == 'home'
//       ? isBold
//           ? EneftyIcons.house_bold
//           : EneftyIcons.house_outline
//       : value.toLowerCase() == 'office' || value.toLowerCase() == 'work'
//           ? isBold
//               ? EneftyIcons.briefcase_bold
//               : EneftyIcons.briefcase_outline
//           : value.toLowerCase() == 'school' || value.toLowerCase() == 'college'
//               ? isBold
//                   ? EneftyIcons.book_bold
//                   : EneftyIcons.book_outline
//               : value.toLowerCase() == 'coffee' ||
//                       value.toLowerCase() == 'restaurant'
//                   ? isBold
//                       ? EneftyIcons.shop_bold
//                       : EneftyIcons.shop_outline
//                   : value.toLowerCase() == 'airport'
//                       ? isBold
//                           ? EneftyIcons.airplane_bold
//                           : EneftyIcons.airplane_outline
//                       : value.toLowerCase() == 'hospital'
//                           ? isBold
//                               ? EneftyIcons.hospital_bold
//                               : EneftyIcons.hospital_outline
//                           : isBold
//                               ? EneftyIcons.location_bold
//                               : EneftyIcons.location_outline;
// }
