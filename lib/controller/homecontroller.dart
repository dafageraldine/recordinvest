import 'dart:async';
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
import '../screens/bottombar/bottombar.dart';
import '../screens/login/login.dart';

class HomeController extends GetxController with StateMixin {
  var date = "".obs;
  var saldo = 0.0.obs;
  var percent = "".obs;
  RxList<NotifModel> listNotif = <NotifModel>[].obs;
  var selectedTradingMonitor = [true, false].obs;
  RxInt selectedIndex = 0.obs;
  int timerRun = 0;

  //watchlist
  List<String> combStockType = ['indo', 'us'];
  RxString selectedStockType = "indo".obs;
  Rx<TextEditingController> values = TextEditingController().obs;
  Rx<TextEditingController> filename = TextEditingController().obs;
  RxString startdate = "choose date".obs;
  RxString enddate = "choose date".obs;
  RxList<WatchlistData> wlData = <WatchlistData>[].obs;

  //login
  Rx<TextEditingController> uname = TextEditingController().obs;
  Rx<TextEditingController> pass = TextEditingController().obs;

  final oCcy = NumberFormat.currency(
      locale: 'eu',
      customPattern: '#,### \u00a4',
      symbol: "",
      decimalDigits: 2);

  @override
  void onInit() {
    sessionLogin();
    super.onInit();
  }

  realTimeNotif() {
    if (timerRun == 0) {
      timerRun++;
      Timer.periodic(const Duration(minutes: 3), (timer) async {
        print("doing it");
        fillNotif();
        if (timerRun > 1) {
          timer.cancel();
          timerRun = 0;
        }
      });
    }
  }

  fillNotif() async {
    Box boxNotif = await getBoxOnly();
    var keyNotif = boxNotif.keys
        .where((k) => k.toString().toLowerCase().contains("|notif"))
        .toList();
    print(keyNotif);
    listNotif.clear();
    for (var i = 0; i < keyNotif.length; i++) {
      var dataNotif = await getData(keyNotif[i]);
      var decodedata = jsonDecode(dataNotif);
      listNotif.add(NotifModel(decodedata['judul'], decodedata['body'],
          decodedata['tgl'], keyNotif[i]));
    }
    await closeBox();
  }

  deleteWlList(WatchlistData selectedwldata) async {
    try {
      Box boxwldata = await getBoxOnly();
      await boxwldata.delete("${selectedwldata.name}|wl");
      getWlList();
    } catch (e) {
      Get.snackbar("error", "error delete watchlist $e",
          backgroundColor: errwithopacity);
    } finally {
      await closeBox();
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
      wlData.add(WatchlistData(decodedata['name'], decodedata['kode'],
          decodedata['jenis'], decodedata['start'], decodedata['url']));
    }
    await closeBox();
    wlData.refresh();
  }

  editwL(WatchlistData selectedwldata) {
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
        'url': urlUpdate,
        'lastupdate': ""
      };
      await saveData('${filename.value.text}|wl', jsonEncode(jsonData));
      await getWlList();
      clearWl();
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
      await closeBox();
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
    late Box box;
    try {
      box = await Hive.openBox('RecordInvestBox');
    } catch (e) {}
    box.put(key, values);
    await box.close();
  }

  Future getData(var key) async {
    late Box box;
    try {
      box = await Hive.openBox('RecordInvestBox');
    } catch (e) {}
    return await box.get(key);
  }

  Future getBoxOnly() async {
    late Box box;
    try {
      box = await Hive.openBox('RecordInvestBox');
    } catch (e) {}
    return box;
  }

  Future closeBox() async {
    late Box box;
    try {
      box = await Hive.openBox('RecordInvestBox');
    } catch (e) {}
    await box.close();
  }

  deleteNotif(NotifModel notifdata) async {
    listNotif.clear();
    Box box = await getBoxOnly();
    await box.delete(notifdata.keys);
    await closeBox();
    fillNotif();
    listNotif.refresh();
  }

  Future login(BuildContext context, TextEditingController uname,
      TextEditingController pass) async {
    try {
      var body = {"user": uname.text, "pwd": pass.text};
      http.Response postdata =
          await http.post(Uri.parse("${baseurl}login"), body: body);
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
        getSaldo();
        fillNotif();
        realTimeNotif();
        Get.to(BottomBar());
      } else {
        Get.snackbar("error", "Username atau password salah !",
            backgroundColor: errwithopacity);
      }
    } catch (e) {
      Get.snackbar("error", e.toString(), backgroundColor: errwithopacity);
    }
  }

  Future sessionLogin() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? uname = prefs.getString('uname');
      final String? pass = prefs.getString('pass');
      try {
        var body = {"user": uname, "pwd": pass};
        http.Response postdata =
            await http.post(Uri.parse("${baseurl}login"), body: body);
        var data = json.decode(postdata.body);
        if (data["data"].length > 0) {
          //use getx
          getSaldo();
          fillNotif();
          realTimeNotif();
          Get.to(BottomBar());
        } else {
          Timer(const Duration(seconds: 3), () {
            Get.to(Login());
          });
        }
      } catch (e) {
        if (uname != null && uname != "") {
          Get.to(BottomBar());
        } else {
          Timer(const Duration(seconds: 3), () {
            Get.to(Login());
          });
        }
      }
    } catch (e) {
      Timer(const Duration(seconds: 3), () {
        Get.to(Login());
      });
    }
  }
}
