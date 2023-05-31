import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/data.dart';

class UpdateStockController extends GetxController {
  List<String> combStockType = ['indo', 'us'];
  RxString selectedStockType = "indo".obs;
  Rx<TextEditingController> values = TextEditingController().obs;
  Rx<TextEditingController> filename = TextEditingController().obs;
  RxString startdate = "choose date".obs;
  RxString enddate = "choose date".obs;

  Future updateStockData() async {
    try {
      // example
      // https://dafageraldine.pythonanywhere.com/update_stock?jenis=us&kode=GOOG&saveas=GOOG&start=2018-01-01&end=2023-05-29
      http.Response getdata = await http.get(Uri.parse(
          "${baseurl}update_stock?jenis=${selectedStockType.value}&kode=${values.value.text}&saveas=${filename.value.text}&start=${startdate.value}&end=${enddate.value}"));
      var data = json.decode(getdata.body);
      if (data['message'] == "success") {
        Get.snackbar("success", "data for ${values.value.text} updated !",
            backgroundColor: sucswithopacity);
      } else {
        Get.snackbar("error", data['message'].toString(),
            backgroundColor: errwithopacity);
      }
    } catch (e) {
      Get.snackbar(
          "error", "try again ! make sure you have internet connection",
          backgroundColor: errwithopacity);
    }
  }

  datepick(String jenis) {}
}
