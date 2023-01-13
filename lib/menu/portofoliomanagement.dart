import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:recordinvest/submenu/manageunperformportofolio.dart';
import 'package:recordinvest/submenu/performance.dart';

class PortofolioManagement extends StatelessWidget {
  const PortofolioManagement({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(children: [
        Container(
          width: width,
          height: height * 0.12,
          // color: Color.fromRGBO(217, 215, 241, 1),
          color: Color.fromRGBO(144, 200, 172, 1),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding:
                    EdgeInsets.only(left: 0.05 * width, top: 0.04 * height),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Portofolio Management",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        // color: Color.fromRGBO(104, 103, 172, 1),
                        color: Color.fromRGBO(249, 249, 249, 1),
                        // color: Color.fromRGBO(246, 198, 234, 1),
                      ),
                    )),
              ),
              SizedBox(
                width: width * 0.325,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 0.025 * height,
        ),
        Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 0.1 * width),
              child: Text(
                "Menu",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Color.fromRGBO(157, 157, 157, 1),
                  fontSize: 16,
                ),
              ),
            )),
        SizedBox(
          height: 0.025 * height,
        ),
        Row(
          children: [
            Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                    padding: EdgeInsets.only(left: 0.1 * width),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Performance()));
                      },
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
                              height: 10,
                            ),
                            Image.asset(
                              "assets/financial-profit.png",
                              width: 0.2 * width,
                              height: 0.2 * width,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Performance",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 14,
                                color: Color.fromRGBO(249, 249, 249, 1),
                              ),
                            )
                          ],
                        ),
                      ),
                    ))),
            Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                    padding: EdgeInsets.only(left: 0.1 * width),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ManageUnperformPortofolio()));
                      },
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
                              height: 10,
                            ),
                            Image.asset(
                              "assets/accounting.png",
                              width: 0.2 * width,
                              height: 0.2 * width,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Manage Unperform Portofolio",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 14,
                                color: Color.fromRGBO(249, 249, 249, 1),
                              ),
                            )
                          ],
                        ),
                      ),
                    )))
          ],
        )
      ]),
      backgroundColor: Colors.white,
    );
  }
}
