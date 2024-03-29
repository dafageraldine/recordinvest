import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:recordinvest/components/app_bar_with_back_button.dart';

class HasilSimulasi extends StatelessWidget {
  final int hargaotr;
  final double dpmobil;
  final int tenorcicilan;
  final double plafonpinjaman;
  final double angsuranpokok;
  final double angsuranbunga;
  final double angsuranakhir;
  HasilSimulasi(this.plafonpinjaman, this.angsuranpokok, this.angsuranbunga,
      this.angsuranakhir, this.hargaotr, this.dpmobil, this.tenorcicilan,
      {super.key});

  final oCcy = NumberFormat.currency(
      locale: 'eu',
      customPattern: '#,### \u00a4',
      symbol: "",
      decimalDigits: 2);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));
    return Scaffold(
      body: Column(children: [
        AppBarWithBackButton(
            titleBar: "Simulation Result",
            onTap: () {
              Get.back();
            }),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: RichText(
              textAlign: TextAlign.justify,
              text: TextSpan(children: <TextSpan>[
                const TextSpan(
                    text:
                        "Berdasarkan data yang anda masukkan, berikut adalah hasil simulasinya : \n\n",
                    style: TextStyle(color: Colors.black)),
                TextSpan(
                  text: "Harga Mobil Adalah Rp ${oCcy.format(hargaotr)}\n",
                  style: const TextStyle(color: Colors.black),
                ),
                TextSpan(
                  text: "TDP / DP adalah Rp ${oCcy.format(dpmobil)}\n\n",
                  style: const TextStyle(color: Colors.black),
                ),
                TextSpan(
                  text:
                      "Angsuran pokok perbulan adalah Rp ${oCcy.format(angsuranpokok)}\n\n",
                  style: const TextStyle(color: Colors.black),
                ),
                TextSpan(
                  text:
                      "Angsuran bunga perbulan adalah Rp ${oCcy.format(angsuranbunga)}\n\n",
                  style: const TextStyle(color: Colors.black),
                ),
                TextSpan(
                  text:
                      "Maka angsuran perbulan untuk tenor $tenorcicilan tahun adalah :\n ",
                  style: const TextStyle(color: Colors.black),
                ),
                TextSpan(
                  text: "\nRp ${oCcy.format(angsuranakhir)} / bulan",
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 15),
                )
              ])),
        )
      ]),
    );
  }
}
