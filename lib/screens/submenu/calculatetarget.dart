import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:recordinvest/components/app_bar_with_back_button.dart';
import 'package:recordinvest/components/processbutton.dart';
import 'package:recordinvest/controller/calculatetargetcontroller.dart';

import '../../controller/homecontroller.dart';

class CalculateTarget extends StatelessWidget {
  CalculateTarget({super.key});

  final CalculateTargetController _calculateTargetController =
      Get.put(CalculateTargetController());
  final HomeController _homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: Obx(() => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppBarWithBackButton(
                    titleBar: "Calculate Target",
                    onTap: () {
                      Get.back();
                    },
                  ),
                  _calculateTargetController.isLoading.value
                      ? Padding(
                          padding: EdgeInsets.only(top: 0.1.sh),
                          child: Lottie.asset('assets/archer.json'),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsets.only(top: 0.02.sh, left: 0.1.sw),
                              child: const Text(
                                "Enter Target",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromRGBO(157, 157, 157, 1),
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.only(top: 0.02.sh, left: 0.1.sw),
                              child: SizedBox(
                                width: 0.8.sw,
                                height: 0.07.sh,
                                child: TextFormField(
                                    controller:
                                        _calculateTargetController.values.value,
                                    // obscureText: true,
                                    decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintStyle: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Color.fromRGBO(
                                              157, 157, 157, 0.5),
                                          fontSize: 16,
                                        ),
                                        hintText: "15000000.00")),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.only(top: 0.02.sh, left: 0.1.sw),
                              child: const Text(
                                "Start From",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromRGBO(157, 157, 157, 1),
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.only(
                                    top: 0.02.sh, left: 0.05.sw),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SizedBox(
                                      width: 0.5.sw,
                                      height: 0.07.sh,
                                      child: TextFormField(
                                          controller: _calculateTargetController
                                              .stfrom.value,
                                          // obscureText: true,
                                          decoration: const InputDecoration(
                                              border: OutlineInputBorder(),
                                              hintStyle: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                color: Color.fromRGBO(
                                                    157, 157, 157, 0.5),
                                                fontSize: 16,
                                              ),
                                              hintText: "15000000.00")),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        _calculateTargetController
                                                .stfrom.value.text =
                                            _homeController.saldo.value
                                                .toString();
                                      },
                                      child: Container(
                                        width: 0.3.sw,
                                        height: 0.07.sh,
                                        // color: Color.fromRGBO(217, 215, 241, 1),
                                        decoration: BoxDecoration(
                                            color: const Color.fromRGBO(
                                                249, 249, 249, 1),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            boxShadow: const [
                                              BoxShadow(
                                                  blurRadius: 5.0,
                                                  color: Colors.black12,
                                                  spreadRadius: 2.0,
                                                  offset: Offset(0, 2))
                                            ]),
                                        child: const Center(
                                          child: Text(
                                            "gunakan saldo\nsaat ini",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                              // color: Color.fromRGBO(104, 103, 172, 1),
                                              color: Color.fromRGBO(
                                                  144, 200, 172, 1),
                                              // color: Color.fromRGBO(246, 198, 234, 1),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                            Padding(
                              padding:
                                  EdgeInsets.only(top: 0.04.sh, left: 0.09.sw),
                              child: ProcessButton(
                                  title: "calculate",
                                  onTap: () {
                                    _calculateTargetController.getresult();
                                  }),
                            )
                          ],
                        )
                ],
              ))),
    );
  }
}
