import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:recordinvest/components/app_bar_with_back_button.dart';
import 'package:recordinvest/components/numformatter.dart';
import '../../../../models/data.dart';
import '../../controller/homecontroller.dart';

class Recordpage extends StatelessWidget {
  final HomeController _homeController = Get.find();

  Recordpage({super.key});
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));
    return Scaffold(
        backgroundColor: Colors.white,
        body: Obx(
          () => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            AppBarWithBackButton(
              titleBar: "Create Record",
              onTap: () {
                Get.back();
              },
            ),
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
              child: Container(
                  width: 0.85.sw,
                  height: 0.07.sh,
                  decoration: BoxDecoration(
                    // color: Colors.grey[600],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropdownSearch<String>(
                    popupProps: PopupProps.menu(
                      itemBuilder: (context, item, isSelected) =>
                          ListTile(title: Text(item)),
                      showSearchBox: true,
                    ),
                    items: comboboxtype,
                    dropdownBuilder: (context, item) => Text(item!),
                    onChanged: (value) =>
                        _homeController.selectedtype.value = value!
                    // setState(() {
                    //   selectedtype = value!;
                    // })
                    ,
                    selectedItem: _homeController.selectedtype.value,
                  )),
            ),
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
                child: Container(
                  width: 0.85.sw,
                  height: 0.07.sh,
                  decoration: BoxDecoration(
                    // color: Colors.grey[600],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropdownSearch<String>(
                    popupProps: PopupProps.menu(
                      itemBuilder: (context, item, isSelected) =>
                          ListTile(title: Text(item)),
                      showSearchBox: true,
                    ),
                    items: comboboxproduct,
                    dropdownBuilder: (context, item) => Text(item!),
                    onChanged: (value) =>
                        _homeController.selectedproduct.value = value!
                    // setState(() {
                    //   selectedproduct = value!;
                    // })
                    ,
                    selectedItem: _homeController.selectedproduct.value,
                  ),
                )),
            Padding(
              padding: EdgeInsets.only(top: 0.02.sh, left: 0.1.sw),
              child: const Text(
                "Value",
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
                      controller: _homeController.values.value,
                      // obscureText: true,
                      inputFormatters: [NumberInputFormatter()],
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Color.fromRGBO(157, 157, 157, 0.5),
                            fontSize: 16,
                          ),
                          hintText: "15,000,000")),
                )),
            Padding(
              padding: EdgeInsets.only(top: 0.04.sh, left: 0.1.sw),
              child: InkWell(
                onTap: () {
                  _homeController.insertrecord();
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
        ));
  }
}
