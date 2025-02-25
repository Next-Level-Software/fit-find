import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/spaces.dart';
import '/app/environment/environment.dart';
import '/app/constants/app_constants.dart';

class CustomImagePickerCard extends StatelessWidget {
  const CustomImagePickerCard({
    super.key,
    this.aspectRatio = 1 / 1,
    this.fileImagePath,
    this.networkImagePath,
    this.onTap,
    this.onImgTap,
    this.widgetAlignment = Alignment.bottomCenter,
    this.widgetOnImage,
    this.height,
    this.width,
    this.hintText,
    this.hintIcon,
  });

  final double aspectRatio;
  final String? fileImagePath;
  final String? networkImagePath;
  final Function()? onTap;
  final Function()? onImgTap;
  final Alignment widgetAlignment;
  final Widget? widgetOnImage;
  final double? height;
  final double? width;
  final String? hintText;
  final Widget? hintIcon;

  @override
  Widget build(BuildContext context) {
    String? networkImagePathUrl() {
      if ((networkImagePath?.isEmpty ?? true) || networkImagePath == '') {
        return null;
      }

      if ((networkImagePath?.contains(FILE_BASE_URL) ?? false) ||
          (networkImagePath?.contains('http') ?? false)) {
        return networkImagePath;
      }

      return FILE_BASE_URL + (networkImagePath ?? "");
    }

    return AspectRatio(
      aspectRatio: aspectRatio,
      child: SizedBox(
        height: height,
        width: width,
        child: networkImagePath == null && fileImagePath == null
            ? GestureDetector(
                onTap: onTap,
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Get.theme.cardColor,
                    borderRadius: BorderRadius.circular(kBorderRadius),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (hintIcon != null) hintIcon ?? const SizedBox(),
                      if (hintIcon != null) const SpaceH8(),
                      if (hintText?.isNotEmpty ?? false)
                        Text(
                          hintText ?? "",
                          style: Get.textTheme.bodySmall,
                        ),
                    ],
                  ),
                ),
              )
            : GestureDetector(
                onTap: () {
                  onImgTap?.call();
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(kBorderRadius),
                    border: Border.all(
                      color: Get.theme.splashColor,
                    ),
                    image: (fileImagePath == null ||
                            (fileImagePath?.isEmpty ?? true))
                        ? (networkImagePath == null ||
                                (networkImagePath?.isEmpty ?? true))
                            ? null
                            : DecorationImage(
                                image: NetworkImage(
                                  networkImagePathUrl() ?? "",
                                ),
                                fit: BoxFit.cover,
                              )
                        : DecorationImage(
                            image: FileImage(
                              File(
                                fileImagePath ?? "",
                              ),
                            ),
                            fit: BoxFit.cover,
                          ),
                  ),
                  alignment: widgetAlignment,
                  child: widgetOnImage,
                ),
              ),
      ),
    );
  }
}
