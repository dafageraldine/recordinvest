import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:recordinvest/screens/menu/record.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/data.dart';

class HomeViewModel extends ChangeNotifier {
  var _date = "";
  var _saldo = "";
  var _percent = "";

  get date => _date;
  get saldo => _saldo;
  get percent => _percent;

  final oCcy = NumberFormat.currency(
      locale: 'eu',
      customPattern: '#,### \u00a4',
      symbol: "",
      decimalDigits: 2);

  Future getType(BuildContext context) async {
    comboboxtype.clear();
    comboboxproduct.clear();
    comboboxtype.add("pilih investment type");
    comboboxproduct.add("pilih produk");
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
      getProduct(context);
    } catch (e) {
      Fluttertoast.showToast(
          msg: e.toString(),
          backgroundColor: Colors.black,
          textColor: Colors.white);
    }
  }

  Future getProduct(BuildContext context) async {
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
          context,
          MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider<HomeViewModel>(
                  create: (context) => HomeViewModel(), child: Recordpage())));
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
      print(data);
      for (int i = 0; i < data["data"].length; i++) {
        _saldo = oCcy.format(data["data"][i]["saldo"]).toString();
        saldoglobal = data["data"][i]["saldo"];
        _date = data["data"][i]["date"];
        datanow = data["data"][i]["saldo"];
        databefore = data["data"][i]["saldobefore"];
      }
      var persen = 0.0;
      print(datanow.toString() + "  " + databefore.toString());
      if (databefore > 0) {
        persen = (datanow - databefore) / databefore * 100.0;
      }
      if (persen > 0) {
        _percent = "+ " + persen.toStringAsFixed(2) + " % than previous data";
        print(percent);
      } else if (persen < 0) {
        _percent = persen.toStringAsFixed(2) + " % than previous data";
        print(percent);
      }
      notifyListeners();
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
}
