import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recordinvest/models/data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddTypeController extends GetxController {
  Rx<TextEditingController> type = TextEditingController().obs;
  Rx<TextEditingController> product = TextEditingController().obs;

  Future inserttypenproduct() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? id = prefs.getString('id');
      var body = {
        "type": type.value.text,
        "name": product.value.text,
        "id": id
      };
      http.Response postdata = await http
          .post(Uri.parse("${baseurl}inserttypenproduct"), body: body);
      var data = json.decode(postdata.body);
      if (data["message"] == "data has been added") {
        Get.snackbar("success", "data has been added",
            backgroundColor: sucswithopacity);
      }
    } catch (e) {
      Get.snackbar("error", e.toString(), backgroundColor: errwithopacity);
    }
  }
}
