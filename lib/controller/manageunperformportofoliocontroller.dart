import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:recordinvest/screens/submenu/hasilsimulasiporto.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../models/comboboxdata.dart';
import '../models/data.dart';

class ManageUnperformPortofolioController extends GetxController {
  Rx<TextEditingController> floss = TextEditingController().obs;
  Rx<TextEditingController> kurs = TextEditingController().obs;
  Rx<TextEditingController> mi = TextEditingController().obs;
  Rx<TextEditingController> dl = TextEditingController().obs;
  Rx<TextEditingController> prn = TextEditingController().obs;
  Rx<TextEditingController> aih = TextEditingController().obs;
  Rx<TextEditingController> tais = TextEditingController().obs;
  Rx<TextEditingController> rsia = TextEditingController().obs;
  var selectedpilihan = "".obs;

  Future get_cb_data() async {
    try {
      list_cb_data.clear();
      combobox.clear();
      final prefs = await SharedPreferences.getInstance();
      final String? id = prefs.getString('id');
      var body = {"id": id};
      http.Response postdata =
          await http.post(Uri.parse(baseurl + "get_latest_asset"), body: body);
      print(postdata.body);
      var data = json.decode(postdata.body);
      for (int i = 0; i < data["data"].length; i++) {
        list_cb_data.add(ComboBoxData(data["data"][i]["date"],
            data["data"][i]["value"].toString(), data["data"][i]["product"]));
      }
      list_cb_data.sort(((a, b) => a.product.compareTo(b.product)));
      print("length : " + list_cb_data.length.toString());
      for (int i = 0; i < list_cb_data.length; i++) {
        combobox.add(list_cb_data[i].product);
      }
      selectedpilihan.value = list_cb_data[0].product;
      showcb();
    } catch (e) {
      Fluttertoast.showToast(
          msg: e.toString(),
          backgroundColor: Colors.black,
          textColor: Colors.white);
    }
  }

  void calculate() {
    var kurs_ = double.parse(kurs.value.text.toString());
    var floating_loss = double.parse(floss.value.text.toString());
    var uang_invest_awal = double.parse(mi.value.text.toString());
    var harga_saat_ini = double.parse(prn.value.text.toString());
    var unit_dimiliki = double.parse(aih.value.text.toString());
    var desired_loss = double.parse(dl.value.text.toString());
    var asset_switch_now = double.parse(tais.value.text.toString());
    var return_switch_percent = double.parse(rsia.value.text.toString());
    var floating_loss_in_percent =
        (floating_loss * kurs_ / (uang_invest_awal * kurs_)) * 100;
    var asset_akhir = (100 / desired_loss) * (kurs_ * floating_loss);
    var uang_harus_diinvest = asset_akhir - (uang_invest_awal * kurs_);
    var hargabep = (asset_akhir /
            (unit_dimiliki +
                (uang_harus_diinvest / (harga_saat_ini * kurs_)))) /
        kurs_;
    var up_percent = ((hargabep - harga_saat_ini) / harga_saat_ini) * 100;
    var return_perhari_switch_money =
        (asset_switch_now + (kurs_ * (uang_invest_awal - floating_loss))) *
            (return_switch_percent / 100);
    var estimated_day = (floating_loss * kurs_) / return_perhari_switch_money;
    var estimated_month = estimated_day / 30;
    Get.to(HasilSimulasiPorto(
        uang_invest_awal * kurs_,
        floating_loss * kurs_,
        floating_loss_in_percent,
        desired_loss,
        asset_switch_now,
        return_switch_percent,
        uang_harus_diinvest,
        estimated_day,
        estimated_month,
        hargabep,
        up_percent,
        harga_saat_ini));
  }

  void showcb() {
    // flutter defined function
    Get.dialog(Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Container(
        width: Get.width * 0.85,
        height: 0.3 * Get.height,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: 0.1 * Get.width, top: 0.05 * Get.height),
              child: Align(
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
            SizedBox(height: 10),
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
                    onChanged: (value) => selectedpilihan.value = value!
                    // setState(() {
                    //   selectedpilihan = value!;
                    // })
                    ,
                    selectedItem: selectedpilihan.value,
                  )),
            ),
            InkWell(
              onTap: () {
                for (var i = 0; i < list_cb_data.length; i++) {
                  if (selectedpilihan == list_cb_data[i].product) {
                    tais.value.text = list_cb_data[i].value;
                    break;
                  }
                }
                Get.back();
              },
              child: Container(
                width: 0.7 * Get.width,
                height: 0.07 * Get.height,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(144, 200, 172, 1),
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                    child: Text(
                  "Select",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                )),
              ),
            ),
            SizedBox(
              height: 15,
            )
          ],
        ),
      ),
    ));
  }
}
