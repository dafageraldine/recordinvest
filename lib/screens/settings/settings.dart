import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recordinvest/components/app_bar_only.dart';
import 'package:recordinvest/models/data.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../login/login.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(children: [
        AppBarOnly(
          titleBar: 'Application Settings',
        ),
        5.verticalSpace,
        Divider(
          color: Colors.grey.shade300,
          thickness: 2,
          indent: 30,
          endIndent: 30,
        ),
        Padding(
          padding: EdgeInsets.only(left: 0.1.sw),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Log Out",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600, fontSize: 14.sp)),
                    Text("Exit Application",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.normal, fontSize: 12.sp))
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(right: 0.1.sw),
                  child: InkWell(
                    onTap: () async {
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.remove('uname');
                      await prefs.remove('pass');
                      await prefs.remove('id');
                      Get.deleteAll();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                        // Set rootNavigator to true
                      );
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) => Login()));
                    },
                    child: Container(
                      width: 0.15.sw,
                      height: 0.05.sh,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: theme,
                      ),
                      child:
                          Icon(Icons.exit_to_app_rounded, color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        // Padding(
        //   padding: EdgeInsets.only(left: 0.1.sw),
        //   child: Align(
        //     alignment: Alignment.centerLeft,
        //     child: Text("Exit Application",
        //         style: GoogleFonts.poppins(
        //             fontWeight: FontWeight.normal, fontSize: 12.sp)),
        //   ),
        // ),
        5.verticalSpace,
        Divider(
          color: Colors.grey.shade300,
          thickness: 2,
          indent: 30,
          endIndent: 30,
        ),
      ]),
    );
  }
}
