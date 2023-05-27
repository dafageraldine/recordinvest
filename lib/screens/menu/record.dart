import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recordinvest/components/app_bar_with_back_button.dart';
import 'package:recordinvest/controller/recordcontroller.dart';
import '../../../../models/data.dart';

class Recordpage extends StatelessWidget {
  final RecordController _recordController = Get.put(RecordController());

  Recordpage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.white,
        body: Obx(
          () => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            AppBarWithBackButton(
              titleBar: "Create Record",
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Padding(
              padding: EdgeInsets.only(top: 0.02 * height, left: 0.1 * width),
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
              padding: EdgeInsets.only(top: 0.02 * height, left: 0.1 * width),
              child: Container(
                  width: 0.85 * width,
                  height: 0.07 * height,
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
                        _recordController.selectedtype.value = value!
                    // setState(() {
                    //   selectedtype = value!;
                    // })
                    ,
                    selectedItem: _recordController.selectedtype.value,
                  )),
            ),
            Padding(
              padding: EdgeInsets.only(top: 0.02 * height, left: 0.1 * width),
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
                padding: EdgeInsets.only(top: 0.02 * height, left: 0.1 * width),
                child: Container(
                  width: 0.85 * width,
                  height: 0.07 * height,
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
                        _recordController.selectedproduct.value = value!
                    // setState(() {
                    //   selectedproduct = value!;
                    // })
                    ,
                    selectedItem: _recordController.selectedproduct.value,
                  ),
                )),
            Padding(
              padding: EdgeInsets.only(top: 0.02 * height, left: 0.1 * width),
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
                padding: EdgeInsets.only(top: 0.02 * height, left: 0.1 * width),
                child: SizedBox(
                  width: 0.85 * width,
                  height: 0.07 * height,
                  child: TextFormField(
                      controller: _recordController.values.value,
                      // obscureText: true,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Color.fromRGBO(157, 157, 157, 0.5),
                            fontSize: 16,
                          ),
                          hintText: "15000000.00")),
                )),
            Padding(
              padding: EdgeInsets.only(top: 0.04 * height, left: 0.1 * width),
              child: InkWell(
                onTap: () {
                  _recordController.insertrecord();
                },
                child: Container(
                  width: width * 0.85,
                  height: height * 0.07,
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
