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
