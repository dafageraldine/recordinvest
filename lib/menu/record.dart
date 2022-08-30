import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Recordpage extends StatefulWidget {
  const Recordpage({Key? key}) : super(key: key);

  @override
  State<Recordpage> createState() => _RecordpageState();
}

class _RecordpageState extends State<Recordpage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          width: width,
          height: height * 0.1,
          // color: Color.fromRGBO(217, 215, 241, 1),
          color: Color.fromRGBO(144, 200, 172, 1),
          child: Padding(
            padding: EdgeInsets.only(left: 0.05 * width, top: 0.04 * height),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Create Record",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    // color: Color.fromRGBO(104, 103, 172, 1),
                    color: Color.fromRGBO(249, 249, 249, 1),
                    // color: Color.fromRGBO(246, 198, 234, 1),
                  ),
                )),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 0.02 * height, left: 0.1 * width),
          child: Text(
            "Investment Type",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Color.fromRGBO(157, 157, 157, 1),
              fontSize: 16,
            ),
          ),
        ),
        Padding(
            padding: EdgeInsets.only(top: 0.02 * height, left: 0.1 * width),
            child: Container(
              width: 0.85 * width,
              height: 0.07 * height,
              child: TextFormField(
                  // controller: pass,
                  // obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Color.fromRGBO(157, 157, 157, 0.5),
                        fontSize: 16,
                      ),
                      hintText: "Reksadana Saham")),
            )),
        Padding(
          padding: EdgeInsets.only(top: 0.02 * height, left: 0.1 * width),
          child: Text(
            "Product Name",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Color.fromRGBO(157, 157, 157, 1),
              fontSize: 16,
            ),
          ),
        ),
        Padding(
            padding: EdgeInsets.only(top: 0.02 * height, left: 0.1 * width),
            child: Container(
              width: 0.85 * width,
              height: 0.07 * height,
              child: TextFormField(
                  // controller: pass,
                  // obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Color.fromRGBO(157, 157, 157, 0.5),
                        fontSize: 16,
                      ),
                      hintText: "Sucorinvest equity fund")),
            )),
        Padding(
          padding: EdgeInsets.only(top: 0.02 * height, left: 0.1 * width),
          child: Text(
            "Value",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Color.fromRGBO(157, 157, 157, 1),
              fontSize: 16,
            ),
          ),
        ),
        Padding(
            padding: EdgeInsets.only(top: 0.02 * height, left: 0.1 * width),
            child: Container(
              width: 0.85 * width,
              height: 0.07 * height,
              child: TextFormField(
                  // controller: pass,
                  // obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Color.fromRGBO(157, 157, 157, 0.5),
                        fontSize: 16,
                      ),
                      hintText: "15,000,000.00")),
            )),
        Padding(
          padding: EdgeInsets.only(top: 0.04 * height, left: 0.1 * width),
          child: InkWell(
            onTap: () {},
            child: Container(
              width: width * 0.85,
              height: height * 0.07,
              // color: Color.fromRGBO(217, 215, 241, 1),
              decoration: BoxDecoration(
                  color: Color.fromRGBO(249, 249, 249, 1),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 5.0,
                        color: Colors.black12,
                        spreadRadius: 2.0,
                        offset: Offset(0, 2))
                  ]),
              child: Center(
                child: Text(
                  "Create Record",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    // color: Color.fromRGBO(104, 103, 172, 1),
                    color: Color.fromRGBO(144, 200, 172, 1),
                    // color: Color.fromRGBO(246, 198, 234, 1),
                  ),
                ),
              ),
            ),
          ),
        )
      ]),
    );
  }
}
