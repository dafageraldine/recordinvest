import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:recordinvest/components/app_bar_with_button.dart';
import 'package:recordinvest/components/card_menu.dart';
import 'package:recordinvest/components/saldo_card.dart';
import 'package:recordinvest/models/data.dart';
import 'package:http/http.dart' as http;
import 'package:recordinvest/screens/login/login.dart';
import 'package:recordinvest/screens/menu/addtype.dart';
import 'package:recordinvest/screens/menu/creditsimulation.dart';
import 'package:recordinvest/screens/menu/portofoliomanagement.dart';
import 'package:recordinvest/screens/menu/record.dart';
import 'package:recordinvest/viewmodels/home/homeviewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    Provider.of<HomeViewModel>(context, listen: false).getSaldo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async {
        Provider.of<HomeViewModel>(context, listen: false)
            .showAlertDialog(context);
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
            Consumer<HomeViewModel>(
                builder: ((context, value, child) => SaldoCard(
                    saldo: value.saldo,
                    date: value.date,
                    percent: value.percent,
                    onTap: () {
                      value.getSaldo();
                    }))),
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
                    Provider.of<HomeViewModel>(context, listen: false)
                        .getType(context);
                  },
                  image: "assets/edit.png",
                  title_card: "Create Record",
                ),
                CardMenu(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PortofolioManagement()));
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AddType()));
                  },
                  image: "assets/buy.png",
                  title_card: "Add Investment\nType",
                ),
                CardMenu(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreditSimulation()));
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
