import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:recordinvest/models/data.dart';
import 'package:recordinvest/screens/bottombar/bottombar.dart';
import 'package:recordinvest/screens/login/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:convert';

class SplashController extends GetxController with StateMixin {
  @override
  void onInit() {
    login();
    super.onInit();
  }

  Future login() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? uname = prefs.getString('uname');
      final String? pass = prefs.getString('pass');
      var body = {"user": uname, "pwd": pass};
      http.Response postdata =
          await http.post(Uri.parse("${baseurl}login"), body: body);
      var data = json.decode(postdata.body);
      if (data["data"].length > 0) {
        //use getx
        Get.to(BottomBar());
      } else {
        Timer(const Duration(seconds: 3), () {
          Get.to(Login());
        });
      }
    } catch (e) {
      Timer(const Duration(seconds: 3), () {
        Get.to(Login());
      });
    }
  }
}
