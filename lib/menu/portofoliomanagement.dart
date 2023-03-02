import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:recordinvest/components/card_menu.dart';
import 'package:recordinvest/submenu/manageunperformportofolio.dart';
import 'package:recordinvest/submenu/performance.dart';

import '../components/app_bar_with_back_button.dart';

class PortofolioManagement extends StatelessWidget {
  const PortofolioManagement({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(children: [
        AppBarWithBackButton(
          titleBar: 'Portofolio Management',
          onTap: () {
            Navigator.pop(context);
          },
        ),
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Performance()));
                },
                image: "assets/financial-profit.png",
                title_card: "Performance"),
            CardMenu(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ManageUnperformPortofolio()));
                },
                image: "assets/accounting.png",
                title_card: "Manage Unperform Portofolio"),
          ],
        )
      ]),
      backgroundColor: Colors.white,
    );
  }
}
