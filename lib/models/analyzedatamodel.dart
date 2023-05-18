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
