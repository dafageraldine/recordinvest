import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:recordinvest/components/app_bar_with_back_button.dart';
import 'package:recordinvest/components/datebutton.dart';
import 'package:recordinvest/controller/homecontroller.dart';

import '../../components/processbutton.dart';

class UpdateStock extends StatelessWidget {
  UpdateStock({super.key});

  final HomeController _homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        AppBarWithBackButton(
          titleBar: 'Update Stock',
          onTap: () {
            Get.back();
          },
        ),
        Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 0.02.sh, left: 0.1.sw),
                  child: const Text(
                    "Stock Type",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Color.fromRGBO(157, 157, 157, 1),
                      fontSize: 16,
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(top: 0.02.sh, left: 0.1.sw),
                    child: Obx(() => Container(
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
                          items: _homeController.combStockTypeNew,
                          dropdownBuilder: (context, item) => Text(item!),
                          onChanged: (value) {
                            _homeController.selectedStockTypeNew.value = value!;
                          },
                          selectedItem:
                              _homeController.selectedStockTypeNew.value,
                        )))),
                Padding(
                  padding: EdgeInsets.only(top: 0.02.sh, left: 0.1.sw),
                  child: const Text(
                    "Global Stock code",
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
                        controller: _homeController.valuesNew.value,
                        // obscureText: true,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Color.fromRGBO(157, 157, 157, 0.5),
                              fontSize: 16,
                            ),
                            hintText: "BBCA.JK")),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 0.02.sh, left: 0.1.sw),
                  child: const Text(
                    "Filename",
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
                        controller: _homeController.filenameNew.value,
                        // obscureText: true,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Color.fromRGBO(157, 157, 157, 0.5),
                              fontSize: 16,
                            ),
                            hintText: "BBCA")),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 0.02.sh, left: 0.1.sw),
                  child: const Text(
                    "Start Date",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Color.fromRGBO(157, 157, 157, 1),
                      fontSize: 16,
                    ),
                  ),
                ),
                DateButton(
                  date: _homeController.startdateNew.value,
                  onTap: () {
                    _homeController.datepickNew('start');
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 0.02.sh, left: 0.1.sw),
                  child: const Text(
                    "End Date",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Color.fromRGBO(157, 157, 157, 1),
                      fontSize: 16,
                    ),
                  ),
                ),
                DateButton(
                  date: _homeController.enddateNew.value,
                  onTap: () {
                    _homeController.datepickNew('end');
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 0.04.sh, left: 0.1.sw),
                  child: ProcessButton(
                    title: 'Update',
                    onTap: () {
                      _homeController.updateStockData();
                    },
                  ),
                )
              ],
            ))
      ]),
    );
  }
}
