import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:recordinvest/components/app_bar_with_back_button.dart';

class HasilSimulasiPorto extends StatelessWidget {
  final double invest_total;
  final double floss;
  // ignore: non_constant_identifier_names
  final double floss_percent;
  final double desired_loss;
  final double asset_switch;
  final double return_sitch;
  final double money_reinvest;
  final double estimated_day;
  final double estimated_month;
  final double hargabep;
  final double up_percent;
  final double prn;
  const HasilSimulasiPorto(
      this.invest_total,
      this.floss,
      this.floss_percent,
      this.desired_loss,
      this.asset_switch,
      this.return_sitch,
      this.money_reinvest,
      this.estimated_day,
      this.estimated_month,
      this.hargabep,
      this.up_percent,
      this.prn,
      {super.key});

  @override
  Widget build(BuildContext context) {
    final oCcy = NumberFormat.currency(
        locale: 'eu',
        customPattern: '#,### \u00a4',
        symbol: "",
        decimalDigits: 2);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(children: [
        AppBarWithBackButton(
          titleBar: "Simulation Result",
          onTap: () {
            Get.back();
          },
        ),
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
                  text:
                      "Anda telah invest sebesar\nRp ${oCcy.format(invest_total)}\n\n",
                  style: const TextStyle(color: Colors.black),
                ),
                TextSpan(
                  text:
                      "dan mengalami floating loss sebesar\nRp ${oCcy.format(floss)} ( ${oCcy.format(floss_percent)} %)\n\n",
                  style: const TextStyle(color: Colors.black),
                ),
                TextSpan(
                  text:
                      "dan berharap agar meminimalkan kerugian hingga\n${oCcy.format(desired_loss)} % \n\n",
                  style: const TextStyle(color: Colors.black),
                ),
                TextSpan(
                  text:
                      "Atau Switch ke Produk Asuransi lain dengan asset saat ini sebesar Rp ${oCcy.format(asset_switch)} dan return perhari $return_sitch%\n\n",
                  style: const TextStyle(color: Colors.black),
                ),
                TextSpan(
                  text:
                      "Maka jika anda memilih invest ulang ke produk yang sedang turun, uang yang dibutuhkan adalah sebesar \nRp ${oCcy.format(money_reinvest)}(beli ${(money_reinvest / prn).toStringAsFixed(3)} unit (${((money_reinvest / prn) / 100).ceil()} lot)) agar floating loss menjadi $desired_loss %\n\ndan berharap harga naik ke ${oCcy.format(hargabep)}(${up_percent.toStringAsFixed(2)} %) agar BEP\n\n"
                  // +
                  // " tahun adalah :\n "
                  ,
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 15),
                ),
                TextSpan(
                  text:
                      "atau jual rugi dan pindahkan ke produk switch dengan estimasi menunggu selama ${estimated_month.toStringAsFixed(2)} bulan(${estimated_day.toStringAsFixed(2)} hari) hingga BEP"
                  //     " / bulan"
                  ,
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
