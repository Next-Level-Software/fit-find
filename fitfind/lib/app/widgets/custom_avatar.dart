import '/app/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/app/widgets/custom_network_image.dart';
import '../environment/environment.dart';

class CustomAvatar extends StatelessWidget {
  const CustomAvatar({
    super.key,
    this.text,
    this.filePath,
    this.imagePath,
    this.size,
    this.borderRadius,
    this.color,
    this.textSize,
    this.isSmall = false,
    this.isRounded = true,
    this.isActive,
  });

  final String? text;
  final String? filePath;
  final String? imagePath;
  final double? size;
  final double? borderRadius;
  final bool? isSmall;
  final Color? color;
  final double? textSize;
  final bool? isRounded;
  final bool? isActive;

  @override
  Widget build(BuildContext context) {
    double height = size ?? (isSmall == true ? 35 : 45);
    double width = size ?? (isSmall == true ? 35 : 45);

    String nameSplit() {
      if (text == null) return appName[0];

      List<String> list = text?.split(' ') ?? [];
      if (list.isEmpty) return appName[0];

      if (list.length == 1) return list.first[0].toUpperCase();

      if (list.length > 1) {
        return "${list.first[0].toUpperCase()}${list.last[0].toUpperCase()}";
      }

      return appName[0];
    }

    String? networkImagePath() {
      if ((imagePath == null) || imagePath == '') return null;

      if ((imagePath?.contains(FILE_BASE_URL) ?? false) ||
          (imagePath?.contains('http') ?? false)) {
        return imagePath;
      }

      return FILE_BASE_URL + (imagePath ?? "");
    }

    return Stack(
      children: [
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: color ?? Get.theme.primaryColor,
            borderRadius: isRounded == false
                ? BorderRadius.circular(borderRadius ?? kBorderRadius)
                : null,
            shape: isRounded == false ? BoxShape.rectangle : BoxShape.circle,
            border: Border.all(width: 0),
          ),
          alignment: Alignment.center,
          child: (networkImagePath()?.isEmpty ?? true)
              ? Text(
                  nameSplit(),
                  style: Get.textTheme.titleSmall!.copyWith(
                    color:
                        color == null ? Colors.white : Get.theme.primaryColor,
                    fontSize: textSize ?? (isSmall == true ? 15 : null),
                  ),
                )
              : CustomNetworkImage(
                  imagePath: networkImagePath() ?? "",
                  height: height,
                  width: width,
                  boxFit: BoxFit.cover,
                  isRounded: isRounded,
                  borderRadius:
                      BorderRadius.circular(borderRadius ?? kBorderRadius)),
        ),
        if (isActive != null)
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                ),
              ),
              child: Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isActive == true ? Colors.green : Colors.grey,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class CustomAvatarRectangular extends StatelessWidget {
  CustomAvatarRectangular({
    super.key,
    required this.text,
    this.size,
  });

  String text;
  double? size;
  final Color randomBackgroundColor = Get.theme.primaryColor;
  // Colors.primaries[Random().nextInt(Colors.primaries.length)];
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return SizedBox(
      width: size ?? 55,
      height: size ?? 55,
      child: Container(
        decoration: BoxDecoration(
            color: randomBackgroundColor,
            borderRadius: BorderRadius.circular(kBorderRadius)),
        child: Center(
          child: Text(
            text[0],
            style: TextStyle(
              fontSize: size! / 3,
              color: theme.scaffoldBackgroundColor,
            ),
          ),
        ),
      ),
    );
  }
}

class CustomAvatar2 extends StatelessWidget {
  final String imageUrl;
  final bool? isOnline;
  final double? size;
  final String? name;

  const CustomAvatar2({
    super.key,
    required this.imageUrl,
    this.isOnline,
    this.size,
    this.name,
  });

  @override
  Widget build(BuildContext context) {
    double defaultSize = (size ?? 20);
    return Stack(
      children: [
        imageUrl.isEmpty
            ? ShowUserProfile(
                name: name ?? (appName),
                size: defaultSize * 2,
              )
            : CustomNetworkImage(
                imagePath: imageUrl.isEmpty
                    ? "https://static.vecteezy.com/system/resources/previews/019/896/008/original/male-user-avatar-icon-in-flat-design-style-person-signs-illustration-png.png"
                    : imageUrl,
                height: defaultSize * 2,
                width: defaultSize * 2,
                borderColor: Colors.transparent,
                isRounded: true,
                boxFit: BoxFit.cover,
              ),
        if (isOnline != null)
          Positioned(
            bottom: 0,
            right: 0,
            child: Badge(
              backgroundColor: isOnline == true ? Colors.green : Colors.grey,
              smallSize: defaultSize / 2.2,
            ),
          ),
      ],
    );
  }
}
