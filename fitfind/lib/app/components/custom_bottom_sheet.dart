import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../config/translations/localization_service.dart';
import '../config/translations/strings_enum.dart';
import '../utils/spaces.dart';
import '../widgets/custom_buttons.dart';
import '/app/constants/app_constants.dart';

changeLanguage() {
  BuildContext context = Get.context!;
  var theme = Theme.of(context);
  print("Current Language: ${Get.locale.toString()}");
  openCustomBottomSheet([
    {
      "text": "English",
      "textColor": Get.locale.toString() == "en_US"
          ? AppColors.primaryTextColor
          : AppColors.black50,
      "onTap": () async {
        if (Get.isBottomSheetOpen!) Get.back();
        // if (MySharedPref.getUserData()?.language == 'en') return;
        // await updateLanguage('en');
        LocalizationService.updateLanguage('en');
      },
      "check": Get.locale.toString() == "en_US",
    },
    {
      "text": "العربية",
      "textColor": Get.locale.toString() == "ar_AR"
          ? AppColors.primaryTextColor
          : AppColors.black50,
      "onTap": () async {
        if (Get.isBottomSheetOpen!) Get.back();
        // if (MySharedPref.getUserData()?.language == 'es') return;
        // await updateLanguage('es');
        LocalizationService.updateLanguage('ar');
      },
      "check": Get.locale.toString() == "ar_AR",
    },
  ], true);
}

// updateLanguage(language) {
//   int passengerId = MySharedPref.getUserId();
//   if (passengerId == 0) return;

//   showLoadingOverLay(
//     msg: Strings.loading.tr,
//     asyncFunction: () async {
//       var data = {
//         "passengerId": passengerId,
//         "language": language,
//       };
//       return BaseClient.safeApiCall(
//         UserService.updateLanguage,
//         RequestType.patch,
//         data: data,
//         onSuccess: (resp) {
//           var response = userFromJson(resp.data["user"]);
//           MySharedPref.setUserData(response);
//         },
//       );
//     },
//   );
// }

openCustomBottomSheet(List list, bool isLang) {
  Get.bottomSheet(
    isLang
        ? CustomBottomSheetForChangeLang(
            list: list,
          )
        : CustomBottomSheetForProfile(
            list: list,
          ),
    backgroundColor: AppColors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(kBorderRadius),
        topRight: Radius.circular(kBorderRadius),
      ),
    ),
  );
}

showCustomBottomSheet({
  required context,
  bool? isDismissible,
  String? title,
  String? subTitle,
  double? height,
  double? padding,
  Function()? onTap,
  Widget? trailingWidget,
  required List<Widget> listOfItem,
}) {
  var theme = Theme.of(context);

  Get.bottomSheet(
    CustomBottomSheet(
      title: title,
      subTitle: subTitle,
      list: listOfItem,
      height: height ?? Get.height * 0.9,
      padding: padding,
      onTap: onTap,
      trailingWidget: trailingWidget,
    ),
    isDismissible: isDismissible ?? true,
    ignoreSafeArea: true,
    isScrollControlled: true,
    backgroundColor: theme.scaffoldBackgroundColor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(kBorderRadius),
        topRight: Radius.circular(kBorderRadius),
      ),
    ),
  );
}

class CustomBottomSheet extends StatelessWidget {
  CustomBottomSheet({
    Key? key,
    this.title,
    this.subTitle,
    this.padding,
    required this.height,
    required this.list,
    this.onTap,
    this.trailingWidget,
  }) : super(key: key);

  String? title;
  String? subTitle;
  double? padding;
  double height;
  Widget? trailingWidget;
  List<Widget> list;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        0,
        kPadding / 2,
        0,
        kBottomPadding(context),
      ),
      constraints: BoxConstraints(
        maxHeight: height,
      ),
      // height: height,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: Get.width / 3,
                color: AppColors.greyLight,
                height: 5,
              ),
            ),
            if (title != '') const SpaceH12(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kPadding),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,

                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomIconButton(
                    isSmall: true,
                    iconData: Icons.chevron_left_outlined,
                    // backgroundColor: AppColors.greyBtn,
                    color: AppColors.primaryBlackColor,
                    onTap: () {
                      if (onTap == null) {
                        if (Get.isBottomSheetOpen ?? false) Get.back();
                      }
                      onTap?.call();
                    },
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        title ?? "",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ),
                  trailingWidget ??
                      const SizedBox(
                        width: 45,
                        height: 15,
                      )
                ],
              ),
            ),
            if (title != '') const SpaceH8(),
            // for (int index = 0; index < list.length; index++)
            Divider(
              height: 1,
              color: Get.theme.dividerColor.withOpacity(.5),
            ),
            Padding(
              padding: EdgeInsets.all(padding ?? 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: list,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomBottomSheetForChangeLang extends StatelessWidget {
  CustomBottomSheetForChangeLang({
    Key? key,
    required this.list,
  }) : super(key: key);

  List list;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.fromLTRB(
        0,
        kPadding,
        0,
        kBottomPadding(context) + kPadding,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kPadding),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    Strings.LANGUAGE.tr,
                    style: Get.textTheme.bodyLarge,
                  ),
                ),
                CustomIconButton(
                  isSmall: true,
                  iconData: Icons.close,
                  color: AppColors.primaryTextColor,
                  onTap: () {
                    Get.back();
                  },
                ),
              ],
            ),
          ),
          const Divider(),
          for (var item in list)
            InkWell(
              onTap: item["onTap"],
              borderRadius: BorderRadius.circular(kBorderRadius),
              overlayColor: MaterialStateProperty.all(
                theme.primaryColor.withOpacity(.1),
              ),
              splashColor: theme.primaryColor.withOpacity(.1),
              focusColor: theme.primaryColor.withOpacity(.1),
              highlightColor: theme.primaryColor.withOpacity(.1),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: kPadding / 2,
                ),
                child: Row(
                  children: [
                    Checkbox(
                      value: item["check"],
                      onChanged: null,
                      fillColor: item["check"] == true
                          ? WidgetStateProperty.all(Get.theme.primaryColor)
                          : null,
                    ),
                    const Gap(10),
                    Expanded(
                      child: Text(
                        item["text"],
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: item["textColor"],
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class CustomBottomSheetForProfile extends StatelessWidget {
  CustomBottomSheetForProfile({
    Key? key,
    required this.list,
  }) : super(key: key);

  List list;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.fromLTRB(
        kPadding / 3,
        kPadding,
        kPadding / 3,
        kBottomPadding(context),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var item in list)
            InkWell(
              onTap: item["onTap"],
              borderRadius: BorderRadius.circular(kBorderRadius),
              overlayColor: MaterialStateProperty.all(
                theme.primaryColor.withOpacity(.1),
              ),
              splashColor: theme.primaryColor.withOpacity(.1),
              focusColor: theme.primaryColor.withOpacity(.1),
              highlightColor: theme.primaryColor.withOpacity(.1),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: kPadding,
                  horizontal: kPadding / 3,
                ),
                child: Row(
                  children: [
                    CustomIconButton(
                      iconData: item["icon"],
                      isRounded: true,
                      color: (item["textColor"] as Color),
                      backgroundColor:
                          (item["textColor"] as Color).withOpacity(.1),
                      showShadow: false,
                    ),
                    // Icon(
                    //   ,
                    //   ,
                    // ),
                    const SpaceW16(),
                    Text(
                      item["text"],
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: item["textColor"],
                          ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// ============================================================
/// Custom Draggable BottomSheet
/// ============================================================

Widget customDraggableBottomSheet(Widget header, Widget body) {
  return DraggableScrollableSheet(
    initialChildSize: .075,
    minChildSize: .075,
    maxChildSize: .6,
    // expand: true,

    builder: (BuildContext context, ScrollController scrollController) {
      return SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: [
            header,
            const Divider(height: 1),
            Container(
              color: Get.theme.cardColor,
              child: body,
            ),
          ],
        ),
      );
    },
  );
}
