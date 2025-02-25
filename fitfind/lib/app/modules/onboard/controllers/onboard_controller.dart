import 'package:get/get.dart';

import '../../../constants/app_constants.dart';
import '../../../routes/app_pages.dart';
import 'package:carousel_slider/carousel_controller.dart';
class OnboardController extends GetxController {
 int currentIndex = 0; // Initialized to 0 instead of `null`
  final CarouselSliderController carouselController = CarouselSliderController(); // Correct controller

  final List<String> imageList = [
    ImagePaths.ONBOARD1,
    ImagePaths.ONBOARD2,
    ImagePaths.ONBOARD3,
  ];

  void changeIndex(int index) {
    print(index);
    if (index >= imageList.length) {
      Get.toNamed(Routes.REGISTER); // Go to next screen if index exceeds limit
    } else {
      currentIndex = index;
      carouselController.jumpToPage( // Correct method for navigation
        index ,
        // duration: Duration(milliseconds: 500),
        // curve: Curves.easeInOut,
      );
    }
    update(); // Update UI
  }

  final count = 0.obs;
  @override
  void onInit() {
    currentIndex = 0;
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
