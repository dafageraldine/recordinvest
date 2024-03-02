import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:recordinvest/controller/homecontroller.dart';
import '../../../../components/app_bar_with_back_button.dart';

class AddType extends StatefulWidget {
  const AddType({Key? key}) : super(key: key);

  @override
  State<AddType> createState() => _AddTypeState();
}

class _AddTypeState extends State<AddType> {
  final HomeController _homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));
    return Scaffold(
        backgroundColor: Colors.white,
        body: Obx(
          () => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            AppBarWithBackButton(
                titleBar: "Add Investment Type",
                onTap: () {
                  Get.back();
                }),
            Padding(
              padding: EdgeInsets.only(top: 0.02.sh, left: 0.1.sw),
              child: const Text(
                "Investment Type",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Color.fromRGBO(157, 157, 157, 1),
                  fontSize: 16,
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: 0.02.sh, left: 0.1.sw),
                child: SizedBox(
                  width: 0.85.sw,
                  height: 0.07.sh,
                  child: TextFormField(
                      controller: _homeController.type.value,
                      // obscureText: true,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Color.fromRGBO(157, 157, 157, 0.5),
                            fontSize: 16,
                          ),
                          hintText: "Reksadana Saham")),
                )),
            Padding(
              padding: EdgeInsets.only(top: 0.02.sh, left: 0.1.sw),
              child: const Text(
                "Product Name",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Color.fromRGBO(157, 157, 157, 1),
                  fontSize: 16,
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: 0.02.sh, left: 0.1.sw),
                child: SizedBox(
                  width: 0.85.sw,
                  height: 0.07.sh,
                  child: TextFormField(
                      controller: _homeController.product.value,
                      // obscureText: true,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Color.fromRGBO(157, 157, 157, 0.5),
                            fontSize: 16,
                          ),
                          hintText: "Sucorinvest equity fund")),
                )),
            Padding(
              padding: EdgeInsets.only(top: 0.04.sh, left: 0.1.sw),
              child: InkWell(
                onTap: () {
                  _homeController.inserttypenproduct();
                },
                child: Container(
                  width: 0.85.sw,
                  height: 0.07.sh,
                  // color: Color.fromRGBO(217, 215, 241, 1),
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
                  child: const Center(
                    child: Text(
                      "Create Investment Type",
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
        ));
  }
}
