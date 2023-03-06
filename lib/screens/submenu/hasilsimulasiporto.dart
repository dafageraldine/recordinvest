import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';

class HasilSimulasiPorto extends StatefulWidget {
  // ignore: non_constant_identifier_names
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
  State<HasilSimulasiPorto> createState() => _HasilSimulasiPortoState();
}

class _HasilSimulasiPortoState extends State<HasilSimulasiPorto> {
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
                      "Simulation Result",
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
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: RichText(
              textAlign: TextAlign.justify,
              text: TextSpan(children: <TextSpan>[
                TextSpan(
                    text:
                        "Berdasarkan data yang anda masukkan, berikut adalah hasil simulasinya : \n\n",
                    style: TextStyle(color: Colors.black)),
                TextSpan(
                  text: "Anda telah invest sebesar\nRp " +
                      oCcy.format(widget.invest_total).toString() +
                      "\n\n",
                  style: TextStyle(color: Colors.black),
                ),
                TextSpan(
                  text: "dan mengalami floating loss sebesar\nRp " +
                      oCcy.format(widget.floss).toString() +
                      " ( " +
                      oCcy.format(widget.floss_percent).toString() +
                      " %)"
                          "\n\n",
                  style: TextStyle(color: Colors.black),
                ),
                TextSpan(
                  text: "dan berharap agar meminimalkan kerugian hingga\n" +
                      oCcy.format(widget.desired_loss).toString() +
                      " % \n\n",
                  style: TextStyle(color: Colors.black),
                ),
                TextSpan(
                  text:
                      "Atau Switch ke Produk Asuransi lain dengan asset saat ini sebesar Rp " +
                          oCcy.format(widget.asset_switch).toString() +
                          " dan return perhari " +
                          widget.return_sitch.toString() +
                          "%\n\n",
                  style: TextStyle(color: Colors.black),
                ),
                TextSpan(
                  text:
                      "Maka jika anda memilih invest ulang ke produk yang sedang turun, uang yang dibutuhkan adalah sebesar \nRp " +
                          oCcy.format(widget.money_reinvest).toString() +
                          "(beli " +
                          (widget.money_reinvest / widget.prn)
                              .toStringAsFixed(3) +
                          " unit (" +
                          ((widget.money_reinvest / widget.prn) / 100)
                              .ceil()
                              .toString() +
                          " lot)) agar floating loss menjadi " +
                          widget.desired_loss.toString() +
                          " %\n\ndan berharap harga naik ke " +
                          oCcy.format(widget.hargabep).toString() +
                          "(" +
                          widget.up_percent.toStringAsFixed(2) +
                          " %) agar BEP"
                              "\n\n"
                  // +
                  // " tahun adalah :\n "
                  ,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 15),
                ),
                TextSpan(
                  text:
                      "atau jual rugi dan pindahkan ke produk switch dengan estimasi menunggu selama " +
                          widget.estimated_month.toStringAsFixed(2) +
                          " bulan(" +
                          widget.estimated_day.toStringAsFixed(2) +
                          " hari) hingga BEP"
                  //     " / bulan"
                  ,
                  style: TextStyle(
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
