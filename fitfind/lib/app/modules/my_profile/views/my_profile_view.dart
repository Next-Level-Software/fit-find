import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/my_profile_controller.dart';

class MyProfileView extends GetView<MyProfileController> {
  const MyProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyProfileView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'MyProfileView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
