import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProcessButton extends StatelessWidget {
  var onTap;
  String title;
  ProcessButton({super.key, this.onTap, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 0.04.sh, left: 0.1.sw),
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: 0.85.sw,
          height: 0.07.sh,
          decoration: BoxDecoration(
              color: const Color.fromRGBO(249, 249, 249, 1),
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                    blurRadius: 5.0,
                    color: Colors.black12,
                    spreadRadius: 2.0,
                    offset: Offset(0, 2))
              ]),
          child: Center(
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: Color.fromRGBO(144, 200, 172, 1),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
