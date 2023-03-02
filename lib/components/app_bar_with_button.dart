import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      width: width,
      height: height * 0.1,
      // color: Color.fromRGBO(217, 215, 241, 1),
      color: Color.fromRGBO(144, 200, 172, 1),
      child: Padding(
        padding: EdgeInsets.only(left: 0.05 * width, top: 0.04 * height),
        child: Align(
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Text(
                  titleBar,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    // color: Color.fromRGBO(104, 103, 172, 1),
                    color: Color.fromRGBO(249, 249, 249, 1),
                    // color: Color.fromRGBO(246, 198, 234, 1),
                  ),
                ),
                SizedBox(
                  width: 0.2 * width,
                ),
                InkWell(
                  onTap: onTap,
                  child: Container(
                    width: 0.15 * width,
                    height: 0.04 * height,
                    color: Colors.white,
                    child: Center(
                        child: Text(
                      titleButton,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        // color: Color.fromRGBO(104, 103, 172, 1),
                        color: Color.fromRGBO(157, 157, 157, 1),
                        // color: Color.fromRGBO(246, 198, 234, 1),
                      ),
                    )),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
