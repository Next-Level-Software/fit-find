import 'package:cached_network_image/cached_network_image.dart';
import '/app/constants/app_constants.dart';
import 'package:flutter/material.dart';
import '/app/environment/environment.dart';
import '../../app/widgets/custom_avatar.dart';

class CustomNetworkImage extends StatefulWidget {
  CustomNetworkImage({
    super.key,
    this.showSkeleton = false,
    required this.imagePath,
    required this.height,
    required this.width,
    this.boxFit,
    this.borderRadius,
    this.borderColor,
    this.backgroundColor,
    this.borderWidth,
    this.isRounded = false,
    this.isDark = false,
  });
  String imagePath;
  double height;
  double width;
  BoxFit? boxFit;
  bool? isRounded;
  BorderRadius? borderRadius;
  Color? borderColor;
  Color? backgroundColor;
  double? borderWidth;
  bool? showSkeleton;
  bool? isDark;

  @override
  State<CustomNetworkImage> createState() => _CustomNetworkImageState();
}

class _CustomNetworkImageState extends State<CustomNetworkImage> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: CachedNetworkImage(
              imageUrl: widget.imagePath,
              imageBuilder: (context, imageProvider) => Container(
                height: widget.height,
                decoration: BoxDecoration(
                  color: widget.backgroundColor,
                  // boxShadow: [
                  //   if (widget.borderRadius != null)
                  //     const BoxShadow(
                  //       color: AppColors.white,
                  //       spreadRadius: 0.0,
                  //       blurRadius: 2,
                  //     ),
                  // ],
                  shape: widget.isRounded == true
                      ? BoxShape.circle
                      : BoxShape.rectangle,
                  border: Border.all(
                    color: widget.borderColor ?? AppColors.white,
                    width: widget.borderWidth ?? 0,
                  ),
                  borderRadius: widget.isRounded == true
                      ? null
                      : widget.borderRadius ??
                          BorderRadius.circular(kBorderRadius),
                  image: DecorationImage(
                    colorFilter: ColorFilter.mode(
                        widget.isDark == true
                            ? AppColors.black.withOpacity(.5)
                            : Colors.transparent,
                        BlendMode.darken),
                    image: imageProvider,
                    fit: widget.boxFit ?? BoxFit.contain,
                  ),
                ),
              ),
             
              errorWidget: (context, url, error) =>
                  const Icon(Icons.error_outline_rounded),
            ),
    );
  }
}

class CustomNetworkImageWithoutHeight extends StatelessWidget {
  CustomNetworkImageWithoutHeight({
    super.key,
    required this.imageUrl,
    this.borderRadius,
    this.boxFit,
  });

  String imageUrl;
  BorderRadius? borderRadius;
  BoxFit? boxFit;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          shape: borderRadius == -1 ? BoxShape.circle : BoxShape.rectangle,
          borderRadius: borderRadius ?? BorderRadius.circular(kBorderRadius),
          image: DecorationImage(
            image: imageProvider,
            fit: boxFit ?? BoxFit.fill,
          ),
        ),
      ),
      placeholder: (context, url) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.greyBackground,
            borderRadius: borderRadius ?? BorderRadius.circular(kBorderRadius),
            shape: borderRadius == -1 ? BoxShape.circle : BoxShape.rectangle,
          ),
        );
      },
      // placeholder: (context, url) {
      //   return FittedBox(
      //     fit: boxFit ?? BoxFit.fill,
      //     child: const SkeletonAvatar(),
      //   );
      // },
    );
  }
}

// ========================

class ShowUserProfile extends StatelessWidget {
  ShowUserProfile({
    super.key,
    required this.name,
    this.profilePhoto = '',
    this.size,
    this.isRound = true,
    this.imageBorderColor,
    this.imageBorderWidth,
  });

  String name;
  String? profilePhoto;
  double? size;
  bool? isRound;
  Color? imageBorderColor;
  double? imageBorderWidth;

  @override
  Widget build(BuildContext context) {
    return profilePhoto == '' || profilePhoto == null
        ? isRound == true
            ? CustomAvatar(
                text: name == '' ? "user" : name,
                size: size ?? 115,
              )
            : CustomAvatarRectangular(
                text: name == '' ? "user" : name,
                size: size ?? 115,
              )
        : CustomNetworkImage(
            imagePath: FILE_BASE_URL + (profilePhoto ?? ""),
            height: size ?? 90,
            width: size ?? 90,
            isRounded: isRound,
            boxFit: BoxFit.cover,
            borderColor: imageBorderColor,
            borderWidth: imageBorderWidth,
          );
  }
}

class stackTopUserImage extends StatelessWidget {
  stackTopUserImage({
    super.key,
    required this.name,
    this.profilePhoto = '',
    this.size,
    this.isRound = true,
    this.imageBorderColor,
    this.imageBorderWidth,
  });

  String name;
  String? profilePhoto;
  double? size;
  bool? isRound;
  Color? imageBorderColor;
  double? imageBorderWidth;

  @override
  Widget build(BuildContext context) {
    return profilePhoto == '' || profilePhoto == null
        ? isRound == true
            ? SizedBox(
                width: size,
                height: size,
                child: CustomAvatar(
                  text: name == '' ? appName : name,
                  size: 20,
                ),
              )
            : CustomAvatarRectangular(
                text: name == '' ? appName : name,
                size: size ?? 115,
                // stackTopUserImage:  true,
              )
        : CustomNetworkImage(
            imagePath: (profilePhoto ?? ""),
            height: 43,
            width: 43,
            isRounded: isRound,
            boxFit: BoxFit.cover,
            borderColor: imageBorderColor,
            borderWidth: imageBorderWidth,
          );
  }
}
