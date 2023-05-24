import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:recordinvest/components/app_bar_with_back_button.dart';

import '../../controller/stockanalysiscontroller.dart';

class AnalyzeDetail extends StatelessWidget {
  StockAnalysisController _stockAnalysisController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: Column(
        children: [
          AppBarWithBackButton(
            titleBar: "Analyze Detail",
            onTap: () {
              Get.back();
            },
          ),
          Column(
            children: [
              ListView.builder(
                itemBuilder: (c, i) {
                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: InkWell(
                          onTap: () {
                            // _stockAnalysisController.analyzeDetail(
                            //     _stockAnalysisController
                            //         .analyzedata[i].maCompared);
                          },
                          child: Container(
                            width: 0.85.sw,
                            height: 0.15.sh,
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(144, 200, 172, 1),
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: EdgeInsets.only(left: 0.1.sw, top: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "action : " +
                                        _stockAnalysisController
                                            .analyzedatadetail[i].action
                                            .toString(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      // color: Color.fromRGBO(157, 157, 157, 1),
                                      // color: Color.fromRGBO(144, 200, 172, 1),
                                      color: _stockAnalysisController
                                                  .analyzedatadetail[i].action
                                                  .toString() ==
                                              "Sell"
                                          ? Colors.red
                                          : Colors.lightBlue,
                                      fontSize: 16,
                                    ),
                                  ),
                                  2.verticalSpace,
                                  Text(
                                    _stockAnalysisController
                                        .analyzedatadetail[i].date
                                        .toString(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      // color: Color.fromRGBO(157, 157, 157, 1),
                                      // color: Color.fromRGBO(144, 200, 172, 1),
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                  ),
                                  5.verticalSpace,
                                  Text(
                                    "price : " +
                                        _stockAnalysisController.oCcy.format(
                                            _stockAnalysisController
                                                .analyzedatadetail[i].close),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      // color: Color.fromRGBO(157, 157, 157, 1),
                                      // color: Color.fromRGBO(144, 200, 172, 1),
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
                physics: BouncingScrollPhysics(),
                itemCount: _stockAnalysisController.analyzedatadetail.length,
              ),
              20.verticalSpace
            ],
          ),
        ],
      )),
    );
  }
}