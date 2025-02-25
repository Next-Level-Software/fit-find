import 'package:get/get.dart';
enum PageState {
  numberVerification,
  otpVerification,
  passwordRest,
}
class ForgetPasswordController extends GetxController {
  var segmentState;

  final count = 0.obs;
  @override
  void onInit() {
    segmentState = PageState.numberVerification;

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
