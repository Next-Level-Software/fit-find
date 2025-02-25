import 'package:fitfind/app/constants/app_constants.dart';
import 'package:fitfind/app/routes/app_pages.dart';
import 'package:fitfind/app/widgets/custom_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';

import '../../../widgets/custom_input.dart';
import '../controllers/otp_controller.dart';

class OtpView extends GetView<OtpController> {
  const OtpView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            children: [
              SizedBox(
                height: Get.width * 0.3,
              ),
              //  Gap(20),
              SvgPicture.asset(
                ImagePaths.LOGO,
              ),
              Gap(10),
              Text(
                'Verify Code',
                style: Get.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  // fontFamily: 'a Autobus Omnibus',
                ),
                textAlign: TextAlign.center,
              ),
              Gap(20),
              Center(
                child: Text(
                  "Check your SMS message. We’ve sent you the code at Email",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.primaryBlackColor),
                ),
              ),
              Gap(10),
              CustomVerificationInput(
                textEditingController: controller.otpController,
                onSubmitted: (p0) {
                  // Get.toNamed(Routes.COMPLETE_REGISTRATION);
                  // controller.checkOtp();
                },
              ),
              // Gap(50),
              const Text(
                "Try again in 30 secs",
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.primaryBlackColor),
              ),
              Gap(12),
              CustomButton(
                text: "Confirm email",
                onPress: () {
                  Get.toNamed(Routes.PROFILE);
                },
                // color: Color(0xFFED1C24),
                // background: Colors.transparent,
                // showUnderline: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
