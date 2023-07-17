import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:recordinvest/models/avgsavingmodel.dart';
import 'package:recordinvest/models/data.dart';
import 'package:recordinvest/screens/submenu/resulttarget.dart';

class CalculateTargetController extends GetxController {
  var avgPerDay = "".obs;
  var avgsavingpermonth = "".obs;
  var saldoakhir = "".obs;
  var saldoawal = "".obs;
  var tglakhir = "".obs;
  var tglawal = "".obs;
  RxBool isLoading = false.obs;
  Rx<TextEditingController> values = TextEditingController().obs;
  Rx<TextEditingController> stfrom = TextEditingController().obs;
  NumberFormat formatter =
      NumberFormat.currency(locale: 'en_US', symbol: 'Rp', decimalDigits: 2);

  Future<String> calculatetarget() async {
    await getavgsaving();
    double avgPerDayParsed =
        double.parse(avgPerDay.value.replaceAll(RegExp(r'[^0-9.]'), ''));
    var day =
        ((double.parse(values.value.text) - double.parse(stfrom.value.text)) /
                avgPerDayParsed)
            .ceil();
    if (day > 29) {
      var month = (day / 30).ceil();
      if ((month * 30) < day) {
        var sisa = day - (month * 30);
        print("$month bulan $sisa hari");
        return "$month bulan $sisa hari";
      } else {
        print("$month bulan");
        return "$month bulan";
      }
    }
    print("$day hari");
    return "$day hari";
  }

  Future<void> getresult() async {
    isLoading.value = true;
    var result = await calculatetarget();
    isLoading.value = false;
    Get.to(ResultTarget(
      result: result,
    ));
  }

  Future<void> getavgsaving() async {
    http.Response getdata = await http.get(Uri.parse("${baseurl}gettarget"));
    Map<String, dynamic> json = jsonDecode(getdata.body);
    AvgSavingModel response = AvgSavingModel.fromJson(json);
    avgPerDay.value = response.avgPerDay;
    avgsavingpermonth.value = response.avgSavingPerMonth;
    saldoakhir.value = response.saldoAkhir;
    saldoawal.value = response.saldoAwal;
    tglakhir.value = response.tglAkhir;
    tglawal.value = response.tglAwal;
  }
}
