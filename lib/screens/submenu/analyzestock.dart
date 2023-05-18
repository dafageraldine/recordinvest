import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:recordinvest/components/app_bar_with_back_button.dart';
import 'package:recordinvest/controller/stockanalysiscontroller.dart';

import '../../models/data.dart';

class AnalyzeStock extends StatelessWidget {
  StockAnalysisController _stockAnalysisController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        AppBarWithBackButton(
            titleBar: "Analyze Stock",
            onTap: () {
              Get.back();
            }),
        Padding(
          padding: EdgeInsets.only(top: 0.02.sh, left: 0.1.sw),
          child: Text(
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
                    _stockAnalysisController.selectedStockType.value = value!;
                    _stockAnalysisController.cbStockTypeAction();
                  },
                  selectedItem:
                      _stockAnalysisController.selectedStockType.value,
                )))),
        Padding(
          padding: EdgeInsets.only(top: 0.02.sh, left: 0.1.sw),
          child: Text(
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
                    _stockAnalysisController.selectedStockName.value = value!;
                    // _stockAnalysisController.cbStockTypeAction();
                  },
                  selectedItem:
                      _stockAnalysisController.selectedStockName.value,
                )))),
        Padding(
          padding: EdgeInsets.only(top: 0.02.sh, left: 0.1.sw),
          child: Text(
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
                Container(
                  width: 0.5.sw,
                  height: 0.07.sh,
                  child: TextFormField(
                      controller: _stockAnalysisController.values.value,
                      // obscureText: true,
                      decoration: InputDecoration(
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
                        saldoglobal.toString();
                  },
                  child: Container(
                    width: 0.3.sw,
                    height: 0.07.sh,
                    // color: Color.fromRGBO(217, 215, 241, 1),
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(249, 249, 249, 1),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 5.0,
                              color: Colors.black12,
                              spreadRadius: 2.0,
                              offset: Offset(0, 2))
                        ]),
                    child: Center(
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
          child: InkWell(
            onTap: () {
              _stockAnalysisController.analyzeStock();
            },
            child: Container(
              width: 0.85.sw,
              height: 0.07.sh,
              // color: Color.fromRGBO(217, 215, 241, 1),
              decoration: BoxDecoration(
                  color: Color.fromRGBO(249, 249, 249, 1),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 5.0,
                        color: Colors.black12,
                        spreadRadius: 2.0,
                        offset: Offset(0, 2))
                  ]),
              child: Center(
                child: Text(
                  "Analyze",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    // color: Color.fromRGBO(104, 103, 172, 1),
                    color: Color.fromRGBO(144, 200, 172, 1),
                    // color: Color.fromRGBO(246, 198, 234, 1),
                  ),
                ),
              ),
            ),
          ),
        )
      ]),
    );
  }
}
