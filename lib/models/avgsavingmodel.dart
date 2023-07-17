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
