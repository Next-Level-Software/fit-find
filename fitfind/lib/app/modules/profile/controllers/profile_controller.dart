import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
GlobalKey<FormState> profileFormKey = GlobalKey<FormState>();

TextEditingController nameController=TextEditingController();
TextEditingController emailController=TextEditingController();
TextEditingController phoneController=TextEditingController();
TextEditingController passwordController=TextEditingController();




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
