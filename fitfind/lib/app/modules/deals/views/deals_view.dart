import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/deals_controller.dart';

class DealsView extends GetView<DealsController> {
  const DealsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DealsView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'DealsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
