import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:recordinvest/components/app_bar_with_back_button.dart';
import 'package:recordinvest/controller/homecontroller.dart';

class ResultAnalyzeData extends StatelessWidget {
  final HomeController _homeController = Get.find();

  ResultAnalyzeData({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppBarWithBackButton(
                titleBar: "result analyze data",
                onTap: () {
                  Get.back();
                }),
            Obx(() => _homeController.isLoading.value
                ? Padding(
                    padding: EdgeInsets.only(top: 0.1.sh),
                    child: Lottie.asset('assets/loading.json'),
                  )
                : Column(
                    children: [
                      5.verticalSpace,
                      SizedBox(
                        width: 0.8.sw,
                        child: Text(
                          "estimated money invested : \nRp ${_homeController.oCcy.format(double.parse(_homeController.valuesStock.value.text.replaceAll(",", "")))}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            color: Colors.grey.shade800,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      2.verticalSpace,
                      SizedBox(
                        width: 0.8.sw,
                        child: Text(
                          "stock selected : \n${_homeController.selectedStockName.value}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            color: Colors.grey.shade800,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          ListView.builder(
                            itemBuilder: (c, i) {
                              return Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: InkWell(
                                      onTap: () {
                                        _homeController.analyzeDetail(
                                            _homeController
                                                .analyzedata[i].maCompared);
                                      },
                                      child: Container(
                                        width: 0.85.sw,
                                        height: 0.25.sh,
                                        decoration: BoxDecoration(
                                            color: const Color.fromRGBO(
                                                144, 200, 172, 1),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              left: 0.1.sw, top: 20),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                _homeController
                                                    .analyzedata[i].maCompared,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w800,
                                                  color: Colors.grey.shade800,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              2.verticalSpace,
                                              Text(
                                                "probability : ${_homeController.analyzedata[i].probability.toStringAsFixed(2)} %",
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w800,
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              2.verticalSpace,
                                              Row(
                                                children: [
                                                  Text(
                                                    "lost : ${_homeController.analyzedata[i].lost}",
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      color: Colors.red,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  10.horizontalSpace,
                                                  Text(
                                                    "profit : ${_homeController.analyzedata[i].profit}",
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      color: Colors.lightBlue,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              2.verticalSpace,
                                              Text(
                                                "Biggest lost : ${_homeController.analyzedata[i].biggestLost.toStringAsFixed(2)} %",
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w800,
                                                  color: Colors.red,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              10.horizontalSpace,
                                              Text(
                                                "Biggest profit : ${_homeController.analyzedata[i].biggestProfit.toStringAsFixed(2)} %",
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w800,
                                                  color: Colors.lightBlue,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              2.verticalSpace,
                                              Text(
                                                "estimated return : ${_homeController.analyzedata[i].estimatedReturn.toStringAsFixed(2)} %",
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w800,
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              5.verticalSpace,
                                              Text(
                                                "Rp ${_homeController.analyzedata[i].estimatedReturnInMoney}",
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w800,
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemCount: _homeController.analyzedata.length,
                          ),
                          20.verticalSpace
                        ],
                      ),
                    ],
                  ))
          ],
        ),
      ),
    );
  }
}
