import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:recordinvest/screens/home/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../models/data.dart';
import '../viewmodels/home/homeviewmodel.dart';

class LoginController extends GetxController {
  Future login(BuildContext context, TextEditingController uname,
      TextEditingController pass) async {
    try {
      print("login");
      var body = {"user": uname.text, "pwd": pass.text};
      http.Response postdata =
          await http.post(Uri.parse(baseurl + "login"), body: body);
      print(" url " + baseurl + "login");
      var data = json.decode(postdata.body);
      if (data["data"].length > 0) {
        for (int i = 0; i < data["data"].length; i++) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('uname', data["data"][i]["user"]);
          await prefs.setString('pass', pass.text);
          await prefs.setString('id', data["data"][i]["id"]);
          break;
        }
        //use getx
        // Get.to(Homepage());

        //use provider
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChangeNotifierProvider<HomeViewModel>(
                    create: (context) => HomeViewModel(), child: Homepage())));
      } else {
        Fluttertoast.showToast(
            msg: "Username atau password salah !",
            backgroundColor: Colors.black,
            textColor: Colors.white);
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(
          msg: e.toString(),
          backgroundColor: Colors.black,
          textColor: Colors.white);
    }
  }

  showAlertDialog() {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text(
        "No",
        style: TextStyle(color: Colors.grey),
      ),
      onPressed: () {
        Get.back();
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
      },
    );

    Get.dialog(AlertDialog(
      title: Text("Warning"),
      content: Text("Do you want exit ?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    ));
  }
}
