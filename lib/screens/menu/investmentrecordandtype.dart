import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../components/app_bar_with_back_button.dart';
import '../../components/card_menu.dart';
import '../../controller/homecontroller.dart';
import '../submenu/addtype.dart';

class InvestmentRecordAndType extends StatelessWidget {
  InvestmentRecordAndType({super.key});
  final HomeController _homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppBarWithBackButton(
            titleBar: "Investment Record And Type",
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
                    _homeController.getType();
                  },
                  image: "assets/edit.png",
                  title_card: "Create Investment Record"),
              CardMenu(
                  onTap: () {
                    Get.to(const AddType());
                  },
                  image: "assets/buy.png",
                  title_card: "Add Investment Type"),
            ],
          ),
        ],
      ),
    );
  }
}
