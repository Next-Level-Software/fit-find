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
              Container(
                // height: Get.height * .8,
                width: Get.width,
                constraints: BoxConstraints(maxHeight: Get.height * .32),
                child:
                    // SvgImage( ImagePaths.WELCOME_IMAGE,type:),
                    //     SvgPicture.asset(
                    //   ImagePaths.WELCOME_IMAGE,
                    // )
                    Image.asset(
                  ImagePaths.WELCOME_IMAGE,
                  fit: BoxFit.cover,
                ),
              ),
              Gap(20),
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
                    CustomButton(
                      onPress: () {},
                      isOutlined: true,
                      text: "Continue with google",
                      iconPosition: IconPosition.leading,
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.black,
                      icon: FontAwesome.google_brand,
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
