import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class AppBarWithBackButton extends StatelessWidget {
  final String titleBar;
  var onTap;

  AppBarWithBackButton({super.key, required this.titleBar, this.onTap});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      width: width,
      height: height * 0.12,
      // color: Color.fromRGBO(217, 215, 241, 1),
      color: Color.fromRGBO(144, 200, 172, 1),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 0.1 * width, top: 0.1 * width),
            child: InkWell(
              onTap: onTap,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                ),
                width: 0.125 * width,
                height: 0.125 * width,
                child: Icon(
                  Icons.arrow_back_ios_new,
                  color: Color.fromRGBO(144, 200, 172, 1),
                  size: 0.06 * width,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 0.08 * width, left: 0.05 * width),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  titleBar,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    // color: Color.fromRGBO(104, 103, 172, 1),
                    color: Color.fromRGBO(249, 249, 249, 1),
                    // color: Color.fromRGBO(246, 198, 234, 1),
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
