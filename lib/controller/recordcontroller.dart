import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recordinvest/controller/homecontroller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../models/comboboxdata.dart';
import '../models/data.dart';

class RecordController extends GetxController with StateMixin {
  var selectedtype = "".obs, selectedproduct = "".obs;
  Rx<TextEditingController> values = TextEditingController().obs;

  final HomeController _homeController = Get.find();

  @override
  void onInit() {
    selectedtype.value = comboboxtype[0];
    selectedproduct.value = comboboxproduct[0];
    super.onInit();
  }

  Future insertrecord() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? id = prefs.getString('id');
      var body = {
        "type": selectedtype,
        "product": selectedproduct,
        "value": values.value.text,
        "id": id
      };
      http.Response postdata =
          await http.post(Uri.parse("${baseurl}insertrecord"), body: body);
      var data = json.decode(postdata.body);
      if (data["message"] == "data has been added") {
        list_cb_data.clear();
        combobox.clear();
        await _homeController.getSaldo();
        Get.snackbar("success", "data has been added",
            backgroundColor: sucswithopacity);
      }
    } catch (e) {
      Get.snackbar("error", e.toString(), backgroundColor: errwithopacity);
    }
  }
}
