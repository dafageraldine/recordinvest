import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:recordinvest/components/app_bar_with_back_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data.dart';

class Recordpage extends StatefulWidget {
  const Recordpage({Key? key}) : super(key: key);

  @override
  State<Recordpage> createState() => _RecordpageState();
}

class _RecordpageState extends State<Recordpage> {
  var selectedtype, selectedproduct;
  TextEditingController values = TextEditingController();

  Future insertrecord() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? id = prefs.getString('id');
      var body = {
        "type": selectedtype,
        "product": selectedproduct,
        "value": values.text,
        "id": id
      };
      http.Response postdata =
          await http.post(Uri.parse(baseurl + "insertrecord"), body: body);
      var data = json.decode(postdata.body);
      if (data["message"] == "data has been added") {
        list_cb_data.clear();
        combobox.clear();
        Fluttertoast.showToast(
            msg: "data has been added",
            backgroundColor: Colors.black,
            textColor: Colors.white);
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(
          msg: e.toString(),
          backgroundColor: Colors.black,
          textColor: Colors.white);
    }
  }

  @override
  void initState() {
    selectedtype = comboboxtype[0];
    selectedproduct = comboboxproduct[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        AppBarWithBackButton(
          titleBar: "Create Record",
          onTap: () {
            Navigator.pop(context);
          },
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
                onChanged: (value) => setState(() {
                  selectedtype = value!;
                }),
                selectedItem: selectedtype,
              )),
        ),
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
                onChanged: (value) => setState(() {
                  selectedproduct = value!;
                }),
                selectedItem: selectedproduct,
              ),
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
                  controller: values,
                  // obscureText: true,
                  decoration: InputDecoration(
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
              insertrecord();
            },
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
