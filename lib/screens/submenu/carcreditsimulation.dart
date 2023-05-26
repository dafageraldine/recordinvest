import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:recordinvest/controller/homecontroller.dart';
import 'package:recordinvest/models/data.dart';
import 'package:recordinvest/screens/submenu/hasilsimulasi.dart';

import '../../../components/app_bar_with_back_button.dart';
import '../../controller/carcreditsimulationcontroller.dart';

class CarCreditSimulation extends StatelessWidget {
  CarCreditSimulationController _carCreditSimulationController =
      Get.put(CarCreditSimulationController());
  HomeController _homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: Obx(
        () => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                    controller: _carCreditSimulationController.otr.value,
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
                        controller: _carCreditSimulationController.dp.value,
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
                  InkWell(
                    onTap: () {
                      _carCreditSimulationController.dp.value.text =
                          _homeController.saldo.value.toString();
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
                    controller: _carCreditSimulationController.bunga.value,
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
                    controller: _carCreditSimulationController.tenor.value,
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
                _carCreditSimulationController.calculate();
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
      )),
    );
  }
}
