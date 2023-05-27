import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../models/data.dart';
import '../models/recorddata.dart';
import 'dart:convert';

class PerformanceController extends GetxController with StateMixin {
  RxList<ChartData> chartData = <ChartData>[].obs;
  RxList<PerformanceChartData> performance_chart_data =
      <PerformanceChartData>[].obs;
  RxList<String> added = <String>[].obs;
  RxList<RecordData> listrecord = <RecordData>[].obs;
  var total = 0.0.obs;
  var awal = "start date".obs;
  var end = "finish date".obs;
  var df = "".obs;
  var ds = "".obs;
  final oCcy = NumberFormat.currency(
      locale: 'eu',
      customPattern: '#,### \u00a4',
      symbol: "",
      decimalDigits: 2);

  void filldf_ds() {
    DateTime currentDate = DateTime.now();
    int daysAgo = 30;
    DateTime fewDaysAgo = currentDate.subtract(Duration(days: daysAgo));
    String formattedDate = DateFormat('yyyy-MM-dd').format(fewDaysAgo);
    df.value = DateFormat('yyyy-MM-dd').format(DateTime.now());
    ds.value = formattedDate;
    get_record_range();
  }

  void showDialogfilter(judul, konten) {
    Get.dialog(Dialog(
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: SizedBox(
        width: 0.85 * Get.width,
        height: 0.3 * Get.height,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: 0.1 * Get.width, top: 0.03 * Get.height),
              child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Choose date",
                    style: TextStyle(
                        color: Color.fromRGBO(82, 82, 82, 1),
                        fontSize: 14,
                        // fontFamily: 'Inter',
                        fontWeight: FontWeight.w600),
                  )),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.only(left: 0.1 * Get.width),
              child: Align(
                alignment: Alignment.centerLeft,
                child: InkWell(
                  onTap: () {
                    showDatePicker(
                            context: Get.context!,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2020),
                            lastDate: DateTime(2100))
                        .then((date) {
                      ds.value = DateFormat('yyyy-MM-dd').format(date!);
                      Get.back();
                      showDialogfilter("", "");
                    });
                  },
                  child: Container(
                    width: 0.6 * Get.width,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      border: Border.all(
                          color: const Color.fromRGBO(228, 228, 228, 1),
                          width: 2),
                      color: Colors.white,
                    ),
                    child: Center(
                        child: Text(
                      ds.value,
                      style: const TextStyle(
                          color: Color.fromRGBO(160, 160, 160, 1),
                          fontSize: 14,
                          // fontFamily: 'Inter',
                          fontWeight: FontWeight.w600),
                    )),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 0.1 * Get.width, top: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: InkWell(
                  onTap: () {
                    showDatePicker(
                            context: Get.context!,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2020),
                            lastDate: DateTime(2100))
                        .then((date) {
                      df.value = DateFormat('yyyy-MM-dd').format(date!);
                      Get.back();
                      showDialogfilter("", "");
                    });
                  },
                  child: Container(
                    width: 0.6 * Get.width,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      border: Border.all(
                          color: const Color.fromRGBO(228, 228, 228, 1),
                          width: 2),
                      color: Colors.white,
                    ),
                    child: Center(
                        child: Text(
                      df.value,
                      style: const TextStyle(
                          color: Color.fromRGBO(160, 160, 160, 1),
                          fontSize: 14,
                          // fontFamily: 'Inter',
                          fontWeight: FontWeight.w600),
                    )),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            InkWell(
              onTap: () {
                Get.back();
                get_record_range();
              },
              child: Container(
                width: 0.7 * Get.width,
                height: 0.07 * Get.height,
                decoration: BoxDecoration(
                    color: theme, borderRadius: BorderRadius.circular(10)),
                child: const Center(
                    child: Text(
                  "Search",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                )),
              ),
            ),
            // 15.verticalSpace,
          ],
        ),
      ),
    ));
  }

  Future getrecord() async {
    try {
      listrecord.clear();
      final prefs = await SharedPreferences.getInstance();
      final String? id = prefs.getString('id');
      var body = {"date": df.value, "id": id};
      http.Response postdata =
          await http.post(Uri.parse("${baseurl}getrecord"), body: body);
      var data = json.decode(postdata.body);
      for (int i = 0; i < data["data"].length; i++) {
        listrecord.add(RecordData(
            data["data"][i]["date"],
            data["data"][i]["value"].toString(),
            data["data"][i]["type"],
            data["data"][i]["product"]));
      }
      if (listrecord.isNotEmpty) {
        fill_chart();
      } else {
        Get.snackbar("warning", "There are no data for $awal !",
            backgroundColor: warnwithopacity);
        chartData.clear();
      }
    } catch (e) {
      Get.snackbar("error", e.toString(), backgroundColor: errwithopacity);
    }
  }

  Future get_record_range() async {
    try {
      performance_chart_data.clear();
      // setState(() {});
      final prefs = await SharedPreferences.getInstance();
      final String? id = prefs.getString('id');
      var body = {"datestart": ds.value, "datefinish": df.value, "id": id};
      http.Response postdata = await http
          .post(Uri.parse("${baseurl}get_record_by_range"), body: body);
      var data = json.decode(postdata.body);
      for (int i = 0; i < data["data"].length; i++) {
        performance_chart_data.add(PerformanceChartData(
            data["data"][i]["date"], data["data"][i]["money"]));
      }
      if (performance_chart_data.isNotEmpty) {
        performance_chart_data.sort((a, b) => a.day.compareTo(b.day));
        // fill_chart();
      } else {
        Get.snackbar("error", "There are no data !",
            backgroundColor: errwithopacity);
        performance_chart_data.clear();
      }
    } catch (e) {
      Get.snackbar("error", e.toString(), backgroundColor: errwithopacity);
      performance_chart_data.clear();
    }
  }

  fill_chart() {
    chartData.clear();
    added.clear();
    total.value = 0.0;
    for (var i = 0; i < listrecord.length; i++) {
      for (var j = 0; j < listrecord.length; j++) {
        if (listrecord[i].type == listrecord[j].type) {
          if (chartData.isEmpty) {
            added.add(listrecord[j].product);
            chartData.add(ChartData(listrecord[i].type,
                double.tryParse(listrecord[j].value)!, Colors.blue));
          } else {
            int flag = 0;
            for (var m = 0; m < chartData.length; m++) {
              if (flag == 1) {
                break;
              } else {
                if (listrecord[i].type == chartData[m].x) {
                  for (var l = 0; l < added.length; l++) {
                    if (listrecord[j].product == added[l]) {
                      flag = 1;
                      break;
                    }
                  }
                  if (flag == 0) {
                    added.add(listrecord[j].product);
                    chartData[m].y =
                        chartData[m].y + double.tryParse(listrecord[j].value)!;
                    flag = 1;
                  }
                }
              }
            }
            if (flag == 0) {
              added.add(listrecord[j].product);
              chartData.add(ChartData(listrecord[i].type,
                  double.tryParse(listrecord[j].value)!, Colors.blue));
            }
          }
        }
        // print("ini isi j " + j.toString() + "ini isi i " + i.toString());
      }
    }
    // --------------------
    for (var i = 0; i < chartData.length; i++) {
      total.value = total.value + chartData[i].y;
      var rng = Random();
      chartData[i].color = Color.fromRGBO(
          rng.nextInt(155), rng.nextInt(200), rng.nextInt(180), 1);
      // print(chartData[i].x + " " + chartData[i].y.toString() + " ");
    }

    for (var i = 0; i < chartData.length; i++) {
      var persen = chartData[i].y / total.value * 100;
      chartData[i].x = "${chartData[i].x} ${persen.toStringAsFixed(2)}%";
    }

    //   if(listrecord[i].type == listrecord)
    //   var data = double.tryParse(listrecord[i].value.toString());
    //   total = total + data!;
    // print(total);
  }

  @override
  void onInit() {
    print("here");
    listrecord.clear();
    filldf_ds();
    super.onInit();
  }
}

class ChartData {
  ChartData(this.x, this.y, this.color);
  String x;
  double y;
  Color color;
}

class PerformanceChartData {
  String day;
  double money;
  PerformanceChartData(this.day, this.money);
}
