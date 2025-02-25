import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
// import '/app/environment/environment.dart';
import '../utils/spaces.dart';
import '/app/constants/app_constants.dart';

class CustomMediaPickerCard extends StatefulWidget {
  const CustomMediaPickerCard({
    super.key,
    this.aspectRatio = 1 / 1,
    this.fileMediaPath,
    this.networkMediaPath,
    this.onTap,
    this.onMediaTap,
    this.widgetAlignment = Alignment.bottomCenter,
    this.widgetOnMedia,
    this.height,
    this.width,
    this.hintText,
    this.hintIcon,
  });

  final double aspectRatio;
  final String? fileMediaPath;
  final String? networkMediaPath;
  final Function()? onTap;
  final Function()? onMediaTap;
  final Alignment widgetAlignment;
  final Widget? widgetOnMedia;
  final double? height;
  final double? width;
  final String? hintText;
  final Widget? hintIcon;

  @override
  State<CustomMediaPickerCard> createState() => _CustomMediaPickerCardState();
}

class _CustomMediaPickerCardState extends State<CustomMediaPickerCard> {
  VideoPlayerController? _videoController;
  bool _isVideo = false;

  @override
  void initState() {
    super.initState();
    _checkIfVideo();
  }

  void _checkIfVideo() {
    final filePath = widget.fileMediaPath ?? widget.networkMediaPath ?? "";
    if (filePath.endsWith('.mp4') || filePath.endsWith('.mov') || filePath.endsWith('.avi')) {
      _isVideo = true;
      if (widget.fileMediaPath != null) {
        _videoController = VideoPlayerController.file(File(widget.fileMediaPath!))
          ..initialize().then((_) {
            setState(() {});
          });
      } else if (widget.networkMediaPath != null) {
        _videoController = VideoPlayerController.network(widget.networkMediaPath!)
          ..initialize().then((_) {
            setState(() {});
          });
      }
    }
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: widget.aspectRatio,
      child: SizedBox(
        height: widget.height,
        width: widget.width,
        child: widget.fileMediaPath == null && widget.networkMediaPath == null
            ? GestureDetector(
                onTap: widget.onTap,
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
                      if (widget.hintIcon != null) widget.hintIcon ?? const SizedBox(),
                      if (widget.hintIcon != null) const SpaceH8(),
                      if (widget.hintText?.isNotEmpty ?? false)
                        Text(
                          widget.hintText ?? "",
                          style: Get.textTheme.bodySmall,
                        ),
                    ],
                  ),
                ),
              )
            : GestureDetector(
                onTap: () {
                  widget.onMediaTap?.call();
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(kBorderRadius),
                    border: Border.all(
                      color: Get.theme.splashColor,
                    ),
                  ),
                  child: _isVideo
                      ? _videoController != null && _videoController!.value.isInitialized
                          ? Stack(
                              alignment: Alignment.center,
                              children: [
                                AspectRatio(
                                  aspectRatio: _videoController!.value.aspectRatio,
                                  child: VideoPlayer(_videoController!),
                                ),
                                Icon(Icons.play_circle_fill, size: 50, color: Colors.white),
                              ],
                            )
                          : const Center(child: CircularProgressIndicator())
                      : widget.fileMediaPath != null
                          ? Image.file(
                              File(widget.fileMediaPath!),
                              fit: BoxFit.cover,
                            )
                          : Image.network(
                              widget.networkMediaPath!,
                              fit: BoxFit.cover,
                            ),
                ),
              ),
      ),
    );
  }
}
