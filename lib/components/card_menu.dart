import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Align(
        alignment: Alignment.centerLeft,
        child: Padding(
            padding: EdgeInsets.only(left: 0.1 * width),
            child: InkWell(
              onTap: onTap,
              child: Container(
                width: 0.35 * width,
                height: 0.35 * width,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(144, 200, 172, 1),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 5.0,
                          color: Colors.black12,
                          spreadRadius: 5.0,
                          offset: Offset(0, 2))
                    ]),
                child: Column(
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Image.asset(
                      image,
                      width: 0.2 * width,
                      height: 0.2 * width,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      title_card,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: Color.fromRGBO(249, 249, 249, 1),
                      ),
                    )
                  ],
                ),
              ),
            )));
  }
}
