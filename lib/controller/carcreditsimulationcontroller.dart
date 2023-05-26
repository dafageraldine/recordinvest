import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:recordinvest/screens/submenu/hasilsimulasi.dart';

class CarCreditSimulationController extends GetxController {
  Rx<TextEditingController> bunga = TextEditingController().obs;
  Rx<TextEditingController> tenor = TextEditingController().obs;
  Rx<TextEditingController> otr = TextEditingController().obs;
  Rx<TextEditingController> dp = TextEditingController().obs;
  var finalplafonpinjaman = 0.0.obs,
      finalangsuranpokok = 0.0.obs,
      finalangsuranbunga = 0.0.obs,
      finalangsuranakhir = 0.0.obs;

  void calculate() {
    try {
      var hargaotr = int.tryParse(otr.value.text);
      var dpmobil = double.tryParse(dp.value.text)!;
      var tenorcicilan = int.tryParse(tenor.value.text);
      var bungacicilan = int.tryParse(bunga.value.text);
      var plafonpinjaman = hargaotr! - dpmobil;
      var angsuranpokok = plafonpinjaman / (tenorcicilan! * 12);
      var angsuranbunga = (plafonpinjaman * (bungacicilan! / 100)) / 12;
      var angsuranakhir = angsuranpokok + angsuranbunga;

      finalplafonpinjaman.value = plafonpinjaman.toDouble();
      finalangsuranpokok.value = angsuranpokok;
      finalangsuranbunga.value = angsuranbunga;
      finalangsuranakhir.value = angsuranakhir;
      Get.to(HasilSimulasi(
          finalplafonpinjaman.value,
          finalangsuranpokok.value,
          finalangsuranbunga.value,
          finalangsuranakhir.value,
          hargaotr,
          dpmobil,
          tenorcicilan,
          bungacicilan));
    } catch (e) {
      Fluttertoast.showToast(
          msg: "masukkan data yang valid !",
          backgroundColor: Colors.black,
          textColor: Colors.white);
    }
  }
}
