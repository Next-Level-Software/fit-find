import 'package:fitfind/app/constants/app_constants.dart';
import 'package:fitfind/app/widgets/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../components/custom_network_image.dart';
import '../../../utils/spaces.dart';
import '../../../widgets/custom_buttons.dart';
import '../controllers/favorite_controller.dart';

class FavoriteView extends GetView<FavoriteController> {
  const FavoriteView({super.key});
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
                                onTap: () {
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
                    Row(
                      children: [
                        Expanded(
                          child: CustomInput(
                            hint: 'Search Clothes...',
                            icon: Icons.search,
                          ),
                        ),
                        Gap(20),
                        CustomIconButton(
                          isRounded: false,
                          iconData: HeroIcons.adjustments_horizontal,
                          color: Colors.black,
                        )
                      ],
                    ),
                    Gap(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomTextButton(
                          text: 'All Items',
                          onPress: () {},
                          svgIcon: SvgPicture.asset(ImagePaths.ALL_ITEMS),
                          iconPosition: IconPosition.leading,

                          background: Colors.white,
                          color: Get.theme.primaryColor,
                          // spaceBetween: kPadding,
                          horizontalSpace: 6,
                        ),
                        CustomTextButton(
                          text: 'Pants',
                          onPress: () {},
                          svgIcon: SvgPicture.asset(ImagePaths.T_SHIRT),
                          iconPosition: IconPosition.leading,

                          background: Colors.transparent,
                          color: Colors.white,
                          borderColor: Colors.white,
                          // spaceBetween: kPadding,
                          horizontalSpace: 6,
                        ),
                        CustomTextButton(
                          text: 'T-Shirt',
                          onPress: () {},
                          svgIcon: SvgPicture.asset(ImagePaths.T_SHIRT),
                          iconPosition: IconPosition.leading,

                          background: Colors.transparent,
                          color: Colors.white,
                          borderColor: Colors.white,
                          // spaceBetween: kPadding,
                          horizontalSpace: 6,
                        ),
                        CustomTextButton(
                          text: 'T-Shirt',
                          onPress: () {},
                          svgIcon: SvgPicture.asset(ImagePaths.T_SHIRT),
                          iconPosition: IconPosition.leading,

                          background: Colors.transparent,
                          color: Colors.white,
                          borderColor: Colors.white,
                          // spaceBetween: kPadding,
                          horizontalSpace: 6,
                        ),
                        // TextButton(
                        //   onPressed: () {},
                        //   style: ButtonStyle(
                        //       padding: WidgetStateProperty.all(
                        //           EdgeInsets.symmetric(horizontal: kSpacing)),
                        //       backgroundColor:
                        //           WidgetStateProperty.all(Colors.white)),
                        //   child: Text(
                        //     'All Items',
                        //     style: Get.textTheme.bodyMedium?.copyWith(
                        //         color: Get.theme.primaryColor,
                        //         fontWeight: FontWeight.w600),
                        //   ),
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
              Gap(10),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: Get.height,
                    // width: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      // borderRadius: BorderRadius.only(
                      //     topLeft: Radius.circular(20),
                      //     topRight: Radius.circular(20))
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
                            Gap(40),
                            GridView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: kSpacing,
                                crossAxisSpacing: kSpacing,
                                childAspectRatio: 2 / 2.5,
                              ),
                              itemCount: 6,
                              itemBuilder: (context, index) {
                                // final profile = user[index];
                                return Container(
                                  padding: const EdgeInsets.all(kSpacing),
                                  decoration: BoxDecoration(
                                    color: Get.theme.cardColor,
                                    borderRadius: BorderRadius.circular(0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.transparent,
                                        blurRadius: 0,
                                        // offset: Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Stack(
                                        children: [
                                          CustomNetworkImage(
                                            imagePath:
                                                'https://s3-alpha-sig.figma.com/img/01fa/c78c/66946560245a889b28ce2406b851436a?Expires=1741564800&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=d8ZjdziJ36rUzB~7EghPWsn2gu78tEzNwo8RhnwiOrVrRrBv9Yw-IBy4IrlE4oAOBMw9RtrnS-Z603wb1w0pqVUL9uoqVBrZFKwAnZJy2nIFjjMl8E05BVP3~aKlEGfd7tr8P2onvJ1ECM-R2sZtEAzIs-KyM3Ox~1jA6~kq4QjIQXn-jB4L~XEcCg1XfBxglKKMYfrxP5UC45rCpq2D8MyT817Frtc3KMIri9MmU1jFZLtbOe-wpHpPf3MaYq3UOYxbDANQrCaIGW72IGGyTVFx9XA7Gngaleo-09jP3-jTs04~VNbGwdtFZX8f07stxenFMgZUNKb9rnX46r1vCw__',
                                            height: 150,
                                            width: Get.width,
                                            boxFit: BoxFit.cover,
                                          ),
                                          Positioned(
                                            // left: 0,
                                            left: kSpacing,
                                            top: kSpacing,
                                            child:CustomLikeButton(
                                                  

                                                 ),
                                          ),
                                        ],
                                      ),
                                      Gap(10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Modern Light Clothes',
                                            style: Get.textTheme.labelSmall,
                                          ),
                                          Text(
                                            '\$212',
                                            style: Get.textTheme.labelSmall
                                                ?.copyWith(
                                                    fontWeight:
                                                        FontWeight.w900),
                                          )
                                        ],
                                      ),
                                      Gap(10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "T-Shirt",
                                            style: Get
                                                .theme.textTheme.labelSmall!
                                                .copyWith(
                                                    color: Colors.grey[600]),
                                          ),
                                          // Expanded(
                                          //   child: Row(
                                          //     children: specialties
                                          //         .map((speciality) => Container(
                                          //               decoration: BoxDecoration(
                                          //                 color: Colors.grey[200],
                                          //                 borderRadius:
                                          //                     BorderRadius.circular(
                                          //                         5),
                                          //               ),
                                          //               padding: EdgeInsets.all(4),
                                          //               margin: EdgeInsets.all(3),
                                          //               child: SvgPicture.network(
                                          //                 (FILE_BASE_URL +
                                          //                     (speciality.fileUrl ??
                                          //                         '')),
                                          //                 color: Get
                                          //                     .theme.primaryColor,
                                          //               ),
                                          //             ))
                                          //         .toList(),
                                          //   ),
                                          // ),
                                          // SpaceH8(),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(Icons.star,
                                                  color: Colors.amber,
                                                  size: 15),
                                              const SizedBox(width: 4),
                                              Text(
                                                '5.0',
                                                style: Get
                                                    .theme.textTheme.labelSmall!
                                                    .copyWith(
                                                        color:
                                                            Colors.grey[600]),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
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
