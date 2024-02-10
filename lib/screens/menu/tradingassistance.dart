import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:recordinvest/screens/submenu/tradingmonitor.dart';

import '../../components/app_bar_with_back_button.dart';
import '../../components/card_menu.dart';
import '../../controller/homecontroller.dart';
import '../../controller/stockanalysiscontroller.dart';
import '../submenu/analyzestock.dart';

class TradingAssistance extends StatelessWidget {
  TradingAssistance({super.key});
  final StockAnalysisController _stockAnalysisController =
      Get.put(StockAnalysisController());
  final HomeController _homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppBarWithBackButton(
            titleBar: "Trading Assistance",
            onTap: () {
              Get.back();
            },
          ),
          SizedBox(
            height: 0.025.sh,
          ),
          Obx(
            () => _stockAnalysisController.isLoading.value
                ? Padding(
                    padding: EdgeInsets.only(top: 0.1.sh),
                    child: Lottie.asset('assets/loading.json'),
                  )
                : Column(
                    children: [
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 0.1.sw),
                            child: const Text(
                              "Menu",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Color.fromRGBO(157, 157, 157, 1),
                                fontSize: 16,
                              ),
                            ),
                          )),
                      SizedBox(
                        height: 0.025.sh,
                      ),
                      Row(
                        children: [
                          CardMenu(
                              onTap: () async {
                                await _stockAnalysisController
                                    .cbStockTypeAction();
                                Get.to(AnalyzeStock());
                              },
                              image: "assets/robot.png",
                              title_card: "Analyze Stock"),
                          CardMenu(
                              onTap: () async {
                                await _homeController.getWlList();
                                Get.to(TradingMonitor());
                              },
                              image: "assets/stock.png",
                              title_card: "Trading Monitor"),
                        ],
                      ),
                    ],
                  ),
          )
        ],
      ),
    );
  }
}
