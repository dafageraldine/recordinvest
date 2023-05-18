import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:recordinvest/screens/home/home.dart';
import 'package:recordinvest/models/data.dart';
import 'package:http/http.dart' as http;
import 'package:recordinvest/screens/login/login.dart';
import 'package:recordinvest/viewmodels/home/homeviewmodel.dart';
import 'package:recordinvest/viewmodels/login/loginviewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../home/home.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  Future login() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? uname = prefs.getString('uname');
      final String? pass = prefs.getString('pass');
      var body = {"user": uname, "pwd": pass};
      http.Response postdata =
          await http.post(Uri.parse(baseurl + "login"), body: body);
      var data = json.decode(postdata.body);
      if (data["data"].length > 0) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChangeNotifierProvider<HomeViewModel>(
                    create: (context) => HomeViewModel(), child: Homepage())));
      } else {
        Timer(const Duration(seconds: 3), () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Login(
                        viewModel: LoginViewModel(),
                      )));
        });
      }
    } catch (e) {
      Timer(const Duration(seconds: 3), () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Login(
                      viewModel: LoginViewModel(),
                    )));
      });
    }
  }

  @override
  void initState() {
    login();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Center(
            child: Image.asset(
              "assets/icon.png",
              width: 0.6 * width,
              height: 0.6 * width,
              fit: BoxFit.contain,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  "Record Invest v" + Build + "." + Major + "." + Minor,
                  style: TextStyle(fontWeight: FontWeight.w700),
                )),
          ),
        ],
      ),
    );
  }
}
