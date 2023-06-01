import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recordinvest/models/data.dart';
import 'package:recordinvest/screens/splash/splash.dart';

Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    camerasg = await availableCameras();
  } on CameraException catch (e) {
    Get.snackbar("error", e.toString());
  }
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
        home: const Splash());
  }
}
