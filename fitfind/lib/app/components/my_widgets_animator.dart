import 'package:flutter/material.dart';
import '../config/translations/strings_enum.dart';
import '../widgets/custom_empty_widget.dart';
import '/app/constants/app_constants.dart';
import 'package:get/get.dart';

import '../services/api_call_status.dart';

// switch between different widgets with animation
// depending on api call status
class MyWidgetsAnimator extends StatelessWidget {
  final ApiCallStatus apiCallStatus;
  final Widget Function()? loadingWidget;
  final Widget Function() successWidget;
  final Widget Function()? errorWidget;
  final Widget Function()? emptyWidget;
  final Widget Function()? holdingWidget;
  final Widget Function()? refreshWidget;
  final Duration? animationDuration;
  final Widget Function(Widget, Animation)? transitionBuilder;
  // this will be used to not hide the success widget when refresh
  // if its true success widget will still be shown
  // if false refresh widget will be shown or empty box if passed (refreshWidget) is null
  final bool hideSuccessWidgetWhileRefreshing;

  const MyWidgetsAnimator({
    super.key,
    required this.apiCallStatus,
    this.loadingWidget,
    this.errorWidget,
    required this.successWidget,
    this.holdingWidget,
    this.emptyWidget,
    this.refreshWidget,
    this.animationDuration,
    this.transitionBuilder,
    this.hideSuccessWidgetWhileRefreshing = false,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: animationDuration ?? const Duration(milliseconds: 300),
      child: _getChild()(),
      transitionBuilder: transitionBuilder ??
          (child, animation) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
    );
  }

  _getChild() {
    if (apiCallStatus == ApiCallStatus.success) {
      return successWidget;
    } else if (apiCallStatus == ApiCallStatus.error) {
      return errorWidget ??
          () => Text(
                'Error while getting data'.tr,
              );
    } else if (apiCallStatus == ApiCallStatus.holding) {
      return holdingWidget ??
          () {
            return const SizedBox();
          };
    } else if (apiCallStatus == ApiCallStatus.loading) {
      return loadingWidget ??
          () {
            return Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.all(kPadding),
              child: const CircularProgressIndicator(),
            );
          };
    } else if (apiCallStatus == ApiCallStatus.empty) {
      return emptyWidget ??
          () {
            return CustomEmptyWidget(
              title: Strings.NO_DATA_FOUND.tr,
            );
          };
    } else if (apiCallStatus == ApiCallStatus.refresh) {
      return refreshWidget ??
          (hideSuccessWidgetWhileRefreshing
              ? successWidget
              : () {
                  return const SizedBox();
                });
    } else {
      return successWidget;
    }
  }
}
