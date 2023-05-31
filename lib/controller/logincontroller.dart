import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recordinvest/screens/bottombar/bottombar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../models/data.dart';

class LoginController extends GetxController {
  Rx<TextEditingController> uname = TextEditingController().obs;
  Rx<TextEditingController> pass = TextEditingController().obs;
  Future login(BuildContext context, TextEditingController uname,
      TextEditingController pass) async {
    try {
      print("login");
      var body = {"user": uname.text, "pwd": pass.text};
      http.Response postdata =
          await http.post(Uri.parse("${baseurl}login"), body: body);
      print(" url ${baseurl}login");
      var data = json.decode(postdata.body);
      if (data["data"].length > 0) {
        for (var i = 0; i < data["data"].length; i++) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('uname', data["data"][i]["user"]);
          await prefs.setString('pass', pass.text);
          await prefs.setString('id', data["data"][i]["id"]);
          break;
        }
        //use getx
        Get.to(BottomBar());
      } else {
        Get.snackbar("error", "Username atau password salah !",
            backgroundColor: errwithopacity);
      }
    } catch (e) {
      Get.snackbar("error", e.toString(), backgroundColor: errwithopacity);
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
