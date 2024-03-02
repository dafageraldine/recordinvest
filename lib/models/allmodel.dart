import 'package:flutter/material.dart';

class WatchlistData {
  String name;
  String code;
  String jenis;
  String start;
  String url;
  WatchlistData(this.name, this.code, this.jenis, this.start, this.url);
}

class AnalyzeDataModel {
  List<AnalyzeData> data;

  AnalyzeDataModel({required this.data});

  factory AnalyzeDataModel.fromJson(Map<String, dynamic> json) {
    var dataList = json['data'] as List;
    List<AnalyzeData> datalist =
        dataList.map((data) => AnalyzeData.fromJson(data)).toList();

    return AnalyzeDataModel(data: datalist);
  }
}

class AnalyzeData {
  double biggestLost;
  double biggestProfit;
  double estimatedReturn;
  String estimatedReturnInMoney;
  String exampleMoneyInvested;
  int lost;
  String maCompared;
  double probability;
  int profit;

  AnalyzeData({
    required this.biggestLost,
    required this.biggestProfit,
    required this.estimatedReturn,
    required this.estimatedReturnInMoney,
    required this.exampleMoneyInvested,
    required this.lost,
    required this.maCompared,
    required this.probability,
    required this.profit,
  });

  factory AnalyzeData.fromJson(Map<String, dynamic> json) {
    return AnalyzeData(
      biggestLost: json['biggest_lost'],
      biggestProfit: json['biggest_profit'],
      estimatedReturn: json['estimated_return'],
      estimatedReturnInMoney: json['estimated_return_in_money'],
      exampleMoneyInvested: json['example_money_invested'],
      lost: json['lost'],
      maCompared: json['ma_compared'],
      probability: json['probability'],
      profit: json['profit'],
    );
  }
}

class AvgSavingModel {
  final String avgPerDay;
  final String avgSavingPerMonth;
  final String saldoAkhir;
  final String saldoAwal;
  final String tglAkhir;
  final String tglAwal;

  AvgSavingModel({
    required this.avgPerDay,
    required this.avgSavingPerMonth,
    required this.saldoAkhir,
    required this.saldoAwal,
    required this.tglAkhir,
    required this.tglAwal,
  });

  factory AvgSavingModel.fromJson(Map<String, dynamic> json) {
    return AvgSavingModel(
      avgPerDay: json['avgperday'],
      avgSavingPerMonth: json['avgsavingpermonth'],
      saldoAkhir: json['saldoakhir'],
      saldoAwal: json['saldoawal'],
      tglAkhir: json['tglakhir'],
      tglAwal: json['tglawal'],
    );
  }
}

class ComboBoxData {
  String date;
  String product;
  String value;
  ComboBoxData(this.date, this.value, this.product);
}

class NotifModel {
  String title;
  String msg;
  String date;
  String keys;
  NotifModel(this.title, this.msg, this.date, this.keys);
}

class Pilihan {
  String Nmtype;
  Pilihan(this.Nmtype);
}

class RecordData {
  String date;
  String value;
  String type;
  String product;
  RecordData(this.date, this.value, this.type, this.product);
}

class ResultAnalyzeDetailModel {
  List<ResultAnalyzeDetail> data;

  ResultAnalyzeDetailModel({required this.data});

  factory ResultAnalyzeDetailModel.fromJson(Map<String, dynamic> json) {
    var dataList = json['data'] as List;
    List<ResultAnalyzeDetail> datalist =
        dataList.map((data) => ResultAnalyzeDetail.fromJson(data)).toList();

    return ResultAnalyzeDetailModel(data: datalist);
  }
}

class ResultAnalyzeDetail {
  String action;
  double close;
  String date;

  ResultAnalyzeDetail({
    required this.action,
    required this.close,
    required this.date,
  });

  factory ResultAnalyzeDetail.fromJson(Map<String, dynamic> json) {
    return ResultAnalyzeDetail(
      action: json['action'],
      close: json['close'],
      date: json['date'],
    );
  }
}

class StockData {
  List<Stock> data;

  StockData({required this.data});

  factory StockData.fromJson(Map<String, dynamic> json) {
    var stockList = json['data'] as List;
    List<Stock> stocks =
        stockList.map((stock) => Stock.fromJson(stock)).toList();

    return StockData(data: stocks);
  }
}

class Stock {
  String code;
  String name;

  Stock({required this.code, required this.name});

  factory Stock.fromJson(Map<String, dynamic> json) {
    return Stock(
      code: json['code'],
      name: json['name'],
    );
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
