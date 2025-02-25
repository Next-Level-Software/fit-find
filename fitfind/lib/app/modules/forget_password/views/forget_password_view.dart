import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';

import '../../../constants/app_constants.dart';
import '../../../widgets/custom_buttons.dart';
import '../../../widgets/custom_input.dart';
import '../controllers/forget_password_controller.dart';

class ForgetPasswordView extends GetView<ForgetPasswordController> {
  const ForgetPasswordView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ForgetPasswordController>(builder: (_) {
      return PopScope(
        canPop: controller.segmentState == PageState.numberVerification,
        onPopInvokedWithResult: (didPop, result) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (controller.segmentState == PageState.otpVerification) {
              controller.segmentState = PageState.numberVerification;
              controller.update();
            } else if (controller.segmentState == PageState.passwordRest) {
              controller.segmentState = PageState.otpVerification;
              controller.update();
            } else {
              if (!Get.isDialogOpen!) {
                Get.back();
              }
            }
          });
        },
        child: Scaffold(
          // appBar: customAppBar(
          // title: 'Reset Password',
          // appColor: Get.theme.scaffoldBackgroundColor,
          // onPressed: () {
          //   if (controller.segmentState == PageState.otpVerification) {
          //     controller.segmentState = PageState.numberVerification;
          //     controller.update();
          //   } else if (controller.segmentState == PageState.passwordRest) {
          //     controller.segmentState = PageState.otpVerification;
          //     controller.update();
          //   } else {
          //     if (!Get.isDialogOpen!) {
          //       Get.back();
          //     }
          //   }
          // }),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(kPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(60),
                  Align(
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      ImagePaths.LOGO,
                    ),
                  ),
                  if (controller.segmentState == PageState.numberVerification)
                    numberVerification(),
                  if (controller.segmentState == PageState.otpVerification)
                    otpVerification(),
                  if (controller.segmentState == PageState.passwordRest)
                    resetPassword(),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Form resetPassword() {
    return Form(
      // key: controller.forgetPassFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              controller.segmentState = PageState.otpVerification;
              controller.update();
            },
            child: Container(
              padding: EdgeInsets.all(kSpacing),
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Color(0xFFECECEC)),
              child: Icon(Icons.arrow_back),
            ),
          ),
          Gap(20),
          Text(
            "Set a new password",
            style: Get.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          Gap(10),
          Center(
            child: Text(
              "Create a new password. Ensure it differs from previous ones for security",
              // textAlign: TextAlign.center,
              style: Get.textTheme.bodySmall,
            ),
          ),
          Gap(20),
          Text(
            'Password',
            style: Get.textTheme.bodyMedium?.copyWith(
                // color: AppColors.primaryBlackColor,
                ),
          ),
          CustomInput(
            textInputType: TextInputType.visiblePassword,
            // backgroundColor: Color(0xFFF9F9F9),
            // controller: controller.passwordController,
            formValidator: MultiValidator([
              RequiredValidator(errorText: "Password is required"),
              MinLengthValidator(8,
                  errorText: "Password must be greater than 8 characters")
            ]).call,
            iconColor: Colors.black,
            hint: "Enter password",
            hintColor: Colors.black,
            isBoldHint: true,
            borderColor: AppColors.primaryOutlinedColor,

            textInputAction: TextInputAction.done,
            isObscure: true,
          ),
          Text(
            'Confirm Password',
            style: Get.textTheme.bodyMedium?.copyWith(
                // color: AppColors.primaryBlackColor,
                ),
          ),
          CustomInput(
            textInputType: TextInputType.visiblePassword,
            // backgroundColor: Color(0xFFF9F9F9),

            // controller: controller.confirmPasswordController,
            formValidator: MultiValidator([
              RequiredValidator(errorText: "Password is required"),
              MinLengthValidator(8,
                  errorText: "Password must be greater than 8 characters")
            ]).call,
            iconColor: Colors.black,
            hint: "Re-Enter Password",
            hintColor: Colors.black,
            isBoldHint: true,
            borderColor: AppColors.primaryOutlinedColor,
            textInputAction: TextInputAction.done,
            isObscure: true,
          ),
          Gap(20),
          CustomButton(
            text: "Update password",
            onPress: () {
              // controller.resetPassword();
            },
          ),
        ],
      ),
    );
  }

  Column otpVerification() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            controller.segmentState = PageState.numberVerification;
            controller.update();
          },
          child: Container(
            padding: EdgeInsets.all(kSpacing),
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Color(0xFFECECEC)),
            child: Icon(Icons.arrow_back),
          ),
        ),
        Gap(20),
        // Gap(40),
        Text(
          "Check your email",
          style: Get.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        Gap(10),
        Center(
          child: Text(
            "We sent a reset link to alpha...@gmail.com enter 5 digit code that mentioned in the email",
            // textAlign: TextAlign.center,
            style: Get.textTheme.bodySmall,
          ),
        ),
        Gap(30),
        CustomVerificationInput(
          onChange: (val) {
            // controller.otpController.text = val;
          },
          onSubmitted: (p0) {
            // Get.toNamed(Routes.COMPLETE_REGISTRATION);
            // controller.verifyOtp();
          },
        ),
        // Gap(20),
        CustomButton(
          text: "Verify Code",
          onPress: () {
            controller.segmentState = PageState.passwordRest;
            controller.update();
            // controller.submitPhoneNumber();
          },
        ),
        Gap(20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Haven’t got the email yet? ',
              style: TextStyle(color: Colors.black),
            ),
            // Gap(4),
            CustomTextButton(
              horizontalSpace: 0,
              alignment: Alignment.centerLeft,
              text: 'Resend email',
              onPress: () {
                // Get.toNamed(Routes.SIGN_IN);
              },
              background: Colors.transparent,
              color: Get.theme.primaryColor,
              // showUnderline: true,
            ),
          ],
        ),
        // 1253456
      ],
    );
  }

  Form numberVerification() {
    return Form(
      // key: controller.forgetPassFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Container(
              padding: EdgeInsets.all(kSpacing),
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Color(0xFFECECEC)),
              child: Icon(Icons.arrow_back),
            ),
          ),
          // IconButton(
          //   onPressed: () {
          //     Get.back();
          //   },
          //   icon: Icon(Icons.arrow_back),
          // ),
          Gap(20),
          Text(
            "Forgot Password",
            style: Get.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          Gap(10),
          Text(
            "Please enter your email to reset the password",
            style: Get.textTheme.bodySmall,
          ),
          Gap(20),
          Text(
            'Your Email',
            style: Get.textTheme.bodyMedium?.copyWith(
                // color: AppColors.primaryBlackColor,
                fontWeight: FontWeight.w600),
          ),
          CustomInput(
            formValidator: MultiValidator([
              RequiredValidator(errorText: "Email is required"),
              EmailValidator(errorText: "Enter valid email"),
            ]).call,
            textInputType: TextInputType.emailAddress,
            // backgroundColor: Color(0xFFF9F9F9),
            // controller: controller.emailController,
            // iconColor: Colors.black,
            hint: "Enter your Email",
            hintColor: Colors.black,
            isBoldHint: true,
            // icon: Icons.alternate_email,
            borderColor: AppColors.primaryOutlinedColor,

            textInputAction: TextInputAction.next,
          ),
          Gap(20),
          CustomButton(
            text: "Reset password",
            onPress: () {
              controller.segmentState = PageState.otpVerification;
              controller.update();
              // controller.submitPhoneNumber();
            },
          ),
        ],
      ),
    );
  }
}
