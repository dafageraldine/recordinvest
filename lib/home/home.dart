import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:recordinvest/data.dart';
import 'package:http/http.dart' as http;
import 'package:recordinvest/menu/addtype.dart';
import 'package:recordinvest/menu/record.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  var date = "";
  var saldo = "";
  final oCcy = NumberFormat.currency(
      locale: 'eu',
      customPattern: '#,### \u00a4',
      symbol: 'IDR',
      decimalDigits: 2);

  Future getType() async {
    try {
      http.Response getdata = await http.get(Uri.parse(baseurl + "gettype"));
      var data = json.decode(getdata.body);
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
      http.Response getdata = await http.get(Uri.parse(baseurl + "getproduct"));
      var data = json.decode(getdata.body);
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
      http.Response getdata = await http.get(Uri.parse(baseurl + "getsaldo"));
      var data = json.decode(getdata.body);
      for (int i = 0; i < data["data"].length; i++) {
        saldo = oCcy.format(data["data"][i]["saldo"]).toString();
        date = data["data"][i]["date"];
      }
      setState(() {});
    } catch (e) {
      Fluttertoast.showToast(
          msg: "failed to fetch saldo " + e.toString(),
          backgroundColor: Colors.black,
          textColor: Colors.white);
    }
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            width: width,
            height: height * 0.1,
            // color: Color.fromRGBO(217, 215, 241, 1),
            color: Color.fromRGBO(144, 200, 172, 1),
            child: Padding(
              padding: EdgeInsets.only(left: 0.05 * width, top: 0.04 * height),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "My InvestMent Portofolio",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      // color: Color.fromRGBO(104, 103, 172, 1),
                      color: Color.fromRGBO(249, 249, 249, 1),
                      // color: Color.fromRGBO(246, 198, 234, 1),
                    ),
                  )),
            ),
          ),
          SizedBox(
            height: 0.025 * height,
          ),
          Container(
            width: 0.85 * width,
            height: 0.125 * height,
            decoration: BoxDecoration(
                // color: Color.fromRGBO(250, 244, 183, 1),
                color: Color.fromRGBO(157, 157, 157, 1),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 5.0,
                      color: Colors.black12,
                      spreadRadius: 5.0,
                      offset: Offset(0, 2))
                ]),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: InkWell(
                      onTap: () {
                        getSaldo();
                      },
                      child: Container(
                        width: width * 0.2,
                        height: 30,
                        decoration: BoxDecoration(
                            // color: Color.fromRGBO(250, 244, 183, 1),
                            color: Color.fromRGBO(144, 200, 172, 1),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 5.0,
                                  color: Colors.black12,
                                  spreadRadius: 5.0,
                                  offset: Offset(0, 2))
                            ]),
                        child: Center(
                            child: Text(
                          "Refresh",
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            // color: Color.fromRGBO(157, 157, 157, 1),
                            // color: Color.fromRGBO(144, 200, 172, 1),
                            color: Color.fromRGBO(249, 249, 249, 1),
                            fontSize: 12,
                          ),
                        )),
                      ),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: 0.02 * height, left: 0.1 * width),
                      child: Text(
                        "Saldo",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          // color: Color.fromRGBO(157, 157, 157, 1),
                          // color: Color.fromRGBO(144, 200, 172, 1),
                          color: Color.fromRGBO(249, 249, 249, 1),
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 0.1 * width),
                      child: Text(
                        saldo,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          // color: Color.fromRGBO(157, 157, 157, 1),
                          // color: Color.fromRGBO(144, 200, 172, 1),
                          color: Color.fromRGBO(249, 249, 249, 1),
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 0.01 * height, left: 0.1 * width),
                      child: Text(
                        date,
                        style: TextStyle(
                          // color: Color.fromRGBO(157, 157, 157, 1),
                          // color: Color.fromRGBO(144, 200, 172, 1),
                          color: Color.fromRGBO(249, 249, 249, 1),
                          fontWeight: FontWeight.w800,
                          fontSize: 12,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
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
              Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                      padding: EdgeInsets.only(left: 0.1 * width),
                      child: InkWell(
                        onTap: () {
                          comboboxtype.clear();
                          comboboxproduct.clear();
                          comboboxtype.add("pilih investment type");
                          comboboxproduct.add("pilih produk");
                          getType();
                        },
                        child: Container(
                          width: 0.35 * width,
                          height: 0.35 * width,
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(144, 200, 172, 1),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 5.0,
                                    color: Colors.black12,
                                    spreadRadius: 5.0,
                                    offset: Offset(0, 2))
                              ]),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 15,
                              ),
                              Image.asset(
                                "assets/edit.png",
                                width: 0.2 * width,
                                height: 0.2 * width,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Create Record",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  color: Color.fromRGBO(249, 249, 249, 1),
                                ),
                              )
                            ],
                          ),
                        ),
                      ))),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                      padding: EdgeInsets.only(left: 0.1 * width),
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          width: 0.35 * width,
                          height: 0.35 * width,
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(144, 200, 172, 1),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 5.0,
                                    color: Colors.black12,
                                    spreadRadius: 5.0,
                                    offset: Offset(0, 2))
                              ]),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Image.asset(
                                "assets/financial-profit.png",
                                width: 0.2 * width,
                                height: 0.2 * width,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Performance",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 14,
                                  color: Color.fromRGBO(249, 249, 249, 1),
                                ),
                              )
                            ],
                          ),
                        ),
                      )))
            ],
          ),
          SizedBox(
            height: 0.025 * height,
          ),
          Row(
            children: [
              Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                      padding: EdgeInsets.only(left: 0.1 * width),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddType()));
                        },
                        child: Container(
                          width: 0.35 * width,
                          height: 0.35 * width,
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(144, 200, 172, 1),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 5.0,
                                    color: Colors.black12,
                                    spreadRadius: 5.0,
                                    offset: Offset(0, 2))
                              ]),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 15,
                              ),
                              Image.asset(
                                "assets/buy.png",
                                width: 0.2 * width,
                                height: 0.2 * width,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Add Investment\nType",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  color: Color.fromRGBO(249, 249, 249, 1),
                                ),
                              )
                            ],
                          ),
                        ),
                      ))),
            ],
          ),
        ],
      ),
    );
  }
}
