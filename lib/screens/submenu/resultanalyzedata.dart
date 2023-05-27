import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:recordinvest/components/app_bar_with_back_button.dart';

import '../../controller/stockanalysiscontroller.dart';

class ResultAnalyzeData extends StatelessWidget {
  final StockAnalysisController _stockAnalysisController = Get.find();

  ResultAnalyzeData({super.key});

  @override
  Widget build(BuildContext context) {
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
            Obx(() => _stockAnalysisController.isLoading.value
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
                          "estimated money invested : \nRp ${_stockAnalysisController.oCcy.format(double.parse(_stockAnalysisController.values.value.text))}",
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
                          "stock selected : \n${_stockAnalysisController.selectedStockName.value}",
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
                                        _stockAnalysisController.analyzeDetail(
                                            _stockAnalysisController
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
                                                _stockAnalysisController
                                                    .analyzedata[i].maCompared,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w800,
                                                  color: Colors.grey.shade800,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              2.verticalSpace,
                                              Text(
                                                "probability : ${_stockAnalysisController.analyzedata[i].probability.toStringAsFixed(2)} %",
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
                                                    "lost : ${_stockAnalysisController.analyzedata[i].lost}",
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      color: Colors.red,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  10.horizontalSpace,
                                                  Text(
                                                    "profit : ${_stockAnalysisController.analyzedata[i].profit}",
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
                                                "Biggest lost : ${_stockAnalysisController.analyzedata[i].biggestLost.toStringAsFixed(2)} %",
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w800,
                                                  color: Colors.red,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              10.horizontalSpace,
                                              Text(
                                                "Biggest profit : ${_stockAnalysisController.analyzedata[i].biggestProfit.toStringAsFixed(2)} %",
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w800,
                                                  color: Colors.lightBlue,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              2.verticalSpace,
                                              Text(
                                                "estimated return : ${_stockAnalysisController.analyzedata[i].estimatedReturn.toStringAsFixed(2)} %",
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w800,
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              5.verticalSpace,
                                              Text(
                                                "Rp ${_stockAnalysisController.analyzedata[i].estimatedReturnInMoney}",
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
                            itemCount:
                                _stockAnalysisController.analyzedata.length,
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
