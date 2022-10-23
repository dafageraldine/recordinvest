import 'dart:convert';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:recordinvest/data.dart';
import 'package:recordinvest/home/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController uname = TextEditingController();
  TextEditingController pass = TextEditingController();

  Future login() async {
    try {
      var body = {"user": uname.text, "pwd": pass.text};
      http.Response postdata =
          await http.post(Uri.parse(baseurl + "login"), body: body);
      var data = json.decode(postdata.body);
      if (data["data"].length > 0) {
        for (int i = 0; i < data["data"].length; i++) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('uname', data["data"][i]["user"]);
          await prefs.setString('pass', pass.text);
          await prefs.setString('id', data["data"][i]["id"]);
          break;
        }
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Homepage()));
      } else {
        Fluttertoast.showToast(
            msg: "Username atau password salah !",
            backgroundColor: Colors.black,
            textColor: Colors.white);
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: e.toString(),
          backgroundColor: Colors.black,
          textColor: Colors.white);
    }
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text(
        "No",
        style: TextStyle(color: Colors.grey),
      ),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text(
        "yes",
        style: TextStyle(
          color: Color.fromRGBO(144, 200, 172, 1),
        ),
      ),
      onPressed: () async {
        exit(0);
        // await delete();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Warning"),
      content: Text("Do you want exit ?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async {
        showAlertDialog(context);
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Center(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      "Record Invest v" + Build + "." + Major + "." + Minor,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        // color: Color.fromRGBO(157, 157, 157, 1),
                        // color: Color.fromRGBO(144, 200, 172, 1),
                        color: Colors.grey[800],
                        fontSize: 16,
                      ),
                    )),
              ),
              Column(
                children: [
                  SizedBox(
                    height: 0.225 * height,
                  ),
                  // 100.verticalSpace,
                  Image.asset(
                    "assets/icon.png",
                    width: 0.4 * width,
                    height: 0.4 * width,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(
                    height: 0.02 * height,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 25,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        width: 0.85 * width,
                        height: 0.07 * height,
                        child: TextFormField(
                            controller: uname,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Username")),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 0.02 * height,
                  ),
                  // 20.verticalSpace,
                  Padding(
                    padding: EdgeInsets.only(
                      left: 25,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        width: 0.85 * width,
                        height: 0.07 * height,
                        child: TextFormField(
                            controller: pass,
                            obscureText: true,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Password")),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 0.02 * height,
                  ),
                  // 20.verticalSpace,
                  InkWell(
                    onTap: () async {
                      // if (isloading == 1) {
                      //   Fluttertoast.showToast(
                      //       msg: "Login on process, please wait !",
                      //       backgroundColor: Colors.black,
                      //       textColor: Colors.white);
                      // } else {
                      //   setState(() {
                      //     isloading = 1;
                      //   });
                      //   await cekVersi();
                      // }
                      login();
                    },
                    child: Container(
                      width: 0.85 * width,
                      height: 0.07 * height,
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(144, 200, 172, 1),
                          borderRadius: BorderRadius.circular(5)),
                      child:
                          // isloading == 1
                          //     ? Center(
                          //         child: CircularProgressIndicator(
                          //           color: Colors.white,
                          //         ),
                          //       )
                          //     :
                          Center(
                              child: Text(
                        "Login",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      )),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
