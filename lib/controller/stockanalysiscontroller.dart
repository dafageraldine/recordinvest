import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:recordinvest/models/analyzedatamodel.dart';
import 'package:recordinvest/screens/submenu/analyzedetail.dart';

import '../models/data.dart';
import '../models/resultanalyzedatadetailmodel.dart';
import '../models/stockmodel.dart';
import '../screens/submenu/resultanalyzedata.dart';

class StockAnalysisController extends GetxController {
  List<String> combStockType = ['indo', 'us'];
  RxString selectedStockType = "indo".obs;
  RxString selectedStockName = "".obs;
  Rx<TextEditingController> values = TextEditingController().obs;
  List<Stock> stockdataindo = <Stock>[];
  List<Stock> stockdataus = <Stock>[];
  RxList<String> combStockName = <String>[].obs;
  RxList<String> combStockUs = <String>[].obs;
  RxList<AnalyzeData> analyzedata = <AnalyzeData>[].obs;
  RxList<ResultAnalyzeDetail> analyzedatadetail = <ResultAnalyzeDetail>[].obs;
  RxBool isLoading = false.obs;
  final oCcy = NumberFormat.currency(
      locale: 'eu',
      customPattern: '#,### \u00a4',
      symbol: "",
      decimalDigits: 2);

  cbStockTypeAction() async {
    if (selectedStockType.value == "indo") {
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
    var stocktype = selectedStockType.value;
    if (stocktype == "us") {
      stockdataus.clear();
    } else {
      stockdataindo.clear();
    }
    http.Response getdata = await http.get(Uri.parse(
        baseurl + "get_list_emiten?jenis=${selectedStockType.value}"));
    Map<String, dynamic> json = jsonDecode(getdata.body);
    StockData stockData = StockData.fromJson(json);
    if (stocktype == "us") {
      for (var stock in stockData.data) {
        stockdataus.add(stock);
      }
      fillcbStockNameUS();
      print(stockdataus.length);
    } else {
      for (var stock in stockData.data) {
        stockdataindo.add(stock);
      }
      fillcbStockName();
      print(stockdataindo.length);
    }
  }

  fillcbStockName() {
    combStockName.clear();
    for (var i = 0; i < stockdataindo.length; i++) {
      combStockName.add(stockdataindo[i].code + " | " + stockdataindo[i].name);
    }
    selectedStockName.value = combStockName[0];
  }

  fillcbStockNameUS() {
    combStockName.clear();
    for (var i = 0; i < stockdataus.length; i++) {
      combStockName.add(stockdataus[i].code + " | " + stockdataus[i].name);
    }
    selectedStockName.value = combStockName[0];
  }

  Future analyzeStock() async {
    analyzedata.clear();
    isLoading.value = true;
    try {
      http.Response getdata = await http.get(Uri.parse(baseurl +
          "analyze?jenis=${selectedStockType.value}&code=${selectedStockName.split("| ")[0].trim()}&money=${values.value.text}"));
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
    http.Response getdata = await http.get(Uri.parse(baseurl +
        "detail_analyze?jenis=${selectedStockType.value}&code=${selectedStockName.split("| ")[0].trim()}&maselected=${ma.replaceAll("&", "_")}"));
    // print(baseurl +
    //     "detail_analyze?jenis=${selectedStockType.value}&code=${selectedStockName.split("| ")[0].trim()}&maselected=${ma.replaceAll("&", "_")}");
    // print(getdata.body);
    Map<String, dynamic> json = jsonDecode(getdata.body);
    ResultAnalyzeDetailModel dataModel =
        ResultAnalyzeDetailModel.fromJson(json);
    for (var data in dataModel.data) {
      analyzedatadetail.add(data);
    }
    Get.to(AnalyzeDetail(
      maSelected: ma,
    ));
  }
}
