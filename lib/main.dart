import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recordinvest/screens/home/home.dart';
import 'package:recordinvest/screens/login/login.dart';
import 'package:recordinvest/screens/splash/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'MyInvestment',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: Splash());
  }
}
