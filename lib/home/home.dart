import 'dart:convert';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:recordinvest/components/app_bar_with_button.dart';
import 'package:recordinvest/components/card_menu.dart';
import 'package:recordinvest/components/saldo_card.dart';
import 'package:recordinvest/data.dart';
import 'package:http/http.dart' as http;
import 'package:recordinvest/login.dart';
import 'package:recordinvest/menu/addtype.dart';
import 'package:recordinvest/menu/creditsimulation.dart';
import 'package:recordinvest/submenu/performance.dart';
import 'package:recordinvest/menu/portofoliomanagement.dart';
import 'package:recordinvest/menu/record.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  var date = "";
  var saldo = "";
  var percent = "";
  final oCcy = NumberFormat.currency(
      locale: 'eu',
      customPattern: '#,### \u00a4',
      symbol: "",
      decimalDigits: 2);

  Future getType() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? id = prefs.getString('id');
      var body = {"id": id};
      http.Response postdata =
          await http.post(Uri.parse(baseurl + "gettype"), body: body);
      var data = json.decode(postdata.body);
      for (int i = 0; i < data["data"].length; i++) {
        comboboxtype.add(data["data"][i]["type"]);
      }
      getProduct();
    } catch (e) {
      Fluttertoast.showToast(
          msg: e.toString(),
          backgroundColor: Colors.black,
          textColor: Colors.white);
    }
  }

  Future getProduct() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? id = prefs.getString('id');
      var body = {"id": id};
      http.Response postdata =
          await http.post(Uri.parse(baseurl + "getproduct"), body: body);
      var data = json.decode(postdata.body);
      for (int i = 0; i < data["data"].length; i++) {
        comboboxproduct.add(data["data"][i]["name"]);
      }
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Recordpage()));
    } catch (e) {
      Fluttertoast.showToast(
          msg: e.toString(),
          backgroundColor: Colors.black,
          textColor: Colors.white);
    }
  }

  Future getSaldo() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? id = prefs.getString('id');
      var body = {"id": id};
      http.Response postdata =
          await http.post(Uri.parse(baseurl + "getsaldo"), body: body);
      // http.Response getdata = await http.get(Uri.parse(baseurl + "getsaldo"));
      var data = json.decode(postdata.body);
      var databefore = 0.0;
      var datanow = 0.0;
      print("here");
      for (int i = 0; i < data["data"].length; i++) {
        saldo = oCcy.format(data["data"][i]["saldo"]).toString();
        saldoglobal = data["data"][i]["saldo"];
        date = data["data"][i]["date"];
        datanow = data["data"][i]["saldo"];
        databefore = data["data"][i]["saldobefore"];
      }
      var persen = 0.0;
      print(datanow.toString() + "  " + databefore.toString());
      if (databefore > 0) {
        persen = (datanow - databefore) / databefore * 100.0;
      }
      if (persen > 0) {
        percent = "+ " + persen.toStringAsFixed(2) + " % than previous data";
        print(percent);
      } else if (persen < 0) {
        percent = persen.toStringAsFixed(2) + " % than previous data";
        print(percent);
      }

      setState(() {});
    } catch (e) {
      Fluttertoast.showToast(
          msg: "failed to fetch saldo " + e.toString(),
          backgroundColor: Colors.black,
          textColor: Colors.white);
    }
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text(
        "No",
        style: TextStyle(color: Colors.grey),
      ),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text(
        "yes",
        style: TextStyle(
          color: Color.fromRGBO(144, 200, 172, 1),
        ),
      ),
      onPressed: () async {
        exit(0);
        // await delete();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Warning"),
      content: Text("Do you want exit ?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  void initState() {
    getSaldo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async {
        showAlertDialog(context);
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
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Login()));
              },
            ),
            SizedBox(
              height: 0.025 * height,
            ),
            SaldoCard(
                saldo: saldo,
                date: date,
                percent: percent,
                onTap: () {
                  getSaldo();
                }),
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
                    comboboxtype.clear();
                    comboboxproduct.clear();
                    comboboxtype.add("pilih investment type");
                    comboboxproduct.add("pilih produk");
                    getType();
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
