import 'package:fitfind/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../components/custom_bottombar.dart';
import '../../../config/theme/light_theme_colors.dart';
import '../../../constants/app_constants.dart';
import '../../../widgets/custom_avatar.dart';
import '../../../widgets/custom_buttons.dart';
import '../../../widgets/custom_input.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(builder: (_) {
      return Scaffold(
          backgroundColor: Get.theme.primaryColor,
          appBar: AppBar(
            backgroundColor: Get.theme.primaryColor,
            leading: IconButton(
              color: Colors.white,
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.arrow_back),
            ),
            title: const Text(
              'My profile',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            centerTitle: true,
          ),
          body: SafeArea(
            top: false,
            child: SingleChildScrollView(
              // padding: ,
              child: Column(
                children: [
                  Gap(40),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        height: Get.height,
                        // width: 100,
                        decoration: BoxDecoration(
                            color: LightThemeColors
                                .scaffoldBackgroundColorLightGey,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30))),
                      ),
                      Positioned(
                        // top: -40,
                        left: 0,
                        right: 0,

                        child: Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: kPadding),
                            child: Column(
                              children: [
                                Gap(20),
                                SvgPicture.asset(
                                  ImagePaths.LOGO,
                                ),
                                Gap(20),
                                Stack(clipBehavior: Clip.none, children: [
                                  CustomAvatar(
                                    size: 70, isRounded: true,
                                    // text: "Raheel",
                                    color: Color(0xFF003653),
                                    // text: 'Raheel'
                                    //     "",
                                    imagePath: "",
                                  ),
                                  Positioned(
                                    right: 0,
                                    top: -5,
                                    child: CustomIconButton(
                                      height: 22,
                                      onTap: () {
                                        // Get.toNamed(
                                        //   // Routes.EDIT_COACH_ASSISTANTS,
                                        //   // arguments: {
                                        //   //   "assistantId": assistantUsers?.id
                                        //   // },
                                        // );
                                      },
                                      iconData: HeroIcons.pencil_square,
                                      color: Colors.black,
                                      iconSize: 12,
                                      isSmall: true,
                                      backgroundColor: Color(0xFFD9D9D9),
                                    ),
                                  ),
                                ]),
                                Gap(20),
                                Form(
                                  key: controller.profileFormKey,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Full Name',
                                        style:
                                            Get.textTheme.bodyMedium?.copyWith(
                                          color: AppColors.primaryBlackColor,
                                        ),
                                      ),
                                      CustomInput(
                                        formValidator: MultiValidator([
                                          RequiredValidator(
                                              errorText: "Name is required"),
                                        ]).call,
                                        textInputType: TextInputType.text,
                                        // backgroundColor: Color(0xFFF9F9F9),
                                        controller: controller.nameController,
                                        // iconColor: Colors.black,
                                        hint: "Enter your Name",
                                        hintColor: Colors.black,
                                        // icon: HeroIcons.pencil_square,
                                        suffixIcon: Icon(
                                          HeroIcons.pencil_square,
                                          color: Colors.black,
                                          size: 16,
                                        ),

                                        isBoldHint: true,
                                        // icon: Icons.alternate_email,
                                        borderColor:
                                            AppColors.primaryOutlinedColor,

                                        textInputAction: TextInputAction.next,
                                      ),
                                      Text(
                                        'Phone Number',
                                        style:
                                            Get.textTheme.bodyMedium?.copyWith(
                                          color: AppColors.primaryBlackColor,
                                        ),
                                      ),
                                      CustomInput(
                                        suffixIcon: Icon(
                                          HeroIcons.pencil_square,
                                          color: Colors.black,
                                          size: 16,
                                        ),
                                        formValidator: MultiValidator([
                                          RequiredValidator(
                                              errorText:
                                                  "Enter phone is required"),
                                          MinLengthValidator(8,
                                              errorText:
                                                  "Phone should be contained at least 8 character")
                                        ]).call,
                                        textInputType: TextInputType.phone,
                                        // backgroundColor: Color(0xFFF9F9F9),
                                        controller: controller.phoneController,
                                        iconColor: Colors.black,
                                        hint: "Enter  phone Number",
                                        hintColor: Colors.black,

                                        isBoldHint: true,
                                        // icon: Icons.phone_android_outlined,
                                        borderColor:
                                            AppColors.primaryOutlinedColor,

                                        textInputAction: TextInputAction.next,
                                      ),
                                      Text(
                                        'Email',
                                        style:
                                            Get.textTheme.bodyMedium?.copyWith(
                                          color: AppColors.primaryBlackColor,
                                        ),
                                      ),
                                      CustomInput(
                                        suffixIcon: Icon(
                                          HeroIcons.pencil_square,
                                          color: Colors.black,
                                          size: 16,
                                        ),
                                        formValidator: MultiValidator([
                                          RequiredValidator(
                                              errorText: "Email is required"),
                                          EmailValidator(
                                              errorText: "Enter valid email"),
                                        ]).call,
                                        textInputType:
                                            TextInputType.emailAddress,
                                        // suffixIcon: SizedBox(
                                        //   height: 15,
                                        //   width: 15,
                                        //   child: SvgPicture.asset(ImagePaths.EDITTIING,height: 15,width: 15,)),
                                        // backgroundColor: Color(0xFFF9F9F9),
                                        controller: controller.emailController,
                                        // iconColor: Colors.black,
                                        hint: "Enter your Email",
                                        hintColor: Colors.black,
                                        isBoldHint: true,
                                        // icon: Icons.alternate_email,
                                        borderColor:
                                            AppColors.primaryOutlinedColor,

                                        textInputAction: TextInputAction.next,
                                      ),
                                      Text(
                                        'Password',
                                        style:
                                            Get.textTheme.bodyMedium?.copyWith(
                                          color: AppColors.primaryBlackColor,
                                        ),
                                      ),
                                      CustomInput(
                                        suffixIcon: Icon(
                                          HeroIcons.pencil_square,
                                          color: Colors.black,
                                          size: 16,
                                        ),
                                        textInputType:
                                            TextInputType.visiblePassword,
                                        // backgroundColor: Color(0xFFF9F9F9),
                                        controller:
                                            controller.passwordController,
                                        formValidator: MultiValidator([
                                          RequiredValidator(
                                              errorText:
                                                  "Password is required"),
                                          MinLengthValidator(8,
                                              errorText:
                                                  "Password must be greater than 8 characters")
                                        ]).call,
                                        iconColor: Colors.black,
                                        hint: "Enter password",
                                        hintColor: Colors.black,
                                        isBoldHint: true,
                                        borderColor:
                                            AppColors.primaryOutlinedColor,

                                        textInputAction: TextInputAction.done,
                                        isObscure: true,
                                      ),
                                      Gap(10),
                                    ],
                                  ),
                                ),
                                // Gap(5),
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.center,
                                //   children: [
                                //     Text(
                                //       maxLines: 1,
                                //       overflow: TextOverflow.ellipsis,
                                //       TokenUtil.getUserDataFromToken()?.name ??
                                //           "",
                                //       style: Get.textTheme.bodyLarge?.copyWith(
                                //         color: Colors.black,
                                //         fontWeight: FontWeight.w900,
                                //       ),
                                //     ),
                                //     Gap(5),
                                //     Icon(
                                //       (TokenUtil.getUserDataFromToken()?.gender ==
                                //               'male')
                                //           ? Icons.male_outlined
                                //           : Icons.female_outlined,
                                //       color: Get.theme.primaryColor,
                                //     )
                                //   ],
                                // )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: customBottomBar(
              widget: CustomButton(
                text: 'Update',
                onPress: () {
                  Get.toNamed(Routes.GENDER);
                },
              ),
              isBorder: false)
          //   ),
          );
    });
  }
}
