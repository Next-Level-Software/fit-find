import 'package:fitfind/app/widgets/custom_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../../constants/app_constants.dart';
import '../controllers/onboard_controller.dart';

class OnboardView extends GetView<OnboardController> {
  const OnboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnboardController>(builder: (_) {
      return Scaffold(
        // appBar: AppBar(
        //   title: const Text('OnboardView'),
        //   centerTitle: true,
        // ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                CarouselSlider(
                  carouselController: controller.carouselController,
                  items: controller.imageList.map((imagePath) {
                    return Container(
                      width: Get.width,
                      constraints: BoxConstraints(maxHeight: Get.height * 0.32),
                      child: Image.asset(
                        imagePath,
                        fit: BoxFit.cover,
                        width: Get.width,
                      ),
                    );
                  }).toList(),
                  options: CarouselOptions(
                    height: Get.height * 0.32,
                    autoPlay: false,
                    enlargeCenterPage: true,
                    viewportFraction: 1.0,
                    onPageChanged: (index, reason) {
                      controller.currentIndex = index;
                      controller.update();
                    },
                  ),
                ),
                Gap(20),

                // Logo
                SvgPicture.asset(ImagePaths.LOGO),

                Gap(20),

                // Text Content
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kPadding),
                  child: Column(
                    children: [
                      Text(
                        'Start your workout today',
                        textAlign: TextAlign.center,
                        style: Get.textTheme.bodyLarge,
                      ),
                      Text(
                        'Welcome to our Health & Fitness Marketplace!',
                        style: Get.textTheme.headlineMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'Unlock the power of personalization with our AI-driven recommendations tailored to you.',
                        textAlign: TextAlign.center,
                        style: Get.textTheme.bodyLarge,
                      ),

                      // Next Button
                    ],
                  ),
                ),
                // Custom Indicator Dots
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: controller.imageList.asMap().entries.map((entry) {
                    return GestureDetector(
                      onTap: () {
                        controller.currentIndex = entry.key;
                        controller.update();
                      },
                      child: Container(
                        width:
                            controller.currentIndex == entry.key ? 29.0 : 11.0,
                        height:
                            controller.currentIndex == entry.key ? 11.0 : 11.0,
                        margin: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 4.0),
                        decoration: BoxDecoration(
                          // shape: BoxShape.circle,
                          borderRadius: controller.currentIndex == entry.key
              ? BorderRadius.circular(20) // Capsule shape when active
              : BorderRadius.circular(50), 
                          color: controller.currentIndex == entry.key
                              ? Get.theme.primaryColor
                              : Colors.grey,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                // Gap(20),

                Padding(
                  padding: const EdgeInsets.all(kPadding),
                  child: CustomButton(
                    text: 'Next',
                    onPress: () {
                      controller.changeIndex((controller.currentIndex ??0)+ 1);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
