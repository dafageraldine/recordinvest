import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/data.dart';

class CardMenu extends StatelessWidget {
  final String image;
  var onTap;
  final String title_card;

  CardMenu(
      {super.key,
      required this.onTap,
      required this.image,
      required this.title_card});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));
    return Align(
        alignment: Alignment.centerLeft,
        child: Padding(
            padding: EdgeInsets.only(left: 0.09.sw),
            child: InkWell(
              onTap: onTap,
              child: Container(
                width: 0.37.sw,
                height: 0.37.sw,
                decoration: BoxDecoration(
                    color: theme,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                          blurRadius: 5.0,
                          color: Colors.black12,
                          spreadRadius: 5.0,
                          offset: Offset(0, 2))
                    ]),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 18,
                    ),
                    Image.asset(
                      image,
                      width: 0.18.sw,
                      height: 0.18.sw,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      width: 0.35.sw,
                      child: Text(title_card,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 12.sp,
                            color: const Color.fromRGBO(249, 249, 249, 1),
                          )),
                    )
                  ],
                ),
              ),
            )));
  }
}
