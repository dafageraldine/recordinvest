import 'package:flutter/material.dart';

class AppBarWithBackButtonAndIconButton extends StatelessWidget {
  var onTapIcon;
  var onTap;
  final String titleBar;

  AppBarWithBackButtonAndIconButton(
      {super.key, this.onTapIcon, required this.titleBar, this.onTap});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      width: width,
      height: height * 0.12,
      color: const Color.fromRGBO(144, 200, 172, 1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 0.1 * width),
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
                  color: const Color.fromRGBO(144, 200, 172, 1),
                  size: 0.06 * width,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 0.04 * height),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  titleBar,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: Color.fromRGBO(249, 249, 249, 1),
                  ),
                )),
          ),
          Padding(
            padding: EdgeInsets.only(top: 0.1 * width),
            child: InkWell(
              onTap: onTapIcon,
              child: Container(
                width: 0.12 * width,
                height: 0.12 * width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)),
                child: const Icon(
                  Icons.filter_list_rounded,
                  size: 20,
                  color: Color.fromRGBO(82, 82, 82, 1),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
