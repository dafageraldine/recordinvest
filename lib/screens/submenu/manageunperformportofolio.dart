import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:recordinvest/models/comboboxdata.dart';
import 'package:recordinvest/screens/submenu/hasilsimulasiporto.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../components/app_bar_with_back_button.dart';
import '../../../models/data.dart';

class ManageUnperformPortofolio extends StatefulWidget {
  const ManageUnperformPortofolio({super.key});

  @override
  State<ManageUnperformPortofolio> createState() =>
      _ManageUnperformPortofolioState();
}

class _ManageUnperformPortofolioState extends State<ManageUnperformPortofolio> {
  TextEditingController floss = TextEditingController();
  TextEditingController kurs = TextEditingController();
  TextEditingController mi = TextEditingController();
  TextEditingController dl = TextEditingController();
  TextEditingController prn = TextEditingController();
  TextEditingController aih = TextEditingController();
  TextEditingController tais = TextEditingController();
  TextEditingController rsia = TextEditingController();
  var selectedpilihan;

  Future get_cb_data() async {
    try {
      list_cb_data.clear();
      combobox.clear();
      final prefs = await SharedPreferences.getInstance();
      final String? id = prefs.getString('id');
      var body = {"id": id};
      http.Response postdata =
          await http.post(Uri.parse(baseurl + "get_latest_asset"), body: body);
      print(postdata.body);
      var data = json.decode(postdata.body);
      for (int i = 0; i < data["data"].length; i++) {
        list_cb_data.add(ComboBoxData(data["data"][i]["date"],
            data["data"][i]["value"].toString(), data["data"][i]["product"]));
      }
      list_cb_data.sort(((a, b) => a.product.compareTo(b.product)));
      print("length : " + list_cb_data.length.toString());
      for (int i = 0; i < list_cb_data.length; i++) {
        combobox.add(list_cb_data[i].product);
      }
      selectedpilihan = list_cb_data[0].product;
      showcb();
    } catch (e) {
      Fluttertoast.showToast(
          msg: e.toString(),
          backgroundColor: Colors.black,
          textColor: Colors.white);
    }
  }

  void calculate() {
    var kurs_ = double.parse(kurs.text.toString());
    var floating_loss = double.parse(floss.text.toString());
    var uang_invest_awal = double.parse(mi.text.toString());
    var harga_saat_ini = double.parse(prn.text.toString());
    var unit_dimiliki = double.parse(aih.text.toString());
    var desired_loss = double.parse(dl.text.toString());
    var asset_switch_now = double.parse(tais.text.toString());
    var return_switch_percent = double.parse(rsia.text.toString());
    var floating_loss_in_percent =
        (floating_loss * kurs_ / (uang_invest_awal * kurs_)) * 100;
    var asset_akhir = (100 / desired_loss) * (kurs_ * floating_loss);
    var uang_harus_diinvest = asset_akhir - (uang_invest_awal * kurs_);
    var hargabep = (asset_akhir /
            (unit_dimiliki +
                (uang_harus_diinvest / (harga_saat_ini * kurs_)))) /
        kurs_;
    var up_percent = ((hargabep - harga_saat_ini) / harga_saat_ini) * 100;
    var return_perhari_switch_money =
        (asset_switch_now + (kurs_ * (uang_invest_awal - floating_loss))) *
            (return_switch_percent / 100);
    var estimated_day = (floating_loss * kurs_) / return_perhari_switch_money;
    var estimated_month = estimated_day / 30;
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HasilSimulasiPorto(
                uang_invest_awal * kurs_,
                floating_loss * kurs_,
                floating_loss_in_percent,
                desired_loss,
                asset_switch_now,
                return_switch_percent,
                uang_harus_diinvest,
                estimated_day,
                estimated_month,
                hargabep,
                up_percent,
                harga_saat_ini)));
  }

  void showcb() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        double width = MediaQuery.of(context).size.width;
        double height = MediaQuery.of(context).size.height;
        // return object of type Dialog
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Container(
            width: 0.85 * width,
            height: 0.3 * height,
            child: Column(
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(left: 0.1 * width, top: 0.05 * height),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Choose Asset",
                        style: TextStyle(
                            color: Color.fromRGBO(82, 82, 82, 1),
                            fontSize: 14,
                            // fontFamily: 'Inter',
                            fontWeight: FontWeight.w600),
                      )),
                ),
                SizedBox(height: 10),
                Container(
                    width: 0.7 * width,
                    height: 0.07 * height,
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
                      items: combobox,
                      dropdownBuilder: (context, item) => Text(item!),
                      onChanged: (value) => setState(() {
                        selectedpilihan = value!;
                      }),
                      selectedItem: selectedpilihan,
                    )),
                InkWell(
                  onTap: () {
                    for (var i = 0; i < list_cb_data.length; i++) {
                      if (selectedpilihan == list_cb_data[i].product) {
                        tais.text = list_cb_data[i].value;
                        break;
                      }
                    }
                    Navigator.of(context).pop();
                    setState(() {});
                  },
                  child: Container(
                    width: 0.7 * width,
                    height: 0.07 * height,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(144, 200, 172, 1),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                        child: Text(
                      "Select",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    )),
                  ),
                ),
                SizedBox(
                  height: 15,
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          AppBarWithBackButton(
              titleBar: "Manage Unperform Portofolio",
              onTap: () {
                Navigator.pop(context);
              }),
          SizedBox(
            height: 0.025 * height,
          ),
          Padding(
            padding: EdgeInsets.only(top: 0.02 * height, left: 0.1 * width),
            child: Text(
              "Floating loss(money)",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Color.fromRGBO(157, 157, 157, 1),
                fontSize: 16,
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(top: 0.02 * height, left: 0.1 * width),
              child: Container(
                width: 0.85 * width,
                height: 0.07 * height,
                child: TextFormField(
                    controller: floss,
                    // obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(157, 157, 157, 0.5),
                          fontSize: 16,
                        ),
                        hintText: "15.8")),
              )),
          Padding(
            padding: EdgeInsets.only(top: 0.02 * height, left: 0.1 * width),
            child: Text(
              "Kurs",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Color.fromRGBO(157, 157, 157, 1),
                fontSize: 16,
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(top: 0.02 * height, left: 0.1 * width),
              child: Row(
                children: [
                  Container(
                    width: 0.85 * width,
                    height: 0.07 * height,
                    child: TextFormField(
                        controller: kurs,
                        // obscureText: true,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Color.fromRGBO(157, 157, 157, 0.5),
                              fontSize: 16,
                            ),
                            hintText: "15500")),
                  ),
                ],
              )),
          Padding(
            padding: EdgeInsets.only(top: 0.02 * height, left: 0.1 * width),
            child: Text(
              "Money Invested",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Color.fromRGBO(157, 157, 157, 1),
                fontSize: 16,
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(top: 0.02 * height, left: 0.1 * width),
              child: Container(
                width: 0.85 * width,
                height: 0.07 * height,
                child: TextFormField(
                    controller: mi,
                    // obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(157, 157, 157, 0.5),
                          fontSize: 16,
                        ),
                        hintText: "100")),
              )),
          Padding(
            padding: EdgeInsets.only(top: 0.02 * height, left: 0.1 * width),
            child: Text(
              "Desired loss in (%)",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Color.fromRGBO(157, 157, 157, 1),
                fontSize: 16,
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(top: 0.02 * height, left: 0.1 * width),
              child: Container(
                width: 0.85 * width,
                height: 0.07 * height,
                child: TextFormField(
                    controller: dl,
                    // obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(157, 157, 157, 0.5),
                          fontSize: 16,
                        ),
                        hintText: "5")),
              )),
          Padding(
            padding: EdgeInsets.only(top: 0.02 * height, left: 0.1 * width),
            child: Text(
              "Price right now",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Color.fromRGBO(157, 157, 157, 1),
                fontSize: 16,
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(top: 0.02 * height, left: 0.1 * width),
              child: Container(
                width: 0.85 * width,
                height: 0.07 * height,
                child: TextFormField(
                    controller: prn,
                    // obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(157, 157, 157, 0.5),
                          fontSize: 16,
                        ),
                        hintText: "20")),
              )),
          Padding(
            padding: EdgeInsets.only(top: 0.02 * height, left: 0.1 * width),
            child: Text(
              "Assets in hand (in units)",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Color.fromRGBO(157, 157, 157, 1),
                fontSize: 16,
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(top: 0.02 * height, left: 0.1 * width),
              child: Container(
                width: 0.85 * width,
                height: 0.07 * height,
                child: TextFormField(
                    controller: aih,
                    // obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(157, 157, 157, 0.5),
                          fontSize: 16,
                        ),
                        hintText: "5")),
              )),
          Padding(
            padding: EdgeInsets.only(top: 0.02 * height, left: 0.1 * width),
            child: Text(
              "Total assets in switch",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Color.fromRGBO(157, 157, 157, 1),
                fontSize: 16,
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(top: 0.02 * height, left: 0.1 * width),
              child: Row(
                children: [
                  Container(
                    width: 0.5 * width,
                    height: 0.07 * height,
                    child: TextFormField(
                        controller: tais,
                        // obscureText: true,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Color.fromRGBO(157, 157, 157, 0.5),
                              fontSize: 16,
                            ),
                            hintText: "20000000")),
                  ),
                  SizedBox(
                    width: 0.05 * width,
                  ),
                  InkWell(
                    onTap: () {
                      print("here");
                      if (list_cb_data.isEmpty) {
                        get_cb_data();
                      } else {
                        showcb();
                      }
                    },
                    child: Container(
                      width: width * 0.3,
                      height: height * 0.07,
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
                          "Choose Asset",
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
            padding: EdgeInsets.only(top: 0.02 * height, left: 0.1 * width),
            child: Text(
              "return switch in a day(%)",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Color.fromRGBO(157, 157, 157, 1),
                fontSize: 16,
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(top: 0.02 * height, left: 0.1 * width),
              child: Container(
                width: 0.85 * width,
                height: 0.07 * height,
                child: TextFormField(
                    controller: rsia,
                    // obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(157, 157, 157, 0.5),
                          fontSize: 16,
                        ),
                        hintText: "0.02")),
              )),
          Padding(
            padding: EdgeInsets.only(
                top: 0.04 * height, left: 0.1 * width, bottom: 0.025 * height),
            child: InkWell(
              onTap: () {
                calculate();
                // inserttypenproduct();
              },
              child: Container(
                width: width * 0.85,
                height: height * 0.07,
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
                    "Calculate",
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
      ),
    );
  }
}
