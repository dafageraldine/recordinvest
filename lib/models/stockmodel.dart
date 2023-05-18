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
