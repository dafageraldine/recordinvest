import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:recordinvest/controller/backgroundservicecontroller.dart';
import 'package:recordinvest/models/data.dart';
import 'package:recordinvest/screens/splash/splash.dart';

Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    //Remove this method to stop OneSignal Debugging
    // OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

    OneSignal.shared.setAppId("9ccee615-aa11-4644-abe8-781c0186ebb8");

    // The promptForPushNotificationsWithUserResponse function will show the iOS or Android push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
    OneSignal.shared
        .promptUserForPushNotificationPermission()
        .then((accepted) {});
    camerasg = await availableCameras();
    await BackgroundServiceController().initializeService();
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
