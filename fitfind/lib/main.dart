import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'app/constants/app_constants.dart';
import 'app/config/theme/my_theme.dart';
import 'app/data/local/my_shared_pref.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // if (kDebugMode) {
  //   print("App is running in debug mode");
  // } else {

  //   print("App is not running in debug mode");
  //   await dotenv.load(fileName: '.env.prod');
  // }
  // await dotenv.load(fileName: '.env.dev');
  // await dotenv.load(fileName: '.env.prod');

  await MySharedPref.init();
  String? token = MySharedPref.getToken();
  if (token?.isNotEmpty ?? false) {
    // print(MySharedPref.getToken());
    // await BaseClient.safeApiCall(
    //   UserService.UPDATE_TOKEN,
    //   RequestType.get,
    //   onError: (e) {
    //     MySharedPref.removeToken();
    //   },
    //   onSuccess: (resp) {
    //     EmptyMsgModel response = emptyMsgModelFromJson(resp.data);
    //     if (token == null) {
    //       return;
    //     }
    //     MySharedPref.setToken(response.token ?? "");
    //   },
    // );
  }
  runApp(
    ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        useInheritedMediaQuery: true,
        rebuildFactor: (old, data) => true,
        builder: (context, widget) {
          return GetMaterialApp(
            title: appName,
            initialRoute: AppPages.INITIAL,
            debugShowCheckedModeBanner: false,
            getPages: AppPages.routes,
            theme: MyTheme.getThemeData(),
          );
          //
        }
        //  GetMaterialApp(
        //   title: "Yacht",
        //   initialRoute: AppPages.INITIAL,
        //   getPages: AppPages.routes,
        //   debugShowCheckedModeBanner: false,

        // ),
        ),
  );
}

