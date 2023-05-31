import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/data.dart';

class AppBarOnly extends StatelessWidget {
  final String titleBar;

  AppBarOnly({super.key, required this.titleBar});

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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(titleBar,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                  color: const Color.fromRGBO(249, 249, 249, 1),
                )),
          ],
        ),
      ),
    );
  }
}
