import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:recordinvest/components/app_bar_with_back_button.dart';
import 'package:recordinvest/components/card_menu.dart';
import 'package:recordinvest/screens/submenu/carcreditsimulation.dart';

class CreditSimulation extends StatelessWidget {
  const CreditSimulation({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(children: [
        AppBarWithBackButton(
            titleBar: "Credit Simulation",
            onTap: () {
              Navigator.pop(context);
            }),
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
                  Get.to(CarCreditSimulation());
                },
                image: "assets/car.png",
                title_card: "Car Credit\nSimulation"),
            CardMenu(
                onTap: () {},
                image: "assets/house1.png",
                title_card: "House Credit Simulation"),
          ],
        ),
      ]),
    );
  }
}
