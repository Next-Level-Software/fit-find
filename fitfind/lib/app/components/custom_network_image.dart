import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../environment/environment.dart';
import '/app/constants/app_constants.dart';

class CustomNetworkImage extends StatelessWidget {
  const CustomNetworkImage({
    super.key,
    required this.imagePath,
    this.height,
    required this.width,
    this.showSkeleton = false,
    this.boxFit,
    this.borderRadius,
    this.borderColor,
    this.backgroundColor,
    this.borderWidth,
    this.isRounded = false,
    this.isDark = false,
  });

  final String imagePath;
  final double? height;
  final double width;
  final BoxFit? boxFit;
  final bool isRounded;
  final BorderRadius? borderRadius;
  final Color? borderColor;
  final Color? backgroundColor;
  final double? borderWidth;
  final bool showSkeleton;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(showSkeleton ? kSpacing : 0),
      height: height ?? width,
      width: width,
      child: showSkeleton
          ? const CircularProgressIndicator()
          : CachedNetworkImage(
              imageUrl: imagePath.contains('http')
                  ? imagePath
                  : FILE_BASE_URL + imagePath,
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  color: backgroundColor,
                  shape: isRounded ? BoxShape.circle : BoxShape.rectangle,
                  border: Border.all(
                    color: borderColor ?? Colors.white,
                    width: borderWidth ?? 0,
                  ),
                  borderRadius: isRounded
                      ? null
                      : borderRadius ?? BorderRadius.circular(8),
                  image: DecorationImage(
                    colorFilter: ColorFilter.mode(
                      isDark
                          ? Colors.black.withOpacity(.5)
                          : Colors.transparent,
                      BlendMode.darken,
                    ),
                    image: imageProvider,
                    fit: boxFit ?? BoxFit.contain,
                  ),
                ),
              ),
              placeholder: (context, url) => Container(
                padding: EdgeInsets.all(kSpacing),
                height: height ?? width,
                width: width,
                constraints: BoxConstraints(
                  maxHeight: 25,
                  maxWidth: 25,
                  minWidth: 5,
                  minHeight: 5,
                ),
                alignment: Alignment.center,
                child: const CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) =>
                  CachedNetworkImage(
              imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/a/a3/Image-not-found.png?20210521171500',
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  color: backgroundColor,
                  shape: isRounded ? BoxShape.circle : BoxShape.rectangle,
                  border: Border.all(
                    color: borderColor ?? Colors.white,
                    width: borderWidth ?? 0,
                  ),
                  borderRadius: isRounded
                      ? null
                      : borderRadius ?? BorderRadius.circular(8),
                  image: DecorationImage(
                    colorFilter: ColorFilter.mode(
                      isDark
                          ? Colors.black.withOpacity(.5)
                          : Colors.transparent,
                      BlendMode.darken,
                    ),
                    image: imageProvider,
                    fit: boxFit ?? BoxFit.contain,
                  ),
                ),
              ),
              placeholder: (context, url) => Container(
                padding: EdgeInsets.all(kSpacing),
                height: height ?? width,
                width: width,
                constraints: BoxConstraints(
                  maxHeight: 25,
                  maxWidth: 25,
                  minWidth: 5,
                  minHeight: 5,
                ),
                alignment: Alignment.center,
                child: const CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) =>
                  const Icon(Icons.error_outline_rounded),
            ),
  
            ),
    );
  }
}
