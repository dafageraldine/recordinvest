import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:recordinvest/components/app_bar_with_notif.dart';
import 'package:recordinvest/components/card_menu.dart';
import 'package:recordinvest/components/saldo_card.dart';
import 'package:recordinvest/controller/homecontroller.dart';
import 'package:recordinvest/screens/menu/tradingassistance.dart';
import 'package:recordinvest/screens/submenu/addtype.dart';
import 'package:recordinvest/screens/menu/creditsimulation.dart';
import 'package:recordinvest/screens/menu/investmentrecordandtype.dart';
import 'package:recordinvest/screens/menu/portofoliomanagement.dart';
import 'package:recordinvest/screens/submenu/notificationpage.dart';

class Homepage extends StatelessWidget {
  final HomeController _homeController = Get.find();

  Homepage({super.key});
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Obx(() => AppBarWithNotif(
              titleBar: 'My InvestMent Portofolio',
              showNNotif: true,
              notifcount: _homeController.listNotif.length.toString(),
              onTap: () async {
                _homeController.fillNotif();
                Get.to(NotificationPage());
              })),
          SizedBox(
            height: 0.025.sh,
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
            height: 0.025.sh,
          ),
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
                onTap: () {
                  Get.to(InvestmentRecordAndType());
                },
                image: "assets/server.png",
                title_card: "Investment\nRecord And Type",
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
            height: 0.025.sh,
          ),
          Row(
            children: [
              CardMenu(
                onTap: () {
                  Get.to(TradingAssistance());
                },
                image: "assets/trading.png",
                title_card: "Trading \nAssistance",
              ),
              CardMenu(
                onTap: () {
                  Get.to(const CreditSimulation());
                },
                image: "assets/garage.png",
                title_card: "credit\nsimulation",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
