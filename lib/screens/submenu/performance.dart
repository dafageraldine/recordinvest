import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:recordinvest/components/processbutton.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../components/app_bar_with_back_button_and_icon.dart';
import '../../../models/data.dart';
import '../../controller/homecontroller.dart';
import '../../models/allmodel.dart';

class Performance extends StatelessWidget {
  Performance({super.key});

  final HomeController _homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: Obx(
        () => Column(children: [
          AppBarWithBackButtonAndIconButton(
            titleBar: 'Portofolio Performance',
            onTap: () {
              Get.back();
            },
            onTapIcon: () {
              _homeController.showDialogfilter("filter", "filter");
            },
          ),
          _homeController.performance_chart_data.isEmpty
              ? Container()
              : Padding(
                  padding: EdgeInsets.only(top: 0.02.sh, bottom: 0.02.sh),
                  child: Column(
                    children: [
                      Container(
                        width: 0.9.sw,
                        height: 0.35.sh,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                  blurRadius: 5.0,
                                  color: Colors.black12,
                                  spreadRadius: 5.0,
                                  offset: Offset(0, 2))
                            ]),
                        child: Center(
                          child: SfCartesianChart(
                              primaryXAxis: CategoryAxis(),

                              // Chart title
                              title: ChartTitle(text: 'Portofolio Data'),
                              // Enable legend
                              // legend: Legend(isVisible: true),
                              // Enable tooltip
                              margin: const EdgeInsets.all(25),
                              tooltipBehavior: TooltipBehavior(enable: true),
                              series: <ChartSeries>[
                                LineSeries<PerformanceChartData, String>(
                                  dataSource:
                                      _homeController.performance_chart_data,
                                  color: theme,
                                  width: 3,
                                  xValueMapper: (PerformanceChartData pcd, _) =>
                                      pcd.day,
                                  yValueMapper: (PerformanceChartData pcd, _) =>
                                      pcd.money,
                                  name: 'money',
                                  enableTooltip: true,
                                  onPointTap: (pointInteractionDetails) {
                                    _homeController.df.value = _homeController
                                        .performance_chart_data[
                                            pointInteractionDetails.pointIndex!]
                                        .day;
                                    _homeController.getrecord();
                                  },
                                  // Enable data label
                                  // dataLabelSettings: DataLabelSettings(isVisible: true)
                                )
                              ]),
                        ),
                      ),
                    ],
                  ),
                ),
          _homeController.chartData.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Container(
                    width: 0.85.sw,
                    height: 0.125.sh,
                    decoration: BoxDecoration(
                        // color: Color.fromRGBO(250, 244, 183, 1),
                        color: const Color.fromRGBO(157, 157, 157, 1),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
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
                              padding:
                                  EdgeInsets.only(top: 0.02.sh, left: 0.1.sw),
                              child: const Text(
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
                              padding: EdgeInsets.only(left: 0.1.sw),
                              child: Text(
                                "Rp ${_homeController.oCcy.format(_homeController.total.value)}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  // color: Color.fromRGBO(157, 157, 157, 1),
                                  // color: Color.fromRGBO(144, 200, 172, 1),
                                  color: Color.fromRGBO(249, 249, 249, 1),
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.only(top: 0.01.sh, left: 0.1.sw),
                              child: Text(
                                _homeController.df.value,
                                style: const TextStyle(
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
          _homeController.chartData.isNotEmpty
              ? Padding(
                  padding: EdgeInsets.only(left: 0.1.sw, top: 0.02.sh),
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
          const SizedBox(
            height: 10,
          ),
          _homeController.chartData.isNotEmpty
              ? Padding(
                  padding: EdgeInsets.only(left: 0.1.sw),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      onTap: () {
                        _homeController.fill_chart();

                        // print(chartData[i].x + " " + chartData[i].y.toString() + " ");
                      },
                      child: Container(
                        width: 0.2.sw,
                        height: 0.04.sh,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: theme,
                        ),
                        child: const Center(
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
          _homeController.chartData.isNotEmpty
              ? Container(
                  child: SfCircularChart(
                      legend: Legend(
                          isVisible: true,
                          position: LegendPosition.bottom,
                          overflowMode: LegendItemOverflowMode.wrap),
                      series: <CircularSeries>[
                      // Render pie chart
                      PieSeries<ChartData, String>(
                          dataSource: _homeController.chartData,
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
                    padding: const EdgeInsets.only(top: 5),
                    child: Container(
                      width: 0.85.sw,
                      height: 0.1.sh,
                      decoration: BoxDecoration(
                          color: _homeController.chartData[index].color,
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: EdgeInsets.only(left: 0.1.sw, top: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _homeController.chartData[index].x,
                              style: const TextStyle(
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                                // color: Color.fromRGBO(157, 157, 157, 1),
                                // color: Color.fromRGBO(144, 200, 172, 1),
                                // color: Color.fromRGBO(157, 157, 157, 1),
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              "Rp ${_homeController.oCcy.format(_homeController.chartData[index].y)}",
                              style: const TextStyle(
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
            itemCount: _homeController.chartData.isEmpty
                ? 0
                : _homeController.chartData.length,
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
          ),
          _homeController.chartData.isNotEmpty
              ? Padding(
                  padding: EdgeInsets.only(left: 0.1.sw, top: 0.02.sh),
                  child: const Align(
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
                    padding: const EdgeInsets.only(top: 5),
                    child: Container(
                      width: 0.85.sw,
                      height: 0.15.sh,
                      decoration: BoxDecoration(
                          color: theme,
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: EdgeInsets.only(left: 0.1.sw, top: 20),
                        child: Stack(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _homeController.listrecord[index].product,
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
                                  _homeController.listrecord[index].type,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    // color: Color.fromRGBO(157, 157, 157, 1),
                                    // color: Color.fromRGBO(144, 200, 172, 1),
                                    color: Color.fromRGBO(249, 249, 249, 1),
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  "Rp ${_homeController.oCcy.format(double.parse(_homeController.listrecord[index].value))}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w800,
                                    // color: Color.fromRGBO(157, 157, 157, 1),
                                    // color: Color.fromRGBO(144, 200, 172, 1),
                                    color: Colors.blueGrey,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  _homeController.listrecord[index].date,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    // color: Color.fromRGBO(157, 157, 157, 1),
                                    // color: Color.fromRGBO(144, 200, 172, 1),
                                    color: Color.fromRGBO(249, 249, 249, 1),
                                    fontSize: 16,
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 5.0, right: 5),
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: InkWell(
                                  onTap: () async {
                                    _homeController.showAlertDialogModern(
                                        () async {
                                      await _homeController.deleteRecord(
                                          _homeController.listrecord[index]);
                                    }, "Information",
                                        "Do you want to delete data ${_homeController.listrecord[index].product} ?");
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: const Color.fromRGBO(
                                            249, 249, 249, 1),
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: const [
                                          BoxShadow(
                                              blurRadius: 5.0,
                                              color: Colors.black12,
                                              spreadRadius: 2.0,
                                              offset: Offset(0, 2))
                                        ]),
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        "Delete",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          color:
                                              Color.fromRGBO(144, 200, 172, 1),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
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
            itemCount: _homeController.listrecord.isEmpty
                ? 0
                : _homeController.listrecord.length,
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
          ),
          const SizedBox(
            height: 20,
          )
        ]),
      )),
    );
  }
}
