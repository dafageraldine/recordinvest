import 'dart:convert';
import 'dart:math';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

import '../data.dart';

class Performance extends StatefulWidget {
  const Performance({Key? key}) : super(key: key);

  @override
  State<Performance> createState() => _PerformanceState();
}

class _PerformanceState extends State<Performance> {
  List<ChartData> chartData = [];
  List<String> added = [];
  var total = 0.0;
  var awal = "pick a date";
  final oCcy = NumberFormat.currency(
      locale: 'eu',
      customPattern: '#,### \u00a4',
      symbol: "",
      decimalDigits: 2);

  void _showDialogfilter(judul, konten) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        double sw = MediaQuery.of(context).size.width;
        double sh = MediaQuery.of(context).size.height;
        // return object of type Dialog
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Container(
            width: 0.85 * sw,
            height: 0.3 * sh,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 0.1 * sw, top: 0.03 * sh),
                  child: Align(
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
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 0.1 * sw),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      onTap: () {
                        showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2020),
                                lastDate: DateTime(2100))
                            .then((date) {
                          setState(() {
                            awal = DateFormat('yyyy-MM-dd').format(date!);
                            Navigator.of(context).pop();
                            _showDialogfilter("", "");
                          });
                        });
                      },
                      child: Container(
                        width: sw * 0.5,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          border: Border.all(
                              color: Color.fromRGBO(228, 228, 228, 1),
                              width: 2),
                          color: Colors.white,
                        ),
                        child: Center(
                            child: Text(
                          awal,
                          style: TextStyle(
                              color: Color.fromRGBO(160, 160, 160, 1),
                              fontSize: 14,
                              // fontFamily: 'Inter',
                              fontWeight: FontWeight.w600),
                        )),
                      ),
                    ),
                  ),
                )
                // Container(
                //     width: 0.7*sw,
                //     height: 0.07*sh,
                //     decoration: BoxDecoration(
                //       // color: Colors.grey[600],
                //       borderRadius: BorderRadius.circular(10),
                //     ),
                //     child: DropdownSearch<String>(
                //       popupProps: PopupProps.menu(
                //         itemBuilder: (context, item, isSelected) =>
                //             ListTile(title: Text(item)),
                //         showSearchBox: true,
                //       ),
                //       items: combobox,
                //       dropdownBuilder: (context, item) => Text(item!),
                //       onChanged: (value) => setState(() {
                //         selectedpilihan = value!;
                //       }),
                //       selectedItem: selectedpilihan,
                //     )),
                ,
                SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                    getrecord();
                    // if (dataexist == "2") {
                    //   Fluttertoast.showToast(
                    //       msg: "getting report on process, please wait !",
                    //       backgroundColor: Colors.black,
                    //       textColor: Colors.white);
                    // } else {
                    //   setState(() {
                    //     title_refresh = selectedpilihan;
                    //     dataexist = "2";
                    //   });
                    //   get_report_at_ro(selectedpilihan);
                    // }
                  },
                  child: Container(
                    width: 0.7 * sw,
                    height: 0.07 * sh,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(144, 200, 172, 1),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
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
        );
      },
    );
  }

  Future getrecord() async {
    try {
      listrecord.clear();
      var body = {"date": awal};
      http.Response postdata =
          await http.post(Uri.parse(baseurl + "getrecord"), body: body);
      var data = json.decode(postdata.body);
      print(baseurl + "getrecord");
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
        Fluttertoast.showToast(
            msg: "There are no data for " + awal + " !",
            backgroundColor: Colors.black,
            textColor: Colors.white);
        chartData.clear();
      }
      setState(() {});
    } catch (e) {
      Fluttertoast.showToast(
          msg: e.toString(),
          backgroundColor: Colors.black,
          textColor: Colors.white);
    }
  }

  fill_chart() {
    chartData.clear();
    added.clear();
    total = 0.0;
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
      total = total + chartData[i].y;
      var rng = Random();
      chartData[i].color = Color.fromRGBO(
          rng.nextInt(155), rng.nextInt(200), rng.nextInt(180), 1);
      // print(chartData[i].x + " " + chartData[i].y.toString() + " ");
    }

    for (var i = 0; i < chartData.length; i++) {
      var persen = chartData[i].y / total * 100;
      chartData[i].x = chartData[i].x + " " + persen.toStringAsFixed(2) + "%";
    }

    //   if(listrecord[i].type == listrecord)
    //   var data = double.tryParse(listrecord[i].value.toString());
    //   total = total + data!;
    // print(total);
  }

  @override
  void initState() {
    listrecord.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            width: width,
            height: height * 0.12,
            // color: Color.fromRGBO(217, 215, 241, 1),
            color: Color.fromRGBO(144, 200, 172, 1),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(left: 0.05 * width, top: 0.04 * height),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Portofolio Performance",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          // color: Color.fromRGBO(104, 103, 172, 1),
                          color: Color.fromRGBO(249, 249, 249, 1),
                          // color: Color.fromRGBO(246, 198, 234, 1),
                        ),
                      )),
                ),
                SizedBox(
                  width: width * 0.325,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: InkWell(
                    onTap: () {
                      _showDialogfilter("filter", "filter");
                    },
                    child: Container(
                      width: 0.12 * width,
                      height: 0.12 * width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5)),
                      child: Icon(
                        Icons.filter_list_rounded,
                        size: 20,
                        color: Color.fromRGBO(82, 82, 82, 1),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          chartData.isNotEmpty
              ? Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Container(
                    width: 0.85 * width,
                    height: 0.125 * height,
                    decoration: BoxDecoration(
                        // color: Color.fromRGBO(250, 244, 183, 1),
                        color: Color.fromRGBO(157, 157, 157, 1),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 5.0,
                              color: Colors.black12,
                              spreadRadius: 5.0,
                              offset: Offset(0, 2))
                        ]),
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 0.02 * height, left: 0.1 * width),
                              child: Text(
                                "Saldo",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  // color: Color.fromRGBO(157, 157, 157, 1),
                                  // color: Color.fromRGBO(144, 200, 172, 1),
                                  color: Color.fromRGBO(249, 249, 249, 1),
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 0.1 * width),
                              child: Text(
                                "Rp " + oCcy.format(total),
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  // color: Color.fromRGBO(157, 157, 157, 1),
                                  // color: Color.fromRGBO(144, 200, 172, 1),
                                  color: Color.fromRGBO(249, 249, 249, 1),
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 0.01 * height, left: 0.1 * width),
                              child: Text(
                                awal,
                                style: TextStyle(
                                  // color: Color.fromRGBO(157, 157, 157, 1),
                                  // color: Color.fromRGBO(144, 200, 172, 1),
                                  color: Color.fromRGBO(249, 249, 249, 1),
                                  fontWeight: FontWeight.w800,
                                  fontSize: 12,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              : Container(),
          chartData.isNotEmpty
              ? Padding(
                  padding:
                      EdgeInsets.only(left: width * 0.1, top: height * 0.02),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Portofolio Allocation",
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          color: Colors.grey[800],
                          // color: Color.fromRGBO(157, 157, 157, 1),
                          // color: Color.fromRGBO(144, 200, 172, 1),
                          // color: Color.fromRGBO(157, 157, 157, 1),
                          fontSize: 16,
                        ),
                      )),
                )
              : Container(),
          SizedBox(
            height: 10,
          ),
          chartData.isNotEmpty
              ? Padding(
                  padding: EdgeInsets.only(left: width * 0.1),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      onTap: () {
                        for (var i = 0; i < chartData.length; i++) {
                          var rng = Random();
                          chartData[i].color = Color.fromRGBO(rng.nextInt(155),
                              rng.nextInt(200), rng.nextInt(180), 1);
                          // print(chartData[i].x + " " + chartData[i].y.toString() + " ");
                        }
                        setState(() {});
                      },
                      child: Container(
                        width: width * 0.2,
                        height: height * 0.04,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color.fromRGBO(144, 200, 172, 1),
                        ),
                        child: Center(
                            child: Text(
                          "Recolouring",
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            // color: Color.fromRGBO(157, 157, 157, 1),
                            // color: Color.fromRGBO(144, 200, 172, 1),
                            // color: Color.fromRGBO(157, 157, 157, 1),
                            fontSize: 12,
                          ),
                        )),
                      ),
                    ),
                  ),
                )
              : Container(),
          chartData.isNotEmpty
              ? Container(
                  child: SfCircularChart(
                      legend: Legend(
                          isVisible: true,
                          position: LegendPosition.bottom,
                          overflowMode: LegendItemOverflowMode.wrap),
                      series: <CircularSeries>[
                      // Render pie chart
                      PieSeries<ChartData, String>(
                          dataSource: chartData,
                          pointColorMapper: (ChartData data, _) => data.color,
                          xValueMapper: (ChartData data, _) => data.x,
                          yValueMapper: (ChartData data, _) => data.y)
                    ]))
              : Container(),
          ListView.builder(
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Container(
                      width: width * 0.85,
                      height: 0.1 * height,
                      decoration: BoxDecoration(
                          color: chartData[index].color,
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: EdgeInsets.only(left: width * 0.1, top: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              chartData[index].x,
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                                // color: Color.fromRGBO(157, 157, 157, 1),
                                // color: Color.fromRGBO(144, 200, 172, 1),
                                // color: Color.fromRGBO(157, 157, 157, 1),
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              "Rp " + oCcy.format(chartData[index].y),
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                // color: Color.fromRGBO(157, 157, 157, 1),
                                // color: Color.fromRGBO(144, 200, 172, 1),
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
            itemCount: chartData.isEmpty ? 0 : chartData.length,
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
          ),
          chartData.isNotEmpty
              ? Padding(
                  padding:
                      EdgeInsets.only(left: width * 0.1, top: height * 0.02),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Portofolio Detail",
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          color: Colors.blueGrey,
                          // color: Color.fromRGBO(157, 157, 157, 1),
                          // color: Color.fromRGBO(144, 200, 172, 1),
                          // color: Color.fromRGBO(157, 157, 157, 1),
                          fontSize: 16,
                        ),
                      )),
                )
              : Container(),
          ListView.builder(
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Container(
                      width: width * 0.85,
                      height: 0.15 * height,
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(144, 200, 172, 1),
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: EdgeInsets.only(left: width * 0.1, top: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              listrecord[index].product,
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                color: Colors.grey[800],
                                // color: Color.fromRGBO(157, 157, 157, 1),
                                // color: Color.fromRGBO(144, 200, 172, 1),
                                // color: Color.fromRGBO(157, 157, 157, 1),
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              listrecord[index].type,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                // color: Color.fromRGBO(157, 157, 157, 1),
                                // color: Color.fromRGBO(144, 200, 172, 1),
                                color: Color.fromRGBO(249, 249, 249, 1),
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              "Rp " +
                                  oCcy.format(
                                      double.parse(listrecord[index].value)),
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                // color: Color.fromRGBO(157, 157, 157, 1),
                                // color: Color.fromRGBO(144, 200, 172, 1),
                                color: Colors.blueGrey,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              listrecord[index].date,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                // color: Color.fromRGBO(157, 157, 157, 1),
                                // color: Color.fromRGBO(144, 200, 172, 1),
                                color: Color.fromRGBO(249, 249, 249, 1),
                                fontSize: 16,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
            itemCount: listrecord.isEmpty ? 0 : listrecord.length,
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
          ),
          SizedBox(
            height: 20,
          )
        ]),
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, this.color);
  String x;
  double y;
  Color color;
}
