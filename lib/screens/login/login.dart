import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:recordinvest/components/appversion.dart';
import 'package:recordinvest/models/data.dart';

import '../../controller/homecontroller.dart';

class Login extends StatelessWidget {
  final HomeController _homeController = Get.find();

  Login({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));
    return WillPopScope(
      onWillPop: () async {
        // viewModel.showAlertDialog(context);
        _homeController.showAlertDialog(() {
          exit(0);
        }, "Keluar Aplikasi", "Apakah anda ingin keluar aplikasi ?");
        return true;
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: Obx(
            () => Center(
              child: Stack(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(18.0),
                    child: Align(
                        alignment: Alignment.bottomCenter, child: AppVersion()),
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 0.225.sh,
                      ),
                      Image.asset(
                        "assets/icon.png",
                        width: 0.4.sw,
                        height: 0.4.sw,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(
                        height: 0.02.sh,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 25,
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: SizedBox(
                            width: 0.85.sw,
                            height: 0.07.sh,
                            child: TextFormField(
                                controller: _homeController.uname.value,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: "Username")),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 0.02.sh,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 25,
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: SizedBox(
                            width: 0.85.sw,
                            height: 0.07.sh,
                            child: TextFormField(
                                controller: _homeController.pass.value,
                                obscureText: true,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: "Password")),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 0.02.sh,
                      ),
                      InkWell(
                        onTap: () async {
                          _homeController.login(
                              context,
                              _homeController.uname.value,
                              _homeController.pass.value);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Container(
                            width: 0.85.sw,
                            height: 0.07.sh,
                            decoration: BoxDecoration(
                                color: theme,
                                borderRadius: BorderRadius.circular(5)),
                            child: const Center(
                                child: Text(
                              "Login",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
