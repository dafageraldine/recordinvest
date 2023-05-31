import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DateButton extends StatelessWidget {
  var onTap;
  String date;
  DateButton({super.key, this.onTap, required this.date});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 0.02.sh, left: 0.1.sw),
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: 0.45.sw,
          height: 0.06.sh,
          decoration: BoxDecoration(
              color: Colors.grey.shade600,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                    blurRadius: 5.0,
                    color: Colors.black12,
                    spreadRadius: 2.0,
                    offset: Offset(0, 2))
              ]),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 0.05.sw),
                  child: Text(
                    date,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Colors.white),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 0.05.sw),
                  child: const Icon(
                    Icons.date_range_rounded,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
