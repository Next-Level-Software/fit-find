import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';

import '../../../constants/app_constants.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/custom_avatar.dart';
import '../../../widgets/custom_buttons.dart';
import '../controllers/my_profile_controller.dart';

class MyProfileView extends GetView<MyProfileController> {
  const MyProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.primaryColor,
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          // padding: ,
          child: Column(
            children: [
              Container(
                color: Get.theme.primaryColor,
                padding: EdgeInsets.all(kPadding),
                child: Column(
                  children: [
                    Gap(40),
                    CustomAppBarMenu(),
                    Gap(20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            CustomAvatar(
                              size: 64, isRounded: true,
                              // text: "Raheel",
                              color: Color(0xFF003653),
                              // text: 'Raheel'
                              //     "",
                              // imagePath: ImagePaths.GYM,
                            ),
                            Positioned(
                              right: 0,
                              top: 2,
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
                                iconData: Icons.circle_notifications,
                                color: Colors.transparent,
                                // iconSize: 12,
                                isSmall: true,
                                width: 14,

                                backgroundColor: Color(0xFF57C499),
                              ),
                            ),
                          ],
                        ),
                        Gap(10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Muhammad Ali ',
                              style: Get.textTheme.labelLarge
                                  ?.copyWith(color: Colors.white),
                            ),
                            // Text(
                            //   '👋',
                            //   style: Get.textTheme.labelLarge,
                            // ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              ImagePaths.LOCATION,
                              color: Colors.white,
                            ),
                            // SizedBox(width: kSpacing),
                            Text(
                              'Kuwait, Al Salam Street,',
                              style: Get.textTheme.labelLarge
                                  ?.copyWith(color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Gap(20),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: Get.height,
                    // width: 100,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                  ),
                  Positioned(
                    top: -20,
                    left: 0,
                    right: 0,
                    child: Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: kPadding),
                        child: Column(
                          children: [
                            ListView.separated(
                                physics: NeverScrollableScrollPhysics(),
                                separatorBuilder: (context, index) {
                                  return Gap(8);
                                },
                                shrinkWrap: true,
                                itemCount: controller.menuItems.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return ListTile(
                                    onTap: () {
                                      String title = controller.menuItems[index]
                                              ["title"] ??
                                          "";

                                      switch (title) {
                                        case "My Profile":
                                          Get.toNamed(Routes.PROFILE);
                                          break;
                                        case "Subscriptions":
                                          // Navigate to subscriptions
                                          Get.toNamed(Routes.SUBSCRIPTIONS);
                                          break;
                                        case "Order History":
                                          break;
                                        case "Languages":
                                          // Navigate to chat
                                          Get.toNamed(Routes.LANGUAGE);
                                          break;
                                        case "Favorites":
                                          Get.toNamed(Routes.FAVORITE);
                                          break;
                                        case "Password":
                                          Get.toNamed(Routes.UPDATE_PASSWORD);
                                          break;
                                        case "Contact Us":
                                          Get.toNamed(Routes.CONTACT_US);

                                          break;
                                        default:
                                          print(
                                              "Unknown menu item selected: $title");
                                      }
                                    },
                                    title: Row(
                                      children: [
                                        Text(
                                          controller.menuItems[index]['title'],
                                          style: TextStyle(
                                              color:
                                                  AppColors.primaryBlackColor),
                                        ),
                                        // if (controller.menuItems[index]["title"] ==
                                        //     "Subscriptions")
                                        //   Padding(
                                        //     padding:
                                        //         const EdgeInsets.only(left: kPadding),
                                        //     child: CustomTextButton(
                                        //       text: (MySharedPref
                                        //                       .getSubscriptionDetail()
                                        //                   ?.package !=
                                        //               null)
                                        //           ? "${MySharedPref.getSubscriptionDetail()?.price?.totalPaid} KWD / ${MySharedPref.getSubscriptionDetail()?.package?.duration}"
                                        //           : "Free",
                                        //       onPress: () {
                                        //         Get.toNamed(Routes.SUBSCRIPTION_PLAN);
                                        //       },
                                        //       background: Colors.white,
                                        //       isSmall: true,
                                        //       color: AppColors.primaryGreyColor,
                                        //     ),
                                        //   ),
                                      ],
                                    ),
                                    leading: SvgPicture.asset(
                                      controller.menuItems[index]['iconPath'],
                                    ),
                                    trailing: Icon(Icons.arrow_forward),
                                  );
                                }),
                            Gap(8),
                            ListTile(
                              onTap: () {},
                              title: Row(
                                children: [
                                  Text(
                                    'Log Out',
                                    style: TextStyle(
                                        color: AppColors.primaryBlackColor),
                                  ),
                                  // if (controller.menuItems[index]["title"] ==
                                  //     "Subscriptions")
                                  //   Padding(
                                  //     padding:
                                  //         const EdgeInsets.only(left: kPadding),
                                  //     child: CustomTextButton(
                                  //       text: (MySharedPref
                                  //                       .getSubscriptionDetail()
                                  //                   ?.package !=
                                  //               null)
                                  //           ? "${MySharedPref.getSubscriptionDetail()?.price?.totalPaid} KWD / ${MySharedPref.getSubscriptionDetail()?.package?.duration}"
                                  //           : "Free",
                                  //       onPress: () {
                                  //         Get.toNamed(Routes.SUBSCRIPTION_PLAN);
                                  //       },
                                  //       background: Colors.white,
                                  //       isSmall: true,
                                  //       color: AppColors.primaryGreyColor,
                                  //     ),
                                  //   ),
                                ],
                              ),
                              leading: Container(
                                padding: EdgeInsets.all(5),
                                color: Color(0xFFEC3C0C),
                                child: SvgPicture.asset(ImagePaths.LOGOUT),
                              ),
                              trailing: Icon(Icons.arrow_forward),
                            )
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
    );
  }
}

class CustomAppBarMenu extends StatelessWidget {
  const CustomAppBarMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Gap(20),
        Expanded(
          child: Row(
            children: [
              CustomIconButton(
                isSmall: true,
                color: Color(0xFF300F0F),
                iconData: Icons.arrow_back,
              ),
              Gap(10),
            ],
          ),
        ),
        Row(
          children: [
            CustomIconButton(
              isSmall: true,
              color: Color(0xFF300F0F),
              iconData: Icons.shopping_cart,
            ),
            Gap(
              10,
            ),
            CustomIconButton(
              isSmall: true,
              color: Color(0xFF300F0F),
              iconData: Icons.notifications,
            ),
            Gap(
              10,
            ),
            SvgPicture.asset(
              ImagePaths.LOGO,
              color:
                  Colors.white, // Replace with your logo asset
              height: 30, // Adjust as needed
              width: 60, // Adjust as needed
              // fit: BoxFit
              //     .contain, // Ensures the image fits within bounds
            ),
          ],
        ),
      ],
    );
  }
}
