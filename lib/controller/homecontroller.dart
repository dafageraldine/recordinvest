import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:recordinvest/components/showresultunperform.dart';
import 'package:recordinvest/models/allmodel.dart';
import 'package:recordinvest/screens/submenu/addwishlist.dart';
import 'package:recordinvest/screens/submenu/record.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/data.dart';
import '../screens/bottombar/bottombar.dart';
import '../screens/login/login.dart';
import '../screens/submenu/analyzedetail.dart';
import '../screens/submenu/hasilsimulasi.dart';
import '../screens/submenu/hasilsimulasiporto.dart';
import '../screens/submenu/resultanalyzedata.dart';
import '../screens/submenu/resulttarget.dart';

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
  NumberFormat formatterRp =
      NumberFormat.currency(locale: 'en_US', symbol: 'Rp', decimalDigits: 2);

  var selectedtype = "".obs, selectedproduct = "".obs;
  List<ComboBoxData> list_cb_data = <ComboBoxData>[];

  Rx<TextEditingController> floss = TextEditingController().obs;
  Rx<TextEditingController> kurs = TextEditingController().obs;
  Rx<TextEditingController> mi = TextEditingController().obs;
  Rx<TextEditingController> dl = TextEditingController().obs;
  Rx<TextEditingController> prn = TextEditingController().obs;
  Rx<TextEditingController> aih = TextEditingController().obs;
  Rx<TextEditingController> tais = TextEditingController().obs;
  Rx<TextEditingController> rsia = TextEditingController().obs;
  var selectedpilihan = "".obs;

  Rx<TextEditingController> type = TextEditingController().obs;
  Rx<TextEditingController> product = TextEditingController().obs;

  List<Pilihan> listNmtype = <Pilihan>[];

  List<String> combStockTypeNew = ['indo', 'us'];
  RxString selectedStockTypeNew = "indo".obs;
  Rx<TextEditingController> valuesNew = TextEditingController().obs;
  Rx<TextEditingController> filenameNew = TextEditingController().obs;
  RxString startdateNew = "choose date".obs;
  RxString enddateNew = "choose date".obs;

  RxString selectedStockTypeval = "indo".obs;
  RxString selectedStockName = "".obs;
  Rx<TextEditingController> valuesStock = TextEditingController().obs;
  List<Stock> stockdataindo = <Stock>[];
  List<Stock> stockdataus = <Stock>[];
  RxList<String> combStockName = <String>[].obs;
  RxList<String> combStockUs = <String>[].obs;
  RxList<AnalyzeData> analyzedata = <AnalyzeData>[].obs;
  RxList<ResultAnalyzeDetail> analyzedatadetail = <ResultAnalyzeDetail>[].obs;
  RxBool isLoading = false.obs;

  Rx<TextEditingController> bunga = TextEditingController().obs;
  Rx<TextEditingController> tenor = TextEditingController().obs;
  Rx<TextEditingController> otr = TextEditingController().obs;
  Rx<TextEditingController> dp = TextEditingController().obs;
  var finalplafonpinjaman = 0.0.obs,
      finalangsuranpokok = 0.0.obs,
      finalangsuranbunga = 0.0.obs,
      finalangsuranakhir = 0.0.obs;

  var avgPerDay = "".obs;
  var avgsavingpermonth = "".obs;
  var saldoakhir = "".obs;
  var saldoawal = "".obs;
  var tglakhir = "".obs;
  var tglawal = "".obs;
  RxBool isLoadingCal = false.obs;
  Rx<TextEditingController> valuescal = TextEditingController().obs;
  Rx<TextEditingController> stfrom = TextEditingController().obs;

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

  @override
  void onInit() {
    sessionLogin();
    super.onInit();
  }

  void calculateCicilan() {
    try {
      var hargaotr = int.tryParse(otr.value.text.replaceAll(",", ""));
      var dpmobil = double.tryParse(dp.value.text.replaceAll(",", ""))!;
      var tenorcicilan = int.tryParse(tenor.value.text);
      var bungacicilan = double.tryParse(bunga.value.text);
      var plafonpinjaman = hargaotr! - dpmobil;
      var angsuranpokok = plafonpinjaman / (tenorcicilan! * 12);
      var angsuranbunga = (plafonpinjaman * (bungacicilan! / 100)) / 12;
      var angsuranakhir = angsuranpokok + angsuranbunga;

      finalplafonpinjaman.value = plafonpinjaman.toDouble();
      finalangsuranpokok.value = angsuranpokok;
      finalangsuranbunga.value = angsuranbunga;
      finalangsuranakhir.value = angsuranakhir;
      Get.to(HasilSimulasi(
          finalplafonpinjaman.value,
          finalangsuranpokok.value,
          finalangsuranbunga.value,
          finalangsuranakhir.value,
          hargaotr,
          dpmobil,
          tenorcicilan));
    } catch (e) {
      Get.snackbar("error", "masukkan data yang valid !",
          backgroundColor: errwithopacity);
    }
  }

  cbStockTypeAction() async {
    if (selectedStockTypeval.value == "indo") {
      if (stockdataindo.isEmpty) {
        await getListEmiten();
      } else {
        fillcbStockName();
      }
    } else {
      if (stockdataus.isEmpty) {
        await getListEmiten();
      } else {
        fillcbStockNameUS();
      }
    }
  }

  Future getListEmiten() async {
    var stocktype = selectedStockTypeval.value;
    isLoading.value = true;
    try {
      if (stocktype == "us") {
        stockdataus.clear();
      } else {
        stockdataindo.clear();
      }
      http.Response getdata = await http.get(Uri.parse(
          "${baseurl}get_list_emiten?jenis=${selectedStockTypeval.value}"));
      Map<String, dynamic> json = jsonDecode(getdata.body);
      StockData stockData = StockData.fromJson(json);
      if (stocktype == "us") {
        for (var stock in stockData.data) {
          stockdataus.add(stock);
        }
        fillcbStockNameUS();
      } else {
        for (var stock in stockData.data) {
          stockdataindo.add(stock);
        }
        fillcbStockName();
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
          "error", "try again ! make sure you have internet connection");
    }
  }

  fillcbStockName() {
    combStockName.clear();
    for (var i = 0; i < stockdataindo.length; i++) {
      combStockName.add("${stockdataindo[i].code} | ${stockdataindo[i].name}");
    }
    selectedStockName.value = combStockName[0];
  }

  fillcbStockNameUS() {
    combStockName.clear();
    for (var i = 0; i < stockdataus.length; i++) {
      combStockName.add("${stockdataus[i].code} | ${stockdataus[i].name}");
    }
    selectedStockName.value = combStockName[0];
  }

  Future analyzeStock() async {
    analyzedata.clear();
    isLoading.value = true;
    try {
      http.Response getdata = await http.get(Uri.parse(
          "${baseurl}analyze?jenis=${selectedStockTypeval.value}&code=${selectedStockName.split("| ")[0].trim()}&money=${valuesStock.value.text.replaceAll(",", "")}"));
      Map<String, dynamic> json = jsonDecode(getdata.body);
      AnalyzeDataModel dataModel = AnalyzeDataModel.fromJson(json);
      for (var data in dataModel.data) {
        analyzedata.add(data);
      }
      isLoading.value = false;
      Get.to(ResultAnalyzeData());
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
          "error", "try again ! make sure you have internet connection");
    }
  }

  Future analyzeDetail(String ma) async {
    analyzedatadetail.clear();
    isLoading.value = true;
    try {
      http.Response getdata = await http.get(Uri.parse(
          "${baseurl}detail_analyze?jenis=${selectedStockTypeval.value}&code=${selectedStockName.split("| ")[0].trim()}&maselected=${ma.replaceAll("&", "_")}"));
      Map<String, dynamic> json = jsonDecode(getdata.body);
      ResultAnalyzeDetailModel dataModel =
          ResultAnalyzeDetailModel.fromJson(json);
      for (var data in dataModel.data) {
        analyzedatadetail.add(data);
      }
      isLoading.value = false;
      Get.to(AnalyzeDetail(
        maSelected: ma,
      ));
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
          "error", "try again ! make sure you have internet connection");
    }
  }

  realTimeNotif() {
    if (timerRun == 0) {
      timerRun++;
      Timer.periodic(const Duration(minutes: 3), (timer) async {
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
      selectedtype.value = comboboxtype[0];
      selectedproduct.value = comboboxproduct[0];
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

  Future insertrecord() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? id = prefs.getString('id');
      var body = {
        "type": selectedtype.value,
        "product": selectedproduct.value,
        "value": values.value.text.replaceAll(",", ""),
        "id": id
      };
      http.Response postdata =
          await http.post(Uri.parse("${baseurl}insertrecord"), body: body);
      var data = json.decode(postdata.body);
      if (data["message"] == "data has been added") {
        list_cb_data.clear();
        combobox.clear();
        await getSaldo();
        Get.snackbar("success", "data has been added",
            backgroundColor: sucswithopacity);
      }
    } catch (e) {
      Get.snackbar("error", e.toString(), backgroundColor: errwithopacity);
    }
  }

  Future getCbData() async {
    try {
      list_cb_data.clear();
      combobox.clear();
      final prefs = await SharedPreferences.getInstance();
      final String? id = prefs.getString('id');
      var body = {"id": id};
      http.Response postdata =
          await http.post(Uri.parse("${baseurl}get_latest_asset"), body: body);
      var data = json.decode(postdata.body);
      for (int i = 0; i < data["data"].length; i++) {
        list_cb_data.add(ComboBoxData(data["data"][i]["date"],
            data["data"][i]["value"].toString(), data["data"][i]["product"]));
      }
      list_cb_data.sort(((a, b) => a.product.compareTo(b.product)));
      for (int i = 0; i < list_cb_data.length; i++) {
        combobox.add(list_cb_data[i].product);
      }
      selectedpilihan.value = list_cb_data[0].product;
      ShowResultUnperform().showcb();
    } catch (e) {
      Get.snackbar("error", e.toString(), backgroundColor: errwithopacity);
    }
  }

  void calculate() {
    var kurs_ = double.parse(kurs.value.text.toString());
    var floatingLoss = double.parse(floss.value.text.toString());
    var uangInvestAwal = double.parse(mi.value.text.toString());
    var hargaSaatIni = double.parse(prn.value.text.toString());
    var unitDimiliki = double.parse(aih.value.text.toString());
    var desiredLoss = double.parse(dl.value.text.toString());
    var assetSwitchNow = double.parse(tais.value.text.toString());
    var returnSwitchPercent = double.parse(rsia.value.text.toString());
    var floatingLossInPercent =
        (floatingLoss * kurs_ / (uangInvestAwal * kurs_)) * 100;
    var assetAkhir = (100 / desiredLoss) * (kurs_ * floatingLoss);
    var uangHarusDiinvest = assetAkhir - (uangInvestAwal * kurs_);
    var hargabep = (assetAkhir /
            (unitDimiliki + (uangHarusDiinvest / (hargaSaatIni * kurs_)))) /
        kurs_;
    var upPercent = ((hargabep - hargaSaatIni) / hargaSaatIni) * 100;
    var returnPerhariSwitchMoney =
        (assetSwitchNow + (kurs_ * (uangInvestAwal - floatingLoss))) *
            (returnSwitchPercent / 100);
    var estimatedDay = (floatingLoss * kurs_) / returnPerhariSwitchMoney;
    var estimatedMonth = estimatedDay / 30;
    Get.to(HasilSimulasiPorto(
        uangInvestAwal * kurs_,
        floatingLoss * kurs_,
        floatingLossInPercent,
        desiredLoss,
        assetSwitchNow,
        returnSwitchPercent,
        uangHarusDiinvest,
        estimatedDay,
        estimatedMonth,
        hargabep,
        upPercent,
        hargaSaatIni));
  }

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

  logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('uname');
    await prefs.remove('pass');
    await prefs.remove('id');
    Get.offAll(Login());
  }

  showAlertDialogModern(var action, String tittle, String msg) {
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
      title: Text(tittle),
      content: Text(msg),
      actions: [
        cancelButton,
        continueButton,
      ],
    ));
  }

  Future updateStockData() async {
    if (startdateNew.value == "choose date" ||
        enddateNew.value == "choose date") {
      Get.snackbar("warning", "choose date first !",
          backgroundColor: warnwithopacity);
      return;
    } else if (valuesNew.value.text == "") {
      Get.snackbar("warning", "fill global stock code !",
          backgroundColor: warnwithopacity);
      return;
    } else if (filenameNew.value.text == "") {
      Get.snackbar("warning", "fill filename !",
          backgroundColor: warnwithopacity);
      return;
    }
    try {
      // example
      // https://dafageraldine.pythonanywhere.com/update_stock?jenis=us&kode=GOOG&saveas=GOOG&start=2018-01-01&end=2023-05-29
      http.Response getdata = await http.get(Uri.parse(
          "${baseurl}update_stock?jenis=${selectedStockTypeNew.value}&kode=${valuesNew.value.text}&saveas=${filenameNew.value.text}&start=${startdateNew.value}&end=${enddateNew.value}"));
      // print(
      //     "${baseurl}update_stock?jenis=${selectedStockType.value}&kode=${values.value.text}&saveas=${filename.value.text}&start=${startdate.value}&end=${enddate.value}");
      var data = json.decode(getdata.body);
      if (data['message'] == "success") {
        Get.snackbar("success", "data for ${valuesNew.value.text} updated !",
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

  datepickNew(String jenis) {
    showDatePicker(
            context: Get.context!,
            initialDate: DateTime.now(),
            firstDate: DateTime(2010),
            lastDate: DateTime(2100))
        .then((date) {
      if (jenis == "start") {
        startdateNew.value = DateFormat('yyyy-MM-dd').format(date!);
      } else {
        enddateNew.value = DateFormat('yyyy-MM-dd').format(date!);
      }
    });
  }

  Future<String> calculatetarget() async {
    await getavgsaving();
    double avgPerDayParsed =
        double.parse(avgPerDay.value.replaceAll(RegExp(r'[^0-9.]'), ''));
    var day = ((double.parse(valuescal.value.text.replaceAll(",", "")) -
                double.parse(stfrom.value.text.replaceAll(",", ""))) /
            avgPerDayParsed)
        .ceil();
    if (day > 29) {
      var month = (day / 30).ceil();
      if ((month * 30) < day) {
        var sisa = day - (month * 30);
        return "$month bulan $sisa hari";
      } else {
        return "$month bulan";
      }
    }
    return "$day hari";
  }

  Future<void> getresult() async {
    isLoadingCal.value = true;
    var result = await calculatetarget();
    isLoadingCal.value = false;
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

  void fill_chart() {
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
}
