import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recordinvest/controller/logincontroller.dart';
import 'package:recordinvest/models/data.dart';

class Login extends StatelessWidget {
  TextEditingController uname = TextEditingController();
  TextEditingController pass = TextEditingController();

  final LoginController _loginController = Get.put(LoginController());

  Login({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async {
        // viewModel.showAlertDialog(context);
        _loginController.showAlertDialog();
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
                      "Record Invest v$Build.$Major.$Minor",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
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
                    padding: const EdgeInsets.only(
                      left: 25,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                        width: 0.85 * width,
                        height: 0.07 * height,
                        child: TextFormField(
                            controller: uname,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Username")),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 0.02 * height,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 25,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                        width: 0.85 * width,
                        height: 0.07 * height,
                        child: TextFormField(
                            controller: pass,
                            obscureText: true,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Password")),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 0.02 * height,
                  ),
                  InkWell(
                    onTap: () async {
                      _loginController.login(context, uname, pass);
                    },
                    child: Container(
                      width: 0.85 * width,
                      height: 0.07 * height,
                      decoration: BoxDecoration(
                          color: const Color.fromRGBO(144, 200, 172, 1),
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
