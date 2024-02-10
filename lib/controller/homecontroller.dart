import 'dart:convert';
import 'dart:io';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:recordinvest/models/allmodel.dart';
import 'package:recordinvest/models/notifmodel.dart';
import 'package:recordinvest/screens/submenu/addwishlist.dart';
import 'package:recordinvest/screens/submenu/record.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/data.dart';

class HomeController extends GetxController with StateMixin {
  var date = "".obs;
  var saldo = 0.0.obs;
  var percent = "".obs;
  RxList<NotifModel> listNotif = <NotifModel>[].obs;
  var selectedTradingMonitor = [true, false].obs;
  RxInt selectedIndex = 0.obs;

  //watchlist
  List<String> combStockType = ['indo', 'us'];
  RxString selectedStockType = "indo".obs;
  Rx<TextEditingController> values = TextEditingController().obs;
  Rx<TextEditingController> filename = TextEditingController().obs;
  RxString startdate = "choose date".obs;
  RxString enddate = "choose date".obs;
  RxList<watchlistData> wlData = <watchlistData>[].obs;

  final oCcy = NumberFormat.currency(
      locale: 'eu',
      customPattern: '#,### \u00a4',
      symbol: "",
      decimalDigits: 2);

  @override
  void onInit() {
    getSaldo();
    // fillDummy();
    super.onInit();
  }

  // fillDummy() {
  //   listNotif.clear();
  //   listNotif.add(NotifModel("Rekomendasi Saham",
  //       "Beli Saham BBCA dengan teknikal analisis MA5 & MA20", "2024-02-10"));
  // }

  deleteWlList(watchlistData selectedwldata) async {
    try {
      Box boxwldata = await getBoxOnly();
      await boxwldata.delete("${selectedwldata.name}|wl");
      getWlList();
    } catch (e) {
      Get.snackbar("error", "error delete watchlist $e",
          backgroundColor: errwithopacity);
    }
  }

  clearWl() {
    filename.value.clear();
    startdate.value = "choose date";
    values.value.clear();
  }

  getWlList() async {
    wlData.clear();
    Box boxWl = await getBoxOnly();
    var keyWl = boxWl.keys
        .where((k) => k.toString().toLowerCase().contains("|wl"))
        .toList();
    for (var i = 0; i < keyWl.length; i++) {
      var dataWl = await getData(keyWl[i]);
      var decodedata = jsonDecode(dataWl);
      wlData.add(watchlistData(decodedata['name'], decodedata['kode'],
          decodedata['jenis'], decodedata['start'], decodedata['url']));
    }
    wlData.refresh();
  }

  editwL(watchlistData selectedwldata) {
    selectedStockType.value = selectedwldata.jenis;
    values.value.text = selectedwldata.code;
    filename.value.text = selectedwldata.name;
    startdate.value = selectedwldata.start;
    Get.to(Addwatchlist());
  }

  addwatchlistData() async {
    if (startdate.value == "choose date") {
      Get.snackbar("warning", "choose date first !",
          backgroundColor: warnwithopacity);
      return;
    } else if (values.value.text == "") {
      Get.snackbar("warning", "fill global stock code !",
          backgroundColor: warnwithopacity);
      return;
    } else if (filename.value.text == "") {
      Get.snackbar("warning", "fill filename !",
          backgroundColor: warnwithopacity);
      return;
    }
    try {
      var urlUpdate =
          "${baseurl}update_stock?jenis=${selectedStockType.value}&kode=${values.value.text}&saveas=${filename.value.text}&start=${startdate.value}&end=";
      var jsonData = {
        'name': filename.value.text,
        'kode': values.value.text,
        'jenis': selectedStockType.value,
        'start': startdate.value,
        'url': urlUpdate
      };
      await saveData('${filename.value.text}|wl', jsonEncode(jsonData));
      await getWlList();
      filename.value.clear();
      startdate.value = "choose date";
      values.value.clear();
      Get.snackbar("Success", "success add watchlist ${filename.value.text}",
          backgroundColor: sucswithopacity);
    } catch (e) {
      Get.snackbar("error", "error add watchlist $e",
          backgroundColor: errwithopacity);
    }
  }

  datepick(String jenis) {
    showDatePicker(
            context: Get.context!,
            initialDate: DateTime.now(),
            firstDate: DateTime(2010),
            lastDate: DateTime(2100))
        .then((date) {
      if (jenis == "start") {
        startdate.value = DateFormat('yyyy-MM-dd').format(date!);
      } else {
        enddate.value = DateFormat('yyyy-MM-dd').format(date!);
      }
    });
  }

  Future getType() async {
    comboboxtype.clear();
    comboboxproduct.clear();
    comboboxtype.add("pilih investment type");
    comboboxproduct.add("pilih produk");
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? id = prefs.getString('id');
      var body = {"id": id};
      http.Response postdata =
          await http.post(Uri.parse("${baseurl}gettype"), body: body);
      var data = json.decode(postdata.body);
      for (int i = 0; i < data["data"].length; i++) {
        comboboxtype.add(data["data"][i]["type"]);
      }
      getProduct();
    } catch (e) {
      Get.snackbar("error", e.toString(), backgroundColor: errwithopacity);
    }
  }

  Future getProduct() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? id = prefs.getString('id');
      var body = {"id": id};
      http.Response postdata =
          await http.post(Uri.parse("${baseurl}getproduct"), body: body);
      var data = json.decode(postdata.body);
      for (int i = 0; i < data["data"].length; i++) {
        comboboxproduct.add(data["data"][i]["name"]);
      }
      Get.to(Recordpage());
    } catch (e) {
      Get.snackbar("error", e.toString(), backgroundColor: errwithopacity);
    }
  }

  Future getSaldo() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? id = prefs.getString('id');
      var body = {"id": id};
      http.Response postdata =
          await http.post(Uri.parse("${baseurl}getsaldo"), body: body);
      await parseSaldoJson(postdata.body);
      await saveData("saldoData", postdata.body);
    } catch (e) {
      var ldata = await getData("saldoData");
      if (ldata != null && ldata != "") {
        try {
          Get.snackbar(
              "error", "failed to fetch saldo $e retrying using last data",
              backgroundColor: errwithopacity);
          await parseSaldoJson(ldata);
        } catch (e) {
          Get.snackbar("error", "failed to fetch saldo $e using last data",
              backgroundColor: errwithopacity);
        }
      } else {
        Get.snackbar("error", "failed to fetch saldo $e",
            backgroundColor: errwithopacity);
      }
    }
  }

  parseSaldoJson(var ldata) async {
    var data = json.decode(ldata);
    var databefore = 0.0;
    var datanow = 0.0;
    for (int i = 0; i < data["data"].length; i++) {
      saldo.value = data["data"][i]["saldo"];
      date.value = data["data"][i]["date"];
      datanow = data["data"][i]["saldo"];
      databefore = data["data"][i]["saldobefore"];
    }
    var persen = 0.0;
    if (databefore > 0) {
      persen = (datanow - databefore) / databefore * 100.0;
    }
    if (persen > 0) {
      percent.value = "+ ${persen.toStringAsFixed(2)} % than previous data";
    } else if (persen < 0) {
      percent.value = "${persen.toStringAsFixed(2)} % than previous data";
    }
  }

  showAlertDialog(var action, String titleAlert, String msgAlert) {
    // set up the buttons
    Widget cancelButton = TextButton(
      onPressed: () {
        Get.back();
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey.shade600,
            borderRadius: BorderRadius.circular(5)),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 5, bottom: 5.0, left: 20, right: 20),
          child: Text("No",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 12.sp,
                color: Colors.grey.shade300,
              )),
        ),
      ),
    );
    Widget continueButton = TextButton(
      onPressed: action,
      child: Container(
        decoration:
            BoxDecoration(color: theme, borderRadius: BorderRadius.circular(5)),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 5, bottom: 5.0, left: 20, right: 20),
          child: Text("Yes",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 12.sp,
                color: Colors.white,
              )),
        ),
      ),
    );

    Get.dialog(AlertDialog(
      title: Text(titleAlert),
      content: Text(msgAlert),
      actions: [
        cancelButton,
        continueButton,
      ],
    ));
  }

  Future saveData(var key, var values) async {
    var box = await Hive.openBox('RecordInvestBox');
    box.put(key, values);
  }

  Future getData(var key) async {
    var box = await Hive.openBox('RecordInvestBox');
    return await box.get(key);
  }

  Future getBoxOnly() async {
    var box = await Hive.openBox('RecordInvestBox');
    return box;
  }

  deleteNotif() {
    listNotif.clear();
    listNotif.refresh();
  }
}
