import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:recordinvest/components/card_menu.dart';
import 'package:recordinvest/screens/submenu/manageunperformportofolio.dart';
import 'package:recordinvest/screens/submenu/performance.dart';
import '../../../components/app_bar_with_back_button.dart';
import '../../controller/stockanalysiscontroller.dart';
import '../submenu/analyzestock.dart';

class PortofolioManagement extends StatelessWidget {
  StockAnalysisController _stockAnalysisController =
      Get.put(StockAnalysisController());

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));
    return Scaffold(
      body: Column(children: [
        AppBarWithBackButton(
          titleBar: 'Portofolio Management',
          onTap: () {
            Get.back();
          },
        ),
        SizedBox(
          height: 0.025.sh,
        ),
        Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 0.1.sw),
              child: Text(
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
                onTap: () {
                  Get.to(Performance());
                },
                image: "assets/financial-profit.png",
                title_card: "Performance"),
            CardMenu(
                onTap: () {
                  Get.to(ManageUnperformPortofolio());
                },
                image: "assets/accounting.png",
                title_card: "Manage Unperform Portofolio"),
          ],
        ),
        0.03.sh.verticalSpace,
        Row(
          children: [
            CardMenu(
                onTap: () async {
                  await _stockAnalysisController.cbStockTypeAction();
                  Get.to(AnalyzeStock());
                },
                image: "assets/robot.png",
                title_card: "Analyze stock"),
            // CardMenu(
            //     onTap: () {
            //       Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //               builder: (context) => ManageUnperformPortofolio()));
            //     },
            //     image: "assets/accounting.png",
            //     title_card: "Manage Unperform Portofolio"),
            Container()
          ],
        )
      ]),
      backgroundColor: Colors.white,
    );
  }
}
