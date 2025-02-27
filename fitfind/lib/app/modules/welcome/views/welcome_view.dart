import 'dart:ui';

import 'package:fitfind/app/routes/app_pages.dart';
import 'package:fitfind/app/widgets/custom_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../constants/app_constants.dart';
import '../controllers/welcome_controller.dart';

class WelcomeView extends GetView<WelcomeController> {
  const WelcomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('WelcomeView'),
      //   centerTitle: true,
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none, // Ensures shadow is visible
                children: [
                  // Blurred Shadow Effect
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: -5, // Adjust shadow position
                    child: ImageFiltered(
                      imageFilter: ImageFilter.blur(
                          sigmaX: 10, sigmaY: 10), // Blur effect
                      child: Opacity(
                        opacity: 0, // Adjust shadow intensity
                        child: Image.asset(
                          ImagePaths.WELCOME_IMAGE,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),

                  // Main Image with Bottom Fade Effect
                  Stack(
                    children: [
                      Image.asset(
                        ImagePaths.WELCOME_IMAGE,
                        fit: BoxFit.cover,
                      ),
                      // White Gradient Fade Effect at Bottom
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: Get.height * .12,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  Colors.white, // Fully white at the bottom
                                  Colors.white
                                      .withOpacity(0.0), // Transparent fade
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              // Gap(20),
              SvgPicture.asset(
                ImagePaths.LOGO,
              ),
              Gap(20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kPadding),
                child: Column(
                  children: [
                    Text(
                      'Welcome to our Health & Fitness Marketplace!',
                      style: Get.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        // fontFamily: 'a Autobus Omnibus',
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Gap(20),
                    Text(
                      'Unlock the power of personalization with our AI-driven recommendations tailored to you.',
                      textAlign: TextAlign.center,
                      style: Get.textTheme.bodyLarge!.copyWith(
                          // fontWeight: FontWeight.bold,
                          // fontFamily: 'a Autobus Omnibus',
                          ),
                    ),
                    Gap(20),
                    // SignInButton(
                    //     buttonType: ButtonType.google,
                    //     buttonSize: ButtonSize.large,
                    //     width: Get.width,
                        
                    //     onPressed: () {
                    //       print('click');
                    //     }),
                    CustomButton(
                      onPress: () {},
                      isOutlined: true,
                      text: "Continue with google",
                      iconPosition: IconPosition.trailing,
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.black,
                      // svgImage: ImagePaths.GOOGLE,
                      // icon: FontAwesome.google_brand,
                      
                    ),
                    Gap(20),
                    CustomButton(
                        onPress: () {},
                        isOutlined: true,
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.black,
                        text: "Continue with Apple",
                        icon: FontAwesome.apple_brand),
                    Gap(20),
                    CustomButton(
                      onPress: () {},
                      isOutlined: true,
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.black,
                      text: "Log In with Phone Number",
                    ),
                    Gap(20),
                    CustomButton(
                      onPress: () {
                        Get.toNamed(Routes.ONBOARD);
                      },
                      text: "Create Account",
                      // color: Get.theme.primaryColor,
                      textColor: Colors.white,
                    ),
                    Gap(20),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
