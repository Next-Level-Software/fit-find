import 'package:flutter/material.dart';
// import 'package:growth/app/components/photo_view.dart';
import '/app/constants/app_constants.dart';
import 'package:photo_view/photo_view.dart';
import 'package:get/get.dart';
import '/app/environment/environment.dart';

class ImageViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ImageViewController>(
      () => ImageViewController(),
    );
  }
}

class ImageViewController extends GetxController {
  @override
  String image = '';

  @override
  void onInit() {
    if (Get.arguments != null) {
      image = Get.arguments["image"];
    }
    super.onInit();
  }
}

class ImageViewPage extends StatelessWidget {
  const ImageViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    var imageViewController = Get.put(ImageViewController());

    return Scaffold(
      backgroundColor: Colors.black,
      // appBar: AppBar(
      //   leading: IconButton(
      //     icon: const Icon(Icons.close, color: Colors.white),
      //     onPressed: () => Navigator.of(context).pop(),
      //   ),
      //   backgroundColor: Colors.black,
      //   elevation: 0,
      //   automaticallyImplyLeading: true,
      // ),
      body: Stack(
        children: [
          SizedBox(
            height: Get.height,
            width: Get.width,
            child: PhotoView(
              heroAttributes: PhotoViewHeroAttributes(
                tag: imageViewController.image,
              ),
              imageProvider: NetworkImage(
                FILE_BASE_URL + imageViewController.image,
              ),
              enableRotation: false,
              backgroundDecoration: const BoxDecoration(color: Colors.black),
              loadingBuilder: ((context, event) =>
                  const Center(child: CircularProgressIndicator())),
            ),
          ),
          Positioned(
            top: kTopPadding(context) + kPadding,
            left: kLeftPadding(context) + kPadding,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ],
      ),
    );
  }
}
