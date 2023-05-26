import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:recordinvest/components/app_bar_with_button.dart';
import 'package:recordinvest/components/card_menu.dart';
import 'package:recordinvest/components/saldo_card.dart';
import 'package:recordinvest/controller/homecontroller.dart';
import 'package:recordinvest/screens/login/login.dart';
import 'package:recordinvest/screens/menu/addtype.dart';
import 'package:recordinvest/screens/menu/creditsimulation.dart';
import 'package:recordinvest/screens/menu/portofoliomanagement.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Homepage extends StatelessWidget {
  HomeController _homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async {
        _homeController.showAlertDialog();
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            AppBarWithButton(
              titleButton: "Log Out",
              titleBar: "My InvestMent Portofolio",
              onTap: () async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.remove('uname');
                await prefs.remove('pass');
                await prefs.remove('id');
                Get.to(Login());
              },
            ),
            SizedBox(
              height: 0.025 * height,
            ),
            Obx(() => SaldoCard(
                saldo: _homeController.oCcy
                    .format(_homeController.saldo.value)
                    .toString(),
                date: _homeController.date.value,
                percent: _homeController.percent.value,
                onTap: () {
                  _homeController.getSaldo();
                })),
            SizedBox(
              height: 0.025 * height,
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 0.1 * width),
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
              height: 0.025 * height,
            ),
            Row(
              children: [
                CardMenu(
                  onTap: () {
                    _homeController.getType();
                  },
                  image: "assets/edit.png",
                  title_card: "Create Record",
                ),
                CardMenu(
                  onTap: () {
                    Get.to(PortofolioManagement());
                  },
                  image: "assets/pie-chart (1).png",
                  title_card: "Portofolio Management",
                ),
              ],
            ),
            SizedBox(
              height: 0.025 * height,
            ),
            Row(
              children: [
                CardMenu(
                  onTap: () {
                    Get.to(AddType());
                  },
                  image: "assets/buy.png",
                  title_card: "Add Investment\nType",
                ),
                CardMenu(
                  onTap: () {
                    Get.to(CreditSimulation());
                  },
                  image: "assets/garage.png",
                  title_card: "credit\nsimulation",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
