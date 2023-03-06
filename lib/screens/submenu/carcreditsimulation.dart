import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:recordinvest/models/data.dart';
import 'package:recordinvest/screens/submenu/hasilsimulasi.dart';
import 'package:recordinvest/viewmodels/home/homeviewmodel.dart';

import '../../../components/app_bar_with_back_button.dart';

class CarCreditSimulation extends StatefulWidget {
  const CarCreditSimulation({super.key});

  @override
  State<CarCreditSimulation> createState() => _CarCreditSimulationState();
}

class _CarCreditSimulationState extends State<CarCreditSimulation> {
  TextEditingController bunga = TextEditingController();
  TextEditingController tenor = TextEditingController();
  TextEditingController otr = TextEditingController();
  TextEditingController dp = TextEditingController();
  var finalplafonpinjaman = 0.0,
      finalangsuranpokok = 0.0,
      finalangsuranbunga = 0.0,
      finalangsuranakhir = 0.0;
  var usesaldoglobal = 0;

  void calculate() {
    try {
      var hargaotr = int.tryParse(otr.text);
      var dpmobil = double.tryParse(dp.text)!;
      var tenorcicilan = int.tryParse(tenor.text);
      var bungacicilan = int.tryParse(bunga.text);
      var plafonpinjaman = hargaotr! - dpmobil;
      var angsuranpokok = plafonpinjaman / (tenorcicilan! * 12);
      var angsuranbunga = (plafonpinjaman * (bungacicilan! / 100)) / 12;
      var angsuranakhir = angsuranpokok + angsuranbunga;

      finalplafonpinjaman = plafonpinjaman.toDouble();
      finalangsuranpokok = angsuranpokok;
      finalangsuranbunga = angsuranbunga;
      finalangsuranakhir = angsuranakhir;
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => HasilSimulasi(
                  finalplafonpinjaman,
                  finalangsuranpokok,
                  finalangsuranbunga,
                  finalangsuranakhir,
                  hargaotr,
                  dpmobil,
                  tenorcicilan,
                  bungacicilan)));
    } catch (e) {
      Fluttertoast.showToast(
          msg: "masukkan data yang valid !",
          backgroundColor: Colors.black,
          textColor: Colors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          AppBarWithBackButton(
              titleBar: "Car Credit Simulation",
              onTap: () {
                Navigator.pop(context);
              }),
          SizedBox(
            height: 0.025 * height,
          ),
          Padding(
            padding: EdgeInsets.only(top: 0.02 * height, left: 0.1 * width),
            child: Text(
              "Harga Mobil",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Color.fromRGBO(157, 157, 157, 1),
                fontSize: 16,
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(top: 0.02 * height, left: 0.1 * width),
              child: Container(
                width: 0.85 * width,
                height: 0.07 * height,
                child: TextFormField(
                    controller: otr,
                    // obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(157, 157, 157, 0.5),
                          fontSize: 16,
                        ),
                        hintText: "110000000")),
              )),
          Padding(
            padding: EdgeInsets.only(top: 0.02 * height, left: 0.1 * width),
            child: Text(
              "TDP/DP",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Color.fromRGBO(157, 157, 157, 1),
                fontSize: 16,
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(top: 0.02 * height, left: 0.1 * width),
              child: Row(
                children: [
                  Container(
                    width: 0.5 * width,
                    height: 0.07 * height,
                    child: TextFormField(
                        controller: dp,
                        // obscureText: true,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Color.fromRGBO(157, 157, 157, 0.5),
                              fontSize: 16,
                            ),
                            hintText: "30000000")),
                  ),
                  SizedBox(
                    width: 0.05 * width,
                  ),
                  Consumer<HomeViewModel>(
                    builder: (context, value, child) => InkWell(
                      onTap: () {
                        usesaldoglobal = 1;
                        dp.text = saldoglobal.toString();
                        // inserttypenproduct();
                      },
                      child: Container(
                        width: width * 0.3,
                        height: height * 0.07,
                        // color: Color.fromRGBO(217, 215, 241, 1),
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(249, 249, 249, 1),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 5.0,
                                  color: Colors.black12,
                                  spreadRadius: 2.0,
                                  offset: Offset(0, 2))
                            ]),
                        child: Center(
                          child: Text(
                            "gunakan saldo\nsaat ini",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              // color: Color.fromRGBO(104, 103, 172, 1),
                              color: Color.fromRGBO(144, 200, 172, 1),
                              // color: Color.fromRGBO(246, 198, 234, 1),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )),
          Padding(
            padding: EdgeInsets.only(top: 0.02 * height, left: 0.1 * width),
            child: Text(
              "Bunga(persen)",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Color.fromRGBO(157, 157, 157, 1),
                fontSize: 16,
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(top: 0.02 * height, left: 0.1 * width),
              child: Container(
                width: 0.85 * width,
                height: 0.07 * height,
                child: TextFormField(
                    controller: bunga,
                    // obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(157, 157, 157, 0.5),
                          fontSize: 16,
                        ),
                        hintText: "5")),
              )),
          Padding(
            padding: EdgeInsets.only(top: 0.02 * height, left: 0.1 * width),
            child: Text(
              "Tenor(tahun)",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Color.fromRGBO(157, 157, 157, 1),
                fontSize: 16,
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(top: 0.02 * height, left: 0.1 * width),
              child: Container(
                width: 0.85 * width,
                height: 0.07 * height,
                child: TextFormField(
                    controller: tenor,
                    // obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(157, 157, 157, 0.5),
                          fontSize: 16,
                        ),
                        hintText: "5")),
              )),
          Padding(
            padding: EdgeInsets.only(top: 0.04 * height, left: 0.1 * width),
            child: InkWell(
              onTap: () {
                calculate();
                // inserttypenproduct();
              },
              child: Container(
                width: width * 0.85,
                height: height * 0.07,
                // color: Color.fromRGBO(217, 215, 241, 1),
                decoration: BoxDecoration(
                    color: Color.fromRGBO(249, 249, 249, 1),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 5.0,
                          color: Colors.black12,
                          spreadRadius: 2.0,
                          offset: Offset(0, 2))
                    ]),
                child: Center(
                  child: Text(
                    "Calculate",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      // color: Color.fromRGBO(104, 103, 172, 1),
                      color: Color.fromRGBO(144, 200, 172, 1),
                      // color: Color.fromRGBO(246, 198, 234, 1),
                    ),
                  ),
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
