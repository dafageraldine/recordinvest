import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../components/app_bar_with_back_button.dart';
import '../../components/datebutton.dart';
import '../../components/processbutton.dart';
import '../../controller/homecontroller.dart';

class Addwatchlist extends StatelessWidget {
  Addwatchlist({super.key});
  final HomeController _homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        AppBarWithBackButton(
          titleBar: 'watchlist',
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
                          items: _homeController.combStockType,
                          dropdownBuilder: (context, item) => Text(item!),
                          onChanged: (value) {
                            _homeController.selectedStockType.value = value!;
                          },
                          selectedItem: _homeController.selectedStockType.value,
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
                        controller: _homeController.values.value,
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
                        controller: _homeController.filename.value,
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
                  date: _homeController.startdate.value,
                  onTap: () {
                    _homeController.datepick('start');
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 0.04.sh, left: 0.1.sw),
                  child: ProcessButton(
                    title: 'Save',
                    onTap: () {
                      _homeController.showAlertDialog(() async {
                        _homeController.addwatchlistData();
                        Get.back();
                      }, "Konfirmasi Simpan",
                          "Apakah anda ingin simpan watchlist");
                    },
                  ),
                )
              ],
            ))
      ]),
    );
  }
}
