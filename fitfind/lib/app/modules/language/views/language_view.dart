import 'package:fitfind/app/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';

import '../../../widgets/custom_buttons.dart';
import '../controllers/language_controller.dart';

class LanguageView extends GetView<LanguageController> {
  const LanguageView({super.key});
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Gap(20),
                        Expanded(
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomIconButton(
                                isSmall: true,
                                color: Color(0xFF300F0F),
                                iconData: Icons.arrow_back,
                                onTap: (){
                                  Get.back();
                                },
                              ),
                              // Align(
                              //   alignment: Alignment.centerRight,
                              //   child: Text('Language',textAlign: TextAlign.center,))
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
                              height: 24, // Adjust as needed
                              width: 50, // Adjust as needed
                              // fit: BoxFit
                              //     .contain, // Ensures the image fits within bounds
                            ),
                          ],
                        ),
                      ],
                    ),
                    Gap(20),
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
                            Gap(40),
                            ListTile(
                              onTap: () {},
                              title: Row(
                                children: [
                                  Text(
                                    'English',
                                    style: TextStyle(
                                        color: AppColors.primaryBlackColor),
                                  ),
                                ],
                              ),
                              leading: SvgPicture.asset(ImagePaths.EN),
                              trailing: Icon(Icons.arrow_forward),
                            ),
                            Gap(8),
                            ListTile(
                              onTap: () {},
                              title: Row(
                                children: [
                                  Text(
                                    'Arabic',
                                    style: TextStyle(
                                        color: AppColors.primaryBlackColor),
                                  ),
                                ],
                              ),
                              leading: SvgPicture.asset(ImagePaths.AR),
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
