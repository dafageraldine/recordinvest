import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recordinvest/components/app_bar_with_back_button.dart';

import '../../controller/calculatetargetcontroller.dart';

class ResultTarget extends StatelessWidget {
  var result;
  ResultTarget({super.key, required this.result});
  final CalculateTargetController _calculateTargetController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        AppBarWithBackButton(
          titleBar: "Result Calculate Target",
          onTap: () {
            Get.back();
          },
        ),
        Padding(
          padding: EdgeInsets.only(top: 0.02.sh, left: 0.1.sw),
          child: const Text(
            "Target",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Color.fromRGBO(157, 157, 157, 1),
              fontSize: 16,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 0.02.sh, left: 0.1.sw),
          child: Container(
            width: 0.8.sw,
            height: 0.08.sh,
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
            child: Center(
              child: Text(
                  'Rp ${_calculateTargetController.formatter
                          .format(double.parse(
                              _calculateTargetController.values.value.text))
                          .substring(2)}',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                    color: const Color.fromRGBO(249, 249, 249, 1),
                  )),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 0.02.sh, left: 0.1.sw),
          child: SizedBox(
            width: 0.8.sw,
            child: Text(
              "Berdasarkan rata-rata menabungmu dari tanggal ${_calculateTargetController.tglawal.value} hingga ${_calculateTargetController.tglakhir.value} adalah , ${_calculateTargetController.avgPerDay.value} perhari dan ${_calculateTargetController.avgsavingpermonth.value} perbulan serta saldo saat ini sebesar Rp ${_calculateTargetController.formatter.format(double.parse(_calculateTargetController.stfrom.value.text)).substring(2)}. Maka target sebesar Rp ${_calculateTargetController.formatter.format(double.parse(_calculateTargetController.values.value.text)).substring(2)} akan tercapai dengan waktu $result",
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Color.fromRGBO(157, 157, 157, 1),
                fontSize: 14,
              ),
              textAlign: TextAlign.justify,
            ),
          ),
        ),
      ]),
    );
  }
}
