import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HasilSimulasi extends StatefulWidget {
  final int hargaotr;
  final double dpmobil;
  final int tenorcicilan;
  final int bungacicilan;
  final double plafonpinjaman;
  final double angsuranpokok;
  final double angsuranbunga;
  final double angsuranakhir;
  const HasilSimulasi(
      this.plafonpinjaman,
      this.angsuranpokok,
      this.angsuranbunga,
      this.angsuranakhir,
      this.hargaotr,
      this.dpmobil,
      this.tenorcicilan,
      this.bungacicilan,
      {super.key});

  @override
  State<HasilSimulasi> createState() => _HasilSimulasiState();
}

class _HasilSimulasiState extends State<HasilSimulasi> {
  final oCcy = NumberFormat.currency(
      locale: 'eu',
      customPattern: '#,### \u00a4',
      symbol: "",
      decimalDigits: 2);
  @override
  Widget build(BuildContext context) {
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
                  text: "Harga Mobil Adalah Rp " +
                      oCcy.format(widget.hargaotr).toString() +
                      "\n",
                  style: TextStyle(color: Colors.black),
                ),
                TextSpan(
                  text: "TDP / DP adalah Rp " +
                      oCcy.format(widget.dpmobil).toString() +
                      "\n\n",
                  style: TextStyle(color: Colors.black),
                ),
                TextSpan(
                  text: "Maka angsuran perbulan untuk tenor " +
                      widget.tenorcicilan.toString() +
                      " tahun adalah :\n ",
                  style: TextStyle(color: Colors.black),
                ),
                TextSpan(
                  text: "\nRp " +
                      oCcy.format(widget.angsuranakhir).toString() +
                      " / bulan",
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
