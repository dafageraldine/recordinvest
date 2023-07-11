import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recordinvest/components/app_bar_with_back_button.dart';

class CalculateTarget extends StatelessWidget {
  // const CalculateTarget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: Column(
        children: [
          AppBarWithBackButton(
            titleBar: "Calculate Target",
            onTap: () {
              Get.back();
            },
          )
        ],
      )),
    );
  }
}
