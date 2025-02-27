import 'package:fitfind/app/widgets/custom_avatar.dart';
import 'package:fitfind/app/widgets/custom_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';

import '../../../config/theme/light_theme_colors.dart';
import '../../../constants/app_constants.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.primaryColor,
      appBar: AppBar(
        backgroundColor: Get.theme.primaryColor,

        // leading: IconButton(
        //   color: Colors.white,
        //   onPressed: () {
        //     Get.back();
        //   },
        //   icon: Icon(Icons.arrow_back),
        // ),
        title: 
          // height: Get.width*0.3,
          Column(
            children: [
              Gap(60),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Gap(20),
                  Expanded(
                    child: Row(
                      children: [
                        CustomAvatar(
                          size: 46,
                        ),
                        Gap(10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Hello, Welcome ',
                                  style: Get.textTheme.labelLarge
                                      ?.copyWith(color: Colors.white),
                                ),
                                Text(
                                  '👋',
                                  style: Get.textTheme.labelLarge,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  ImagePaths.LOCATION,
                                  color: Colors.white,
                                ),
                                SizedBox(width: kSpacing),
                                Text(
                                  'Saudi Arabia',
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
                        color: Colors.white, // Replace with your logo asset
                        height: 30, // Adjust as needed
                        width: 60, // Adjust as needed
                        // fit: BoxFit
                        //     .contain, // Ensures the image fits within bounds
                      ),
                    ],
                  ),
                ],
              ),
              Gap(50),
            ],
          ),
        
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
                      color: LightThemeColors.scaffoldBackgroundColorLightGey,
                      // borderRadius: BorderRadius.only(
                      //     topLeft: Radius.circular(30),
                      //     topRight: Radius.circular(30))
                    ),
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
                            CollectionCard(
                              backgroundColor: Color(0xFFFFD256),
                              title: "Brand Fashion",
                              subTitle: "Lorem Ipsum is simply dummy text of the",
                              image: ImagePaths.FASHION,
                              press: (){

                              },
                              buttonText: "Find More",
                            ),
                            Gap(20),
                            CollectionCard(
                              backgroundColor: Get.theme.primaryColor,
                              title: "Sport Academy",
                              subTitle: "Lorem Ipsum is simply dummy text of the",
                              image: ImagePaths.PLAYER,
                              press: (){

                              },
                              buttonText: "More Details",
                            ),
                            Gap(20),
                            CollectionCard(
                              backgroundColor: Color(0xFF57C499),
                              title: "Gym Sport",
                              subTitle: "Lorem Ipsum is simply dummy text of the",
                              image: ImagePaths.GYM,
                              press: (){

                              },
                              buttonText: "More Details",
                            ),
                            Gap(20),
                            // Container(
                            //   decoration: BoxDecoration(
                            //     color: Colors.teal,
                            //     borderRadius: BorderRadius.circular(15),
                            //   ),
                            //   // padding: EdgeInsets.all(kPadding),
                            //   child: Stack(
                            //     children: [
                            //       Positioned(
                            //         left: 0,
                            //         child: Image.asset(
                            //           ImagePaths
                            //               .PLAYER, // Replace with actual image
                            //           height: 150,
                            //         ),
                            //       ),
                            //       Column(
                            //         crossAxisAlignment:
                            //             CrossAxisAlignment.start,
                            //         children: [
                            //           SizedBox(height: 20),
                            //           Text(
                            //             'Sport Academy',
                            //             style: TextStyle(
                            //               color: Colors.white,
                            //               fontSize: 20,
                            //               fontWeight: FontWeight.bold,
                            //             ),
                            //           ),
                            //           SizedBox(height: 8),
                            //           Text(
                            //             'Lorem Ipsum is simply dummy text of the',
                            //             style: TextStyle(
                            //               color: Colors.white,
                            //               fontSize: 14,
                            //             ),
                            //           ),
                            //           SizedBox(height: 12),
                            //           ElevatedButton(
                            //             onPressed: () {},
                            //             style: ElevatedButton.styleFrom(
                            //               backgroundColor: Colors.white,
                            //               shape: RoundedRectangleBorder(
                            //                 borderRadius:
                            //                     BorderRadius.circular(8),
                            //               ),
                            //             ),
                            //             child: Text(
                            //               'More Details',
                            //               style: TextStyle(
                            //                 color: Colors.black,
                            //                 fontWeight: FontWeight.bold,
                            //               ),
                            //             ),
                            //           ),
                            //         ],
                            //       ),
                            //     ],
                            //   ),
                            // ),
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

class CollectionCard extends StatelessWidget {
  CollectionCard({
    super.key,
    this.backgroundColor,
    this.image,
    this.press,
    this.subTitle,
    this.title,this.buttonText,
  });
  Color? backgroundColor;
  Function()? press;
  String? image;
  String? title, subTitle,buttonText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
          color: backgroundColor, borderRadius: BorderRadius.circular(25)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            width: Get.width * .5,
            height: 170,
            image??'',
            // color: Colors.white,
            fit: BoxFit.contain,
          ),
          Expanded(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(20),
                Text(
                  title??"",
                  style: Get.textTheme.bodyLarge?.copyWith(
                    color: Colors.white,
                    // fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gap(8),

                Text(
                  subTitle??"",
                  style: Get.textTheme.bodySmall?.copyWith(
                    color: Colors.white,
                    // fontSize: 14,
                  ),
                ),
                // SizedBox(height: 12),
                Gap(8),
                TextButton(
                    onPressed:press?? () {},
                    style: ButtonStyle(
                        padding: WidgetStateProperty.all(
                            EdgeInsets.symmetric(horizontal: kSpacing)),
                        backgroundColor: WidgetStateProperty.all(Colors.white)),
                    child: Text(
                      buttonText??'',
                      style: Get.textTheme.bodyMedium?.copyWith(
                          color: Colors.black, fontWeight: FontWeight.w600),
                    )),
                Gap(20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
