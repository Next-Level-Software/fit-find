import 'package:fitfind/app/widgets/custom_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';

import '../../../components/custom_bottombar.dart';
import '../../../constants/app_constants.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/custom_buttons.dart';
import '../controllers/gender_controller.dart';

class GenderView extends GetView<GenderController> {
  const GenderView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<GenderController>(builder: (_) {
      return Scaffold(
        // appBar: AppBar(
        //   title: const Text('GenderView'),
        //   centerTitle: true,
        // ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: kPadding),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: Get.width * 0.3,
                ),
                //  Gap(20),
                Align(
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    ImagePaths.LOGO,
                    width: 128,
                    height: 51,
                  ),
                ),
                Gap(20),
                Text(
                  'Select your Gender',
                  style: Get.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    // fontFamily: 'a Autobus Omnibus',
                  ),
                  textAlign: TextAlign.center,
                ),
                Gap(20),
                ListView.separated(
                  shrinkWrap: true,
                  itemCount: controller.genderList.length,
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (BuildContext context, int index) {
                    return const Gap(20);
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      // elevation: 2, // Adds a shadow effect (optional)
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ), // Rounded corners
                      // color: Color(0xFFE7F7EF),
                      child: CheckboxListTile(
                        // til
                        // checkColor: Get.theme.primaryColor,
                        // side: BorderSide(
                        //   color: (controller.setIndex == index)
                        //       ? Color(0xFFE7F7EF)
                        //       : Colors
                        //           .transparent, // Active -> Green, Inactive -> Transparent
                        //   width: 2,
                        // ),
                        // fillColor: WidgetStateProperty.all(Colors.transparent),
                        value: (controller.setIndex == index) ? true : false,
                        tileColor: Color(0xFFE7F7EF),
                        // side: BorderSide(),

                        contentPadding: EdgeInsets.all(kPadding),
                        // overlayColor: WidgetStateProperty.all(Colors.black),
                        onChanged: (value) {
                          controller.isCheck = value!;
                          controller.setIndex = index;
                          controller.update();
                        },
                        secondary: SizedBox(
                          height: 75, // Ensure enough space for overflow
                          width: 75,
                          child: Stack(
                            clipBehavior:
                                Clip.none, // Allows the image to overflow
                            alignment: Alignment.center,
                            children: [
                              // Circular background container
                              Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              // Image positioned to pop out from the top while staying inside at the bottom
                              Positioned(
                                top: -15, // Moves image up
                                bottom:
                                    5, // Ensures the bottom part stays inside
                                child: Image.asset(
                                  controller.genderList[index]['image'],
                                  height:
                                      75, // Make image bigger than the container
                                  width: 75,
                                  fit: BoxFit.cover, // Ensures proper coverage
                                ),
                              ),
                            ],
                          ),
                        ),

                        //  SizedBox(

                        //   height: 60,
                        //   width: 60,
                        //   child: CircleAvatar(
                        //     backgroundColor: Colors.white,
                        //     child: Image.asset(controller.genderList[index]['image']),
                        //   )
                        // ),
                        checkboxShape: CircleBorder(),
                        title: Text(
                          (controller.genderList[index]['gender']),
                          style: Get.textTheme.bodyLarge
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
         bottomNavigationBar: customBottomBar(
              widget: CustomButton(
                text: 'Select',
                onPress: () {
                  Get.toNamed(Routes.TABS);
                  
                },
              ),
              isBorder: false)
      );
    });
  }
}
