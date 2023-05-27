import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:recordinvest/screens/menu/record.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/data.dart';

class HomeController extends GetxController with StateMixin {
  var date = "".obs;
  var saldo = 0.0.obs;
  var percent = "".obs;

  final oCcy = NumberFormat.currency(
      locale: 'eu',
      customPattern: '#,### \u00a4',
      symbol: "",
      decimalDigits: 2);

  @override
  void onInit() {
    getSaldo();
    super.onInit();
  }

  Future getType() async {
    comboboxtype.clear();
    comboboxproduct.clear();
    comboboxtype.add("pilih investment type");
    comboboxproduct.add("pilih produk");
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? id = prefs.getString('id');
      var body = {"id": id};
      http.Response postdata =
          await http.post(Uri.parse("${baseurl}gettype"), body: body);
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
          await http.post(Uri.parse("${baseurl}getproduct"), body: body);
      var data = json.decode(postdata.body);
      for (int i = 0; i < data["data"].length; i++) {
        comboboxproduct.add(data["data"][i]["name"]);
      }
      Get.to(Recordpage());
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
          await http.post(Uri.parse("${baseurl}getsaldo"), body: body);
      // http.Response getdata = await http.get(Uri.parse(baseurl + "getsaldo"));
      var data = json.decode(postdata.body);
      var databefore = 0.0;
      var datanow = 0.0;
      // print(data);
      for (int i = 0; i < data["data"].length; i++) {
        saldo.value = data["data"][i]["saldo"];
        date.value = data["data"][i]["date"];
        datanow = data["data"][i]["saldo"];
        databefore = data["data"][i]["saldobefore"];
      }
      var persen = 0.0;
      // print(datanow.toString() + "  " + databefore.toString());
      if (databefore > 0) {
        persen = (datanow - databefore) / databefore * 100.0;
      }
      if (persen > 0) {
        percent.value = "+ ${persen.toStringAsFixed(2)} % than previous data";
        // print(percent);
      } else if (persen < 0) {
        percent.value = "${persen.toStringAsFixed(2)} % than previous data";
        // print(percent);
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: "failed to fetch saldo $e",
          backgroundColor: Colors.black,
          textColor: Colors.white);
    }
  }

  showAlertDialog() {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: const Text(
        "No",
        style: TextStyle(color: Colors.grey),
      ),
      onPressed: () {
        Get.back();
      },
    );
    Widget continueButton = TextButton(
      child: const Text(
        "yes",
        style: TextStyle(
          color: Color.fromRGBO(144, 200, 172, 1),
        ),
      ),
      onPressed: () async {
        exit(0);
      },
    );

    Get.dialog(AlertDialog(
      title: const Text("Warning"),
      content: const Text("Do you want exit ?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    ));
  }
}
