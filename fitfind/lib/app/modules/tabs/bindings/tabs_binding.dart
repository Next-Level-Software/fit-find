import 'package:fitfind/app/modules/deals/controllers/deals_controller.dart';
import 'package:fitfind/app/modules/home/controllers/home_controller.dart';
import 'package:fitfind/app/modules/locations/controllers/locations_controller.dart';
import 'package:fitfind/app/modules/my_profile/controllers/my_profile_controller.dart';
import 'package:get/get.dart';

import '../controllers/tabs_controller.dart';

class TabsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TabsController>(
      () => TabsController(),
    );
    Get.put(HomeController());
    Get.put(DealsController());
    Get.put(LocationsController());
    Get.put(MyProfileController());
  }
}
