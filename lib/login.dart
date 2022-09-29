import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:recordinvest/data.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController uname = TextEditingController();
  TextEditingController pass = TextEditingController();

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
