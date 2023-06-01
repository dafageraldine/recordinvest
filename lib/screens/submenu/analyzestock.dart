import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:recordinvest/components/app_bar_with_back_button.dart';
import 'package:recordinvest/controller/homecontroller.dart';
import 'package:recordinvest/controller/stockanalysiscontroller.dart';

import '../../components/processbutton.dart';

class AnalyzeStock extends StatelessWidget {
  final StockAnalysisController _stockAnalysisController = Get.find();
  final HomeController _homeController = Get.find();

  AnalyzeStock({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        AppBarWithBackButton(
            titleBar: "Analyze Stock",
            onTap: () {
              Get.back();
            }),
        Obx(() => _stockAnalysisController.isLoading.value
            ? Padding(
                padding: EdgeInsets.only(top: 0.1.sh),
                child: Lottie.asset('assets/loading.json'),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 0.02.sh, left: 0.1.sw),
                    child: const Text(
                      "Stock Type",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color.fromRGBO(157, 157, 157, 1),
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 0.02.sh, left: 0.1.sw),
                      child: Obx(() => Container(
                          width: 0.85.sw,
                          height: 0.07.sh,
                          decoration: BoxDecoration(
                            // color: Colors.grey[600],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: DropdownSearch<String>(
                            popupProps: PopupProps.menu(
                              itemBuilder: (context, item, isSelected) =>
                                  ListTile(title: Text(item)),
                              showSearchBox: true,
                            ),
                            items: _stockAnalysisController.combStockType,
                            dropdownBuilder: (context, item) => Text(item!),
                            onChanged: (value) {
                              _stockAnalysisController.selectedStockType.value =
                                  value!;
                              _stockAnalysisController.cbStockTypeAction();
                            },
                            selectedItem: _stockAnalysisController
                                .selectedStockType.value,
                          )))),
                  Padding(
                    padding: EdgeInsets.only(top: 0.02.sh, left: 0.1.sw),
                    child: const Text(
                      "Stock Name",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color.fromRGBO(157, 157, 157, 1),
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 0.02.sh, left: 0.1.sw),
                      child: Obx(() => Container(
                          width: 0.85.sw,
                          height: 0.07.sh,
                          decoration: BoxDecoration(
                            // color: Colors.grey[600],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: DropdownSearch<String>(
                            popupProps: PopupProps.menu(
                              itemBuilder: (context, item, isSelected) =>
                                  ListTile(title: Text(item)),
                              showSearchBox: true,
                            ),
                            items: _stockAnalysisController.combStockName,
                            dropdownBuilder: (context, item) => Text(item!),
                            onChanged: (value) {
                              _stockAnalysisController.selectedStockName.value =
                                  value!;
                              // _stockAnalysisController.cbStockTypeAction();
                            },
                            selectedItem: _stockAnalysisController
                                .selectedStockName.value,
                          )))),
                  Padding(
                    padding: EdgeInsets.only(top: 0.02.sh, left: 0.1.sw),
                    child: const Text(
                      "Estimated money invested",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color.fromRGBO(157, 157, 157, 1),
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 0.02.sh, left: 0.05.sw),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: 0.5.sw,
                            height: 0.07.sh,
                            child: TextFormField(
                                controller:
                                    _stockAnalysisController.values.value,
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
                          InkWell(
                            onTap: () {
                              _stockAnalysisController.values.value.text =
                                  _homeController.saldo.value.toString();
                            },
                            child: Container(
                              width: 0.3.sw,
                              height: 0.07.sh,
                              // color: Color.fromRGBO(217, 215, 241, 1),
                              decoration: BoxDecoration(
                                  color: const Color.fromRGBO(249, 249, 249, 1),
                                  borderRadius: BorderRadius.circular(10),
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
                                    color: Color.fromRGBO(144, 200, 172, 1),
                                    // color: Color.fromRGBO(246, 198, 234, 1),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                  Padding(
                    padding: EdgeInsets.only(top: 0.04.sh, left: 0.1.sw),
                    child: ProcessButton(
                      title: 'Analyze',
                      onTap: () {
                        _stockAnalysisController.analyzeStock();
                      },
                    ),
                  )
                ],
              ))
      ]),
    );
  }
}
