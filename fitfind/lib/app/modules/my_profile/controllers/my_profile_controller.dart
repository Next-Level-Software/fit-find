import 'package:fitfind/app/constants/app_constants.dart';
import 'package:get/get.dart';

class MyProfileController extends GetxController {
  List menuItems =  [
          {
            "title": "My Profile",
            "iconPath": ImagePaths.PROFILE_EDIT,
            // 'icon': 
          },
          {
            "title": "Subscriptions",
            "iconPath": ImagePaths.SUBSCRIPTIONS
          },
          {
            "title": "Order History",
            "iconPath": ImagePaths.ORDER,
          },
          {
            "title": "Languages",
            "iconPath":ImagePaths.LANGUAGE,
          },
          {
            "title": "Favorites",
            "iconPath": ImagePaths.FAVORITES
          },
          {"title": "Password", "iconPath": ImagePaths.LOCK},
          {
            "title": "Contact Us",
            "iconPath": ImagePaths.CALL
          },
          // {
          //   "title": "Add new lesson",
          //   "iconPath": '',
          //   'icon': Icons.menu_book_outlined
          // },
          // {
          //   "title": "My Packages",
          //   "iconPath": '',
          //   'icon': Icons.subscriptions_outlined
          // },
          // {
          //   "title": "Language Settings",
          //   "iconPath": ImagePaths.LANGUAGE_SETTING
          // },
          // {"title": "Notifications", "iconPath": ImagePaths.NOTIFICATION_MENU},
        ];

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
