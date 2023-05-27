import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../models/data.dart';
import 'package:google_fonts/google_fonts.dart';

class AppBarWithButton extends StatelessWidget {
  var onTap;
  final String titleButton;
  final String titleBar;

  AppBarWithButton(
      {super.key,
      this.onTap,
      required this.titleButton,
      required this.titleBar});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));
    return Container(
      width: 1.sw,
      height: 0.1.sh,
      // color: Color.fromRGBO(217, 215, 241, 1),
      color: theme,
      child: Padding(
        padding: EdgeInsets.only(left: 0.05.sw, top: 0.04.sh),
        child: Align(
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Text(titleBar,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                      color: const Color.fromRGBO(249, 249, 249, 1),
                    )),
                SizedBox(
                  width: 0.2.sw,
                ),
                InkWell(
                  onTap: onTap,
                  child: Container(
                    width: 0.15.sw,
                    height: 0.04.sh,
                    color: Colors.white,
                    child: Center(
                        child: Text(titleButton,
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 10.sp,
                              color: const Color.fromRGBO(157, 157, 157, 1),
                            ))),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
