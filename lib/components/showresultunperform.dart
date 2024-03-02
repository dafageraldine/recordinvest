import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/homecontroller.dart';
import '../models/data.dart';

class ShowResultUnperform {
  final HomeController _homeController = Get.find();
  void showcb() {
    // flutter defined function
    Get.dialog(Dialog(
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: SizedBox(
        width: Get.width * 0.85,
        height: 0.3 * Get.height,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: 0.1 * Get.width, top: 0.05 * Get.height),
              child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Choose Asset",
                    style: TextStyle(
                        color: Color.fromRGBO(82, 82, 82, 1),
                        fontSize: 14,
                        // fontFamily: 'Inter',
                        fontWeight: FontWeight.w600),
                  )),
            ),
            const SizedBox(height: 10),
            Obx(
              () => Container(
                  width: 0.7 * Get.width,
                  height: 0.07 * Get.height,
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
                    items: combobox,
                    dropdownBuilder: (context, item) => Text(item!),
                    onChanged: (value) =>
                        _homeController.selectedpilihan.value = value!
                    // setState(() {
                    //   selectedpilihan = value!;
                    // })
                    ,
                    selectedItem: _homeController.selectedpilihan.value,
                  )),
            ),
            InkWell(
              onTap: () {
                for (var i = 0; i < _homeController.list_cb_data.length; i++) {
                  if (_homeController.selectedpilihan ==
                      _homeController.list_cb_data[i].product) {
                    _homeController.tais.value.text =
                        _homeController.list_cb_data[i].value;
                    break;
                  }
                }
                Get.back();
              },
              child: Container(
                width: 0.7 * Get.width,
                height: 0.07 * Get.height,
                decoration: BoxDecoration(
                    color: theme, borderRadius: BorderRadius.circular(10)),
                child: const Center(
                    child: Text(
                  "Select",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                )),
              ),
            ),
            const SizedBox(
              height: 15,
            )
          ],
        ),
      ),
    ));
  }
}
