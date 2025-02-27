import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../constants/app_constants.dart';
class CustomEmptyWidget extends StatefulWidget {
  CustomEmptyWidget({
    super.key,
    required this.title,
    this.icon,
    this.iconWidget,
    this.titleColor,
    this.subtitle = '',
    this.backgroundColor,
    this.additionalWidget,
  });

  String title;
  Widget? iconWidget;
  IconData? icon;
  String? subtitle;
  Color? titleColor;
  Color? backgroundColor;
  Widget? additionalWidget;

  @override
  State<CustomEmptyWidget> createState() => _CustomEmptyWidgetState();
}

class _CustomEmptyWidgetState extends State<CustomEmptyWidget>
    with TickerProviderStateMixin {
  late Animation imageAnimation; /*!*/
  AnimationController? imageController;

  @override
  void initState() {
    imageController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat();
    imageAnimation = Tween<double>(begin: 0, end: 10).animate(
      CurvedAnimation(parent: imageController!, curve: Curves.linear),
    );
    super.initState();
  }

  animationListener() {
    if (imageController == null) {
      return;
    }
    if (imageController!.isCompleted) {
      setState(() {
        imageController!.reverse();
      });
    } else {
      setState(() {
        imageController!.forward();
      });
    }
  }

  @override
  void dispose() {
    imageController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Get.theme;

    return Container(
      width: Get.width,
      margin: const EdgeInsets.all(kPadding),
      padding: const EdgeInsets.all(kPadding),
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? Colors.transparent,
        borderRadius: BorderRadius.circular(kBorderRadius),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Gap(12),
          AnimatedBuilder(
            animation: imageAnimation,
            builder: (BuildContext context, Widget? child) {
              return Transform.translate(
                offset: Offset(
                  0,
                  sin(
                    imageAnimation.value > .9
                        ? 1 - imageAnimation.value
                        : imageAnimation.value,
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.all(kPadding / 2),
                  decoration: BoxDecoration(
                    color: theme.cardColor,
                    shape: BoxShape.circle,
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 10,
                        color: Colors.black12,
                      )
                    ],
                  ),
                  child: widget.iconWidget ??
                      Icon(
                        widget.icon ?? Icons.list,
                        color: theme.primaryColor,
                        size: 30,
                      ),
                ),
              );
            },
          ),
          const Gap(16),
          Text(
            widget.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: widget.titleColor,
                ),
          ),
          const Gap(8),
          widget.subtitle == '' || widget.subtitle == null
              ? const SizedBox()
              : Text(widget.subtitle ?? "",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall),
          const Gap(12),
          widget.additionalWidget ?? const SizedBox(),
        ],
      ),
    );
  }
}
