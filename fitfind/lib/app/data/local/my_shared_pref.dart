import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../config/translations/localization_service.dart';
import '/app/routes/app_pages.dart';


class MySharedPref {
  // get storage
  static late final GetStorage _storage;

  // STORING KEYS
  static const String _tokenKey = '_token';
  static const String _currentLocalKey = 'current_local';
  static const String _lightThemeKey = 'is_theme_light';
  static const String _isCoach = 'current_user_type';
  static const String _forgotTokenKey = 'forgot_token';
  static const String userKey = 'user_key';
  static const String demographicDetailKey = 'demographic_details_key';
  static const String coachDetailKey = 'coach_details_key';
  static const String subscriptionKey = 'user_subscription_key';
  static const String assistanceUserKey = 'user_subscription_key';

  /// init get storage services
  static init() async {
    await GetStorage.init();
    _storage = GetStorage();
  }

  /// set theme current type as light theme
  static void setThemeIsLight(bool lightTheme) =>
      _storage.write(_lightThemeKey, lightTheme);

  /// get if the current theme type is light
  static bool getThemeIsLight() =>
      _storage.read(_lightThemeKey) ??
      true; // todo set the default theme (true for light, false for dark)

  /// save current locale
  static void setCurrentLanguage(String languageCode) =>
      _storage.write(_currentLocalKey, languageCode);

  /// get current locale
  static Locale getCurrentLocal() {
    String? langCode = _storage.read(_currentLocalKey);
    // default language is english
    if (langCode == null) {
      return LocalizationService.defaultLanguage;
    }
    return LocalizationService.supportedLanguages[langCode]!;
  }

  static void clearSharePref() => _storage.erase();

  /// save generated  token
  static void setToken(String token) => _storage.write(_tokenKey, token);

  static void removeToken() => _storage.remove(_tokenKey);

  /// get generated  token
  static String? getToken() => _storage.read(_tokenKey);

  /// save generated  token
  static void setForgotToken(String token) =>
      _storage.write(_forgotTokenKey, token);

  static void removeForgotToken() => _storage.remove(_forgotTokenKey);

  /// get generated forgot token
  static String? getForgotToken() => _storage.read(_forgotTokenKey);

  ///================================================================
  /// Get is Coach
  ///================================================================

  /// set current user type
//   static void setIsCoach(bool isCoach) => _storage.write(_isCoach, isCoach);

//   static bool getIsCoach() => _storage.read(_isCoach) ?? false;
//   // demographic profile
//   static void setDemographicProfile(DemographicDetail demographicDetail) {
//     var value = demographicDetailToJson(demographicDetail);
//     _storage.write(demographicDetailKey, value);
//   }

//   static DemographicDetail? getDemographicProfile() {
//     var json = _storage.read(demographicDetailKey);
//     if (json == null) return null;

//     var demographicDetail = demographicDetailFromJson(json);
//     return demographicDetail;
//   }

//   static void delDemographicProfile() {
//     _storage.remove(demographicDetailKey);
//   }

//   static void setSubscriptionDetail(PackageSubscription? userSubscription) {
//     if (userSubscription == null) return;
//     var value = packageSubscriptionToJson(userSubscription);
//     _storage.write(subscriptionKey, value);
//   }

//   static PackageSubscription? getSubscriptionDetail() {
//     var json = _storage.read(subscriptionKey);
//     if (json == null) return null;

//     var userSubscription = packageSubscriptionFromJson(json);
//     return userSubscription;
//   }

//   static void delSubscriptionDetail() {
//     _storage.remove(subscriptionKey);
//   }
//   static void setAssistantDetail(AssistantUser? assistanceUser) {
//     if (assistanceUser == null) return;
//     var value = assistanceUserToJson(assistanceUser);
//     _storage.write(assistanceUserKey, value);
//   }

//   static AssistantUser? getAssistantDetail() {
//     var json = _storage.read(assistanceUserKey);
//     if (json == null) return null;

//     var assistanceUser = assistanceUserFromJson(json);
//     return assistanceUser;
//   }

//   static void delAssistantDetail() {
//     _storage.remove(assistanceUserKey);
//   }
// //coach details key
//   static void setCoachDetailProfile(CoachDetail coachDetail) {
//     var value = coachDetailToJson(coachDetail);
//     _storage.write(coachDetailKey, value);
//   }

//   static CoachDetail? getCoachDetailProfile() {
//     var json = _storage.read(coachDetailKey);
//     if (json == null) return null;
//     var coachDetail = coachDetailFromJson(json);
//     return coachDetail;
//   }

//   static void delCoachDetailProfile() {
//     _storage.remove(coachDetailKey);
//   }

//   static logoutUser() async {
//     showLoadingOverLay(
//         msg: "Logging Out",
//         asyncFunction: () async {
//           return await BaseClient.safeApiCall(
//               UserService.logoutUser, RequestType.get, onSuccess: (resp) {
//             MySharedPref.clearSharePref();
//             Get.offAllNamed(Routes.INTRO);
//           });
//         });
//   }
}
