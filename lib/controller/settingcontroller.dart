
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
        // exit(0);
        logout();
      },
    );

    Get.dialog(AlertDialog(
      title: const Text("Warning"),
      content: const Text("Do you want to log out ?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    ));
  }
}
