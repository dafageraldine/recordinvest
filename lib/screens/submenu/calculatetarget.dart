import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:recordinvest/components/app_bar_with_back_button.dart';
import 'package:recordinvest/components/processbutton.dart';

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
          ),
          Padding(
            padding: EdgeInsets.only(top: 0.02.sh, left: 0.1.sw),
            child: const Text(
              "Enter Target",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Color.fromRGBO(157, 157, 157, 1),
                fontSize: 16,
              ),
            ),
          ),
          SizedBox(
            width: 0.8.sw,
            height: 0.07.sh,
            child: TextFormField(
                // controller:
                // _stockAnalysisController.values.value,
                // obscureText: true,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(157, 157, 157, 0.5),
                      fontSize: 16,
                    ),
                    hintText: "15000000.00")),
          ),
          ProcessButton(title: "calculate")
        ],
      )),
    );
  }
}
