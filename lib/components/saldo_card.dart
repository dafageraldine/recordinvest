import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../models/data.dart';

class SaldoCard extends StatelessWidget {
  final String saldo;
  final String date;
  final String percent;
  var onTap;

  SaldoCard(
      {super.key,
      required this.saldo,
      required this.date,
      required this.percent,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));
    return Container(
      width: 0.85.sw,
      height: 0.125.sh,
      decoration: BoxDecoration(
          // color: Color.fromRGBO(250, 244, 183, 1),
          color: const Color.fromRGBO(157, 157, 157, 1),
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
                blurRadius: 5.0,
                color: Colors.black12,
                spreadRadius: 5.0,
                offset: Offset(0, 2))
          ]),
      child: Stack(
        children: [
          /* btn refresh
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Align(
              alignment: Alignment.bottomRight,
              child: InkWell(
                onTap: onTap,
                child: Container(
                  width: 0.2.sw,
                  height: 30,
                  decoration: BoxDecoration(
                      // color: Color.fromRGBO(250, 244, 183, 1),
                      color: theme,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                            blurRadius: 5.0,
                            color: Colors.black12,
                            spreadRadius: 5.0,
                            offset: Offset(0, 2))
                      ]),
                  child: const Center(
                      child: Text(
                    "Refresh",
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      // color: Color.fromRGBO(157, 157, 157, 1),
                      // color: Color.fromRGBO(144, 200, 172, 1),
                      color: Color.fromRGBO(249, 249, 249, 1),
                      fontSize: 12,
                    ),
                  )),
                ),
              ),
            ),
          ),
          */
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 0.02.sh, left: 0.1.sw),
                child: Row(
                  children: [
                    const Text(
                      "Saldo",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        // color: Color.fromRGBO(157, 157, 157, 1),
                        // color: Color.fromRGBO(144, 200, 172, 1),
                        color: Color.fromRGBO(249, 249, 249, 1),
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      " $percent",
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        // color: Color.fromRGBO(157, 157, 157, 1),
                        // color: Color.fromRGBO(144, 200, 172, 1),
                        color: percent.contains("+")
                            ? Colors.green[100]
                            : percent.contains("-")
                                ? Colors.red[100]
                                : Colors.blueGrey,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 0.1.sw),
                child: Text(
                  "Rp $saldo",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    // color: Color.fromRGBO(157, 157, 157, 1),
                    // color: Color.fromRGBO(144, 200, 172, 1),
                    color: percent.contains("+")
                        ? Colors.green[100]
                        : percent.contains("-")
                            ? Colors.red[100]
                            : Colors.blueGrey,
                    fontSize: 20,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 0.01.sw, left: 0.1.sw),
                child: Text(
                  date,
                  style: const TextStyle(
                    // color: Color.fromRGBO(157, 157, 157, 1),
                    // color: Color.fromRGBO(144, 200, 172, 1),
                    color: Color.fromRGBO(249, 249, 249, 1),
                    fontWeight: FontWeight.w800,
                    fontSize: 12,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
