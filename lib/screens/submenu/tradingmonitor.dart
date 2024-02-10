import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recordinvest/controller/homecontroller.dart';
import 'package:recordinvest/models/data.dart';
import 'package:recordinvest/screens/submenu/addwishlist.dart';

import '../../components/app_bar_with_back_button.dart';

class TradingMonitor extends StatelessWidget {
  TradingMonitor({super.key});
  final HomeController _homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppBarWithBackButton(
            titleBar: "Trading Monitor",
            onTap: () {
              Get.back();
            },
          ),
          SizedBox(
            height: 0.025.sh,
          ),
          togglebtn(),
          SizedBox(
            height: 0.01.sh,
          ),
          Obx(() => _homeController.selectedIndex.value == 0
              ? watchlist()
              : const SizedBox())
        ],
      ),
    );
  }

  Widget watchlist() {
    return SizedBox(
        width: 1.sw,
        height: 0.77.sh,
        child: Stack(
          children: [
            SizedBox(
                width: 1.sw,
                height: 0.77.sh,
                child: ListView.builder(
                  itemBuilder: (c, i) {
                    return Padding(
                      padding: EdgeInsets.only(
                          left: (0.15.sw / 2), right: (0.15.sw / 2), top: 10),
                      child: Container(
                        width: 0.85.sw,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                width: 1, color: Colors.grey.shade500)),
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 15.0, right: 15, bottom: 0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        _homeController
                                            .editwL(_homeController.wlData[i]);
                                      },
                                      child: Container(
                                          width: 0.09.sw,
                                          height: 0.09.sw,
                                          decoration: BoxDecoration(
                                              color: sucs,
                                              shape: BoxShape.circle),
                                          child: Icon(
                                            Icons.edit,
                                            size: 16.sp,
                                            color: Colors.white,
                                          )),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        _homeController.showAlertDialog(
                                            () async {
                                          _homeController.deleteWlList(
                                              _homeController.wlData[i]);
                                          Get.back();
                                        }, "Konfirmasi Hapus",
                                            "Apakah anda ingin hapus watchlist");
                                      },
                                      child: Container(
                                          width: 0.09.sw,
                                          height: 0.09.sw,
                                          decoration: BoxDecoration(
                                              color: err,
                                              shape: BoxShape.circle),
                                          child: Icon(
                                            Icons.delete,
                                            size: 16.sp,
                                            color: Colors.white,
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: 8,
                              height: 0.085.sh,
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade700,
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(2),
                                      bottomLeft: Radius.circular(2))),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 10.0, left: 20, bottom: 0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(_homeController.wlData[i].name,
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14.sp,
                                        )),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                        "period start ${_homeController.wlData[i].start}",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.normal,
                                          color: Colors.grey.shade500,
                                          fontSize: 10.sp,
                                        ))
                                  ]),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: _homeController.wlData.length,
                  physics: const BouncingScrollPhysics(),
                )),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: InkWell(
                  onTap: () {
                    _homeController.clearWl();
                    Get.to(Addwatchlist());
                  },
                  child: Container(
                    width: 0.15.sw,
                    height: 0.15.sw,
                    decoration: BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(8)),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  Widget togglebtn() {
    return Center(
      child: Obx(() => ToggleButtons(
            constraints: BoxConstraints(minWidth: 100, minHeight: 40),
            selectedBorderColor: Colors.teal.shade300,
            fillColor: Colors.teal.shade50,
            selectedColor: Colors.teal.shade700,
            color: Colors.grey.shade600,
            borderColor: Colors.grey.shade500,
            borderRadius: BorderRadius.circular(10),
            isSelected: _homeController.selectedTradingMonitor,
            onPressed: (index) {
              for (var i = 0;
                  i < _homeController.selectedTradingMonitor.length;
                  i++) {
                if (i == index) {
                  _homeController.selectedTradingMonitor[index] = true;
                } else {
                  _homeController.selectedTradingMonitor[i] = false;
                }
              }
              _homeController.selectedIndex.value = index;
            },
            children: [
              SizedBox(
                width: 0.85.sw / 2,
                child: Center(
                    child: Text("Watchlist",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 12.sp,
                        ))),
              ),
              SizedBox(
                width: 0.85.sw / 2,
                child: Center(
                    child: Text("Active trading",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 12.sp,
                        ))),
              )
            ],
          )),
    );
  }
}
