import 'package:fitfind/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../constants/app_constants.dart';
import '../../../widgets/custom_buttons.dart';
import '../../../widgets/custom_input.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterController>(builder: (_) {
      return Scaffold(
        body: SafeArea(
          top: false,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Gap(18),
                // const SizedBox(
                //   height: 18,
                // ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Gap(60),
                      Align(
                        alignment: Alignment.center,
                        child: SvgPicture.asset(
                          ImagePaths.LOGO,
                        ),
                      ),
                      Gap(20),
                      Text(
                        "Welcome Back",
                        style: Get.textTheme.bodyLarge?.copyWith(
                          // color: Color(0xFFED1C24),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Gap(10),
                      // Text(
                      //   "7 Days free access to all features!",
                      //   style: TextStyle(fontWeight: FontWeight.bold),
                      // ),
                      // Gap(10),
                      Form(
                        key: controller.signUpFormKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Email',
                              style: Get.textTheme.bodyMedium?.copyWith(
                                color: AppColors.primaryBlackColor,
                              ),
                            ),
                            CustomInput(
                              formValidator: MultiValidator([
                                RequiredValidator(
                                    errorText: "Email is required"),
                                EmailValidator(errorText: "Enter valid email"),
                              ]).call,
                              textInputType: TextInputType.emailAddress,
                              // backgroundColor: Color(0xFFF9F9F9),
                              controller: controller.emailController,
                              // iconColor: Colors.black,
                              hint: "Enter your Email",
                              hintColor: Colors.black,
                              isBoldHint: true,
                              // icon: Icons.alternate_email,
                              borderColor: AppColors.primaryOutlinedColor,

                              textInputAction: TextInputAction.next,
                            ),
                            Text(
                              'Phone Number',
                              style: Get.textTheme.bodyMedium?.copyWith(
                                color: AppColors.primaryBlackColor,
                              ),
                            ),
                            CustomInput(
                              formValidator: MultiValidator([
                                RequiredValidator(
                                    errorText: "Enter phone is required"),
                                MinLengthValidator(8,
                                    errorText:
                                        "Phone should be contained at least 8 character")
                              ]).call,
                              textInputType: TextInputType.phone,
                              // backgroundColor: Color(0xFFF9F9F9),
                              controller: controller.phoneNumberController,
                              iconColor: Colors.black,
                              hint: "Enter  phone Number",
                              hintColor: Colors.black,
                              isBoldHint: true,
                              // icon: Icons.phone_android_outlined,
                              borderColor: AppColors.primaryOutlinedColor,

                              textInputAction: TextInputAction.next,
                            ),
                            Text(
                              'Password',
                              style: Get.textTheme.bodyMedium?.copyWith(
                                color: AppColors.primaryBlackColor,
                              ),
                            ),
                            CustomInput(
                              textInputType: TextInputType.visiblePassword,
                              // backgroundColor: Color(0xFFF9F9F9),
                              controller: controller.passwordController,
                              formValidator: MultiValidator([
                                RequiredValidator(
                                    errorText: "Password is required"),
                                MinLengthValidator(8,
                                    errorText:
                                        "Password must be greater than 8 characters")
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
                                color: AppColors.primaryBlackColor,
                              ),
                            ),
                            CustomInput(
                              textInputType: TextInputType.visiblePassword,
                              // backgroundColor: Color(0xFFF9F9F9),

                              controller: controller.confirmPasswordController,
                              formValidator: MultiValidator([
                                RequiredValidator(
                                    errorText: "Password is required"),
                                MinLengthValidator(8,
                                    errorText:
                                        "Password must be greater than 8 characters")
                              ]).call,
                              iconColor: Colors.black,
                              hint: "Re-Enter Password",
                              hintColor: Colors.black,
                              isBoldHint: true,
                              borderColor: AppColors.primaryOutlinedColor,
                              textInputAction: TextInputAction.done,
                              isObscure: true,
                            ),
                            Gap(10),
                            CustomButton(
                              text: "Sign Up",
                              onPress: (){
                                Get.toNamed(Routes.OTP);
                              }
                              // controller.onUserCheck,
                              // color: Get.theme.primaryColor,
                              // textColor: Colors.white,
                            )
                          ],
                        ),
                      ),
                      Gap(10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account?',
                            style: TextStyle(color: Colors.black),
                          ),
                          // Gap(4),
                          CustomTextButton(
                            horizontalSpace: 0,
                            alignment: Alignment.centerLeft,
                            text: 'Sign In',
                            onPress: () {
                              Get.toNamed(Routes.SIGN_IN);
                            },
                            background: Colors.transparent,
                            color: Get.theme.primaryColor,
                            // showUnderline: true,
                          ),
                        ],
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
                    ],
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
