
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/login/login.dart';

class SettingController extends GetxController {
  logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('uname');
    await prefs.remove('pass');
    await prefs.remove('id');
    Get.offAll(Login());
  }

  showAlertDialog(var action, String tittle,String  msg) {
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
      onPressed: action,
    );

    Get.dialog(AlertDialog(
      title:  Text(tittle),
      content: Text(msg),
      actions: [
        cancelButton,
        continueButton,
      ],
    ));
  }
}
