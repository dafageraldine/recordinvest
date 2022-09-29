import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Center(
        child: Stack(
          children: [
            // Padding(
            //   padding: const EdgeInsets.all(18.0),
            //   child: Align(
            //       alignment: Alignment.bottomCenter,
            //       child: Text(
            //         "Masuya Report Analytics v" +
            //             Build +
            //             "." +
            //             Major +
            //             "." +
            //             Minor,
            //         style: TextStyle(fontWeight: FontWeight.w700),
            //       )),
            // ),
            // Column(
            //   children: [
            //     // 100.verticalSpace,
            //     Image.asset(
            //       "assets/masuyalogo.png",
            //       width: 0.6.sw,
            //       height: 0.6.sw,
            //       fit: BoxFit.contain,
            //     ),
            //     Padding(
            //       padding: EdgeInsets.only(
            //         left: 25.w,
            //       ),
            //       child: Align(
            //         alignment: Alignment.centerLeft,
            //         child: Container(
            //           width: 0.85.sw,
            //           height: 0.07.sh,
            //           child: TextFormField(
            //               controller: uname,
            //               decoration: InputDecoration(
            //                   border: OutlineInputBorder(),
            //                   hintText: "Username")),
            //         ),
            //       ),
            //     ),
            //     // 20.verticalSpace,
            //     Padding(
            //       padding: EdgeInsets.only(
            //         left: 25.w,
            //       ),
            //       child: Align(
            //         alignment: Alignment.centerLeft,
            //         child: Container(
            //           width: 0.85.sw,
            //           height: 0.07.sh,
            //           child: TextFormField(
            //               controller: pass,
            //               obscureText: true,
            //               decoration: InputDecoration(
            //                   border: OutlineInputBorder(),
            //                   hintText: "Password")),
            //         ),
            //       ),
            //     ),
            //     // 20.verticalSpace,
            //     InkWell(
            //       onTap: () async {
            //         if (isloading == 1) {
            //           Fluttertoast.showToast(
            //               msg: "Login on process, please wait !",
            //               backgroundColor: Colors.black,
            //               textColor: Colors.white);
            //         } else {
            //           setState(() {
            //             isloading = 1;
            //           });
            //           await cekVersi();
            //         }
            //       },
            //       child: Container(
            //         width: 0.85.sw,
            //         height: 0.07.sh,
            //         decoration: BoxDecoration(
            //             color: Color.fromRGBO(16, 34, 156, 1),
            //             borderRadius: BorderRadius.circular(5)),
            //         child: isloading == 1
            //             ? Center(
            //                 child: CircularProgressIndicator(
            //                   color: Colors.white,
            //                 ),
            //               )
            //             : Center(
            //                 child: Text(
            //                 "Login",
            //                 style: TextStyle(
            //                     color: Colors.white,
            //                     fontSize: 18,
            //                     fontWeight: FontWeight.w600),
            //               )),
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
