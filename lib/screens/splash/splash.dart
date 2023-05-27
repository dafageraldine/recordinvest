import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:recordinvest/controller/splashcontroller.dart';
import 'package:recordinvest/models/data.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final SplashController _splashController = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Center(
            child: Image.asset(
              "assets/icon.png",
              width: 0.6.sw,
              height: 0.6.sw,
              fit: BoxFit.contain,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  "Record Invest v$Build.$Major.$Minor",
                  style: const TextStyle(fontWeight: FontWeight.w700),
                )),
          ),
        ],
      ),
    );
  }
}
