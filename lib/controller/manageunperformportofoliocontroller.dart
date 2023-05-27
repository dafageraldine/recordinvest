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
          await http.post(Uri.parse("${baseurl}get_latest_asset"), body: body);
      print(postdata.body);
      var data = json.decode(postdata.body);
      for (int i = 0; i < data["data"].length; i++) {
        list_cb_data.add(ComboBoxData(data["data"][i]["date"],
            data["data"][i]["value"].toString(), data["data"][i]["product"]));
      }
      list_cb_data.sort(((a, b) => a.product.compareTo(b.product)));
      print("length : ${list_cb_data.length}");
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
    var floatingLoss = double.parse(floss.value.text.toString());
    var uangInvestAwal = double.parse(mi.value.text.toString());
    var hargaSaatIni = double.parse(prn.value.text.toString());
    var unitDimiliki = double.parse(aih.value.text.toString());
    var desiredLoss = double.parse(dl.value.text.toString());
    var assetSwitchNow = double.parse(tais.value.text.toString());
    var returnSwitchPercent = double.parse(rsia.value.text.toString());
    var floatingLossInPercent =
        (floatingLoss * kurs_ / (uangInvestAwal * kurs_)) * 100;
    var assetAkhir = (100 / desiredLoss) * (kurs_ * floatingLoss);
    var uangHarusDiinvest = assetAkhir - (uangInvestAwal * kurs_);
    var hargabep = (assetAkhir /
            (unitDimiliki +
                (uangHarusDiinvest / (hargaSaatIni * kurs_)))) /
        kurs_;
    var upPercent = ((hargabep - hargaSaatIni) / hargaSaatIni) * 100;
    var returnPerhariSwitchMoney =
        (assetSwitchNow + (kurs_ * (uangInvestAwal - floatingLoss))) *
            (returnSwitchPercent / 100);
    var estimatedDay = (floatingLoss * kurs_) / returnPerhariSwitchMoney;
    var estimatedMonth = estimatedDay / 30;
    Get.to(HasilSimulasiPorto(
        uangInvestAwal * kurs_,
        floatingLoss * kurs_,
        floatingLossInPercent,
        desiredLoss,
        assetSwitchNow,
        returnSwitchPercent,
        uangHarusDiinvest,
        estimatedDay,
        estimatedMonth,
        hargabep,
        upPercent,
        hargaSaatIni));
  }

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
                    color: const Color.fromRGBO(144, 200, 172, 1),
                    borderRadius: BorderRadius.circular(10)),
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
