import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();

  // final String userType = (MySharedPref.getIsCoach()) ? "coach" : "user";

  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  // SingleValueDropDownController genderValueController =
  //     SingleValueDropDownController();
  void onUserCheck() {
    // if (signUpFormKey.currentState?.validate() ?? false) {
    //   var data = {
    //     "phone": phoneNumberController.text,
    //     "name": userNameController.text,
    //     "email": emailController.text,
    //     "password": passwordController.text,
    //     "gender": genderValueController.dropDownValue?.value,
    //     "otp": "123456",
    //     "type": userType,
    //   };

    //   print(data);

    //   showLoadingOverLay(
    //     msg: "Getting info...",
    //     asyncFunction: () async {
    //       return await BaseClient.safeApiCall(
    //         UserService.checkUser,
    //         RequestType.post,
    //         data: data,
    //         onError: (e) {
    //           if (e.response?.data?["error"] == null) {
    //             String? errorMessage = e.response?.data?["message"];
    //             if (errorMessage?.isEmpty ?? false) return;

    //             CustomSnackBar.showCustomSnackBar(
    //               title: Strings.ERROR.tr,
    //               message: errorMessage ?? "",
    //               snackbarType: SnackbarType.danger,
    //             );
    //             return;
    //           }

    //           update();
    //         },
    //         onSuccess: (resp) {
    //           var response = emptyModelFromJson(resp.data);
    //           if (response.isSuccess == true) {
    //             //
    //             Get.toNamed(Routes.OTP, arguments: data);
    //           } else {
    //             CustomSnackBar.showCustomSnackBar(
    //               title: Strings.ERROR.tr,
    //               message: response.message ?? "Something went wrong",
    //               snackbarType: SnackbarType.danger,
    //             );
    //           }
    //         },
    //       );
    //     },
    //   );
    // }
  }
}
