import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:recordinvest/controller/manageunperformportofoliocontroller.dart';
import 'package:recordinvest/models/comboboxdata.dart';
import '../../../components/app_bar_with_back_button.dart';

class ManageUnperformPortofolio extends StatelessWidget {
  final ManageUnperformPortofolioController
      _manageUnperformPortofolioController =
      Get.put(ManageUnperformPortofolioController());

  ManageUnperformPortofolio({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: Obx(
        () => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          AppBarWithBackButton(
              titleBar: "Manage Unperform Portofolio",
              onTap: () {
                Navigator.pop(context);
              }),
          SizedBox(
            height: 0.025.sh,
          ),
          Padding(
            padding: EdgeInsets.only(top: 0.02.sh, left: 0.1.sw),
            child: const Text(
              "Floating loss(money)",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Color.fromRGBO(157, 157, 157, 1),
                fontSize: 16,
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(top: 0.02.sh, left: 0.1.sw),
              child: SizedBox(
                width: 0.85.sw,
                height: 0.07.sh,
                child: TextFormField(
                    controller:
                        _manageUnperformPortofolioController.floss.value,
                    // obscureText: true,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(157, 157, 157, 0.5),
                          fontSize: 16,
                        ),
                        hintText: "15.8")),
              )),
          Padding(
            padding: EdgeInsets.only(top: 0.02.sh, left: 0.1.sw),
            child: const Text(
              "Kurs",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Color.fromRGBO(157, 157, 157, 1),
                fontSize: 16,
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(top: 0.02.sh, left: 0.1.sw),
              child: Row(
                children: [
                  SizedBox(
                    width: 0.85.sw,
                    height: 0.07.sh,
                    child: TextFormField(
                        controller:
                            _manageUnperformPortofolioController.kurs.value,
                        // obscureText: true,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Color.fromRGBO(157, 157, 157, 0.5),
                              fontSize: 16,
                            ),
                            hintText: "15500")),
                  ),
                ],
              )),
          Padding(
            padding: EdgeInsets.only(top: 0.02.sh, left: 0.1.sw),
            child: const Text(
              "Money Invested",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Color.fromRGBO(157, 157, 157, 1),
                fontSize: 16,
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(top: 0.02.sh, left: 0.1.sw),
              child: SizedBox(
                width: 0.85.sw,
                height: 0.07.sh,
                child: TextFormField(
                    controller: _manageUnperformPortofolioController.mi.value,
                    // obscureText: true,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(157, 157, 157, 0.5),
                          fontSize: 16,
                        ),
                        hintText: "100")),
              )),
          Padding(
            padding: EdgeInsets.only(top: 0.02.sh, left: 0.1.sw),
            child: const Text(
              "Desired loss in (%)",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Color.fromRGBO(157, 157, 157, 1),
                fontSize: 16,
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(top: 0.02.sh, left: 0.1.sw),
              child: SizedBox(
                width: 0.85.sw,
                height: 0.07.sh,
                child: TextFormField(
                    controller: _manageUnperformPortofolioController.dl.value,
                    // obscureText: true,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(157, 157, 157, 0.5),
                          fontSize: 16,
                        ),
                        hintText: "5")),
              )),
          Padding(
            padding: EdgeInsets.only(top: 0.02.sh, left: 0.1.sw),
            child: const Text(
              "Price right now",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Color.fromRGBO(157, 157, 157, 1),
                fontSize: 16,
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(top: 0.02.sh, left: 0.1.sw),
              child: SizedBox(
                width: 0.85.sw,
                height: 0.07.sh,
                child: TextFormField(
                    controller: _manageUnperformPortofolioController.prn.value,
                    // obscureText: true,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(157, 157, 157, 0.5),
                          fontSize: 16,
                        ),
                        hintText: "20")),
              )),
          Padding(
            padding: EdgeInsets.only(top: 0.02.sh, left: 0.1.sw),
            child: const Text(
              "Assets in hand (in units)",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Color.fromRGBO(157, 157, 157, 1),
                fontSize: 16,
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(top: 0.02.sh, left: 0.1.sw),
              child: SizedBox(
                width: 0.85.sw,
                height: 0.07.sh,
                child: TextFormField(
                    controller: _manageUnperformPortofolioController.aih.value,
                    // obscureText: true,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(157, 157, 157, 0.5),
                          fontSize: 16,
                        ),
                        hintText: "5")),
              )),
          Padding(
            padding: EdgeInsets.only(top: 0.02.sh, left: 0.1.sw),
            child: const Text(
              "Total assets in switch",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Color.fromRGBO(157, 157, 157, 1),
                fontSize: 16,
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(top: 0.02.sh, left: 0.1.sw),
              child: Row(
                children: [
                  SizedBox(
                    width: 0.5.sw,
                    height: 0.07.sh,
                    child: TextFormField(
                        controller:
                            _manageUnperformPortofolioController.tais.value,
                        // obscureText: true,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Color.fromRGBO(157, 157, 157, 0.5),
                              fontSize: 16,
                            ),
                            hintText: "20000000")),
                  ),
                  SizedBox(
                    width: 0.05.sw,
                  ),
                  InkWell(
                    onTap: () {
                      print("here");
                      if (list_cb_data.isEmpty) {
                        _manageUnperformPortofolioController.get_cb_data();
                      } else {
                        _manageUnperformPortofolioController.showcb();
                      }
                    },
                    child: Container(
                      width: 0.3.sw,
                      height: 0.07.sh,
                      // color: Color.fromRGBO(217, 215, 241, 1),
                      decoration: BoxDecoration(
                          color: const Color.fromRGBO(249, 249, 249, 1),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                                blurRadius: 5.0,
                                color: Colors.black12,
                                spreadRadius: 2.0,
                                offset: Offset(0, 2))
                          ]),
                      child: const Center(
                        child: Text(
                          "Choose Asset",
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
            padding: EdgeInsets.only(top: 0.02.sh, left: 0.1.sw),
            child: const Text(
              "return switch in a day(%)",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Color.fromRGBO(157, 157, 157, 1),
                fontSize: 16,
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(top: 0.02.sh, left: 0.1.sw),
              child: SizedBox(
                width: 0.85.sw,
                height: 0.07.sh,
                child: TextFormField(
                    controller: _manageUnperformPortofolioController.rsia.value,
                    // obscureText: true,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(157, 157, 157, 0.5),
                          fontSize: 16,
                        ),
                        hintText: "0.02")),
              )),
          Padding(
            padding:
                EdgeInsets.only(top: 0.04.sh, left: 0.1.sw, bottom: 0.025.sh),
            child: InkWell(
              onTap: () {
                _manageUnperformPortofolioController.calculate();
                // inserttypenproduct();
              },
              child: Container(
                width: 0.85.sw,
                height: 0.07.sh,
                // color: Color.fromRGBO(217, 215, 241, 1),
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(249, 249, 249, 1),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                          blurRadius: 5.0,
                          color: Colors.black12,
                          spreadRadius: 2.0,
                          offset: Offset(0, 2))
                    ]),
                child: const Center(
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
