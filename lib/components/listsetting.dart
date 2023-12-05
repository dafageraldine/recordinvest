import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recordinvest/models/data.dart';

class ListSetting extends StatelessWidget {
  var ontap;
  String title;
  String desc;
  IconData icon;
  ListSetting(
      {super.key,
      required this.ontap,
      required this.title,
      required this.desc,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 0.1.sw),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600, fontSize: 14.sp)),
                Text(desc,
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.normal, fontSize: 12.sp))
              ],
            ),
            Padding(
              padding: EdgeInsets.only(right: 0.1.sw),
              child: InkWell(
                onTap: ontap,
                child: Container(
                  width: 0.15.sw,
                  height: 0.05.sh,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: theme,
                  ),
                  child: Icon(icon, color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
