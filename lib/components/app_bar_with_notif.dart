import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/data.dart';

class AppBarWithNotif extends StatelessWidget {
  final String titleBar;
  final bool showNNotif;
  final String notifcount;
  var onTap;

  AppBarWithNotif(
      {super.key,
      required this.titleBar,
      required this.showNNotif,
      required this.notifcount,
      required this.onTap});

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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(titleBar,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                  color: const Color.fromRGBO(249, 249, 249, 1),
                )),
            showNNotif
                ? Padding(
                    padding: EdgeInsets.only(right: 0.07.sw),
                    child: InkWell(
                      onTap: onTap,
                      child: Stack(
                        children: [
                          Icon(
                            Icons.notifications,
                            color: Colors.white,
                            size: 0.08.sw,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0, left: 15),
                            child: notifcount == "0"
                                ? const SizedBox()
                                : Container(
                                    width: 20,
                                    height: 20,
                                    decoration: const BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.circle),
                                    child: Center(
                                      child: Text(notifcount,
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 10.sp,
                                            color: const Color.fromRGBO(
                                                249, 249, 249, 1),
                                          )),
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ),
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}
