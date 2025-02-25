import 'package:fitfind/app/constants/app_constants.dart';
import 'package:fitfind/app/modules/deals/views/deals_view.dart';
import 'package:fitfind/app/modules/home/views/home_view.dart';
import 'package:fitfind/app/modules/locations/views/locations_view.dart';
import 'package:fitfind/app/modules/my_profile/views/my_profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

import '../controllers/tabs_controller.dart';

class TabsView extends GetView<TabsController> {
  const TabsView({super.key});
  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      tabs: [
        PersistentTabConfig(
          screen: HomeView(),
          item: ItemConfig(
            icon: SvgPicture.asset(ImagePaths.HOME),
            inactiveIcon: SvgPicture.asset(ImagePaths.HOME,color: Color(0xFF12131A),),
            activeColorSecondary: Get.theme.primaryColor,
            activeForegroundColor: Get.theme.primaryColor,
            title: "Home",
          ),
        ),
        PersistentTabConfig(
          screen: DealsView(),
          item: ItemConfig(
            icon: SvgPicture.asset(ImagePaths.DEALS,color: Get.theme.primaryColor,),
            inactiveIcon: SvgPicture.asset(ImagePaths.DEALS),
            activeColorSecondary: Get.theme.primaryColor,
            activeForegroundColor: Get.theme.primaryColor,
            title: "Deals",
          ),
        ),
        PersistentTabConfig(
          screen: LocationsView(),
          item: ItemConfig(
            icon: SvgPicture.asset(ImagePaths.LOCATION,color: Get.theme.primaryColor,),
            inactiveIcon: SvgPicture.asset(ImagePaths.LOCATION),
            activeColorSecondary: Get.theme.primaryColor,
            activeForegroundColor: Get.theme.primaryColor,
            // activeColorSecondary: ,
            title: "Locations",
          ),
        ),
        PersistentTabConfig(
          screen: MyProfileView(),
          item: ItemConfig(
            icon: SvgPicture.asset(ImagePaths.PROFILE,color: Get.theme.primaryColor,),
            inactiveIcon: SvgPicture.asset(ImagePaths.PROFILE),
            activeColorSecondary: Get.theme.primaryColor,
            activeForegroundColor: Get.theme.primaryColor,
            title: "My Profile",
          ),
        ),
      ],
      navBarBuilder: (navBarConfig) => Style4BottomNavBar(
        navBarConfig: navBarConfig,
        navBarDecoration: NavBarDecoration(
            // color: Get.theme.primaryColor

            ),
      ),
    );
  }
}
