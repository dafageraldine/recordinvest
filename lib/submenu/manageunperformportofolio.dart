import 'package:flutter/material.dart';
import 'package:recordinvest/submenu/hasilsimulasiporto.dart';

class ManageUnperformPortofolio extends StatefulWidget {
  const ManageUnperformPortofolio({super.key});

  @override
  State<ManageUnperformPortofolio> createState() =>
      _ManageUnperformPortofolioState();
}

class _ManageUnperformPortofolioState extends State<ManageUnperformPortofolio> {
  TextEditingController floss = TextEditingController();
  TextEditingController kurs = TextEditingController();
  TextEditingController mi = TextEditingController();
  TextEditingController dl = TextEditingController();
  TextEditingController prn = TextEditingController();
  TextEditingController aih = TextEditingController();
  TextEditingController tais = TextEditingController();
  TextEditingController rsia = TextEditingController();
  var message = "";

  void calculate() {
    var kurs_ = double.parse(kurs.text.toString());
    var floating_loss = double.parse(floss.text.toString());
    var uang_invest_awal = double.parse(mi.text.toString());
    var harga_saat_ini = double.parse(prn.text.toString());
    var unit_dimiliki = double.parse(aih.text.toString());
    var desired_loss = double.parse(dl.text.toString());
    var asset_switch_now = double.parse(tais.text.toString());
    var return_switch_percent = double.parse(rsia.text.toString());
    var floating_loss_in_percent =
        (((uang_invest_awal * kurs_) - (floating_loss * kurs_)) /
                (uang_invest_awal * kurs_)) *
            100;
    var asset_akhir = (100 / desired_loss) * (kurs_ * floating_loss);
    var uang_harus_diinvest = asset_akhir - uang_invest_awal;
    var hargabep =
        asset_akhir / (unit_dimiliki + (uang_harus_diinvest / harga_saat_ini));
    var up_percent = ((hargabep - harga_saat_ini) / harga_saat_ini) * 100;
    var return_perhari_switch_money =
        (asset_switch_now + (kurs_ * (uang_invest_awal - floating_loss))) *
            (return_switch_percent / 100);
    var estimated_day = (floating_loss * kurs_) / return_perhari_switch_money;
    var estimated_month = estimated_day / 30;
    message = "invet lagi sebesar " +
        uang_harus_diinvest.toStringAsFixed(3) +
        " dan berharap harga naik ke " +
        hargabep.toStringAsFixed(3) +
        "/unit (" +
        up_percent.toStringAsFixed(3) +
        " %) atau jual dan taruh di produk switch dengan estimasi menunggu hingga BEP selama " +
        estimated_month.toStringAsFixed(3) +
        " bulan( " +
        estimated_day.toStringAsFixed(3) +
        " hari)";
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HasilSimulasiPorto(
                uang_invest_awal,
                floating_loss,
                floating_loss_in_percent,
                desired_loss,
                asset_switch_now,
                return_switch_percent,
                uang_harus_diinvest,
                estimated_day,
                estimated_month)));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            width: width,
            height: height * 0.12,
            // color: Color.fromRGBO(217, 215, 241, 1),
            color: Color.fromRGBO(144, 200, 172, 1),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(left: 0.05 * width, top: 0.04 * height),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Manage Unperform Portofolio",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          // color: Color.fromRGBO(104, 103, 172, 1),
                          color: Color.fromRGBO(249, 249, 249, 1),
                          // color: Color.fromRGBO(246, 198, 234, 1),
                        ),
                      )),
                ),
                SizedBox(
                  width: width * 0.325,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 0.025 * height,
          ),
          Padding(
            padding: EdgeInsets.only(top: 0.02 * height, left: 0.1 * width),
            child: Text(
              "Floating loss(money)",
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
                    controller: floss,
                    // obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(157, 157, 157, 0.5),
                          fontSize: 16,
                        ),
                        hintText: "15.8")),
              )),
          Padding(
            padding: EdgeInsets.only(top: 0.02 * height, left: 0.1 * width),
            child: Text(
              "Kurs",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Color.fromRGBO(157, 157, 157, 1),
                fontSize: 16,
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(top: 0.02 * height, left: 0.1 * width),
              child: Row(
                children: [
                  Container(
                    width: 0.85 * width,
                    height: 0.07 * height,
                    child: TextFormField(
                        controller: kurs,
                        // obscureText: true,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Color.fromRGBO(157, 157, 157, 0.5),
                              fontSize: 16,
                            ),
                            hintText: "15500")),
                  ),
                ],
              )),
          Padding(
            padding: EdgeInsets.only(top: 0.02 * height, left: 0.1 * width),
            child: Text(
              "Money Invested",
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
                    controller: mi,
                    // obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(157, 157, 157, 0.5),
                          fontSize: 16,
                        ),
                        hintText: "100")),
              )),
          Padding(
            padding: EdgeInsets.only(top: 0.02 * height, left: 0.1 * width),
            child: Text(
              "Desired loss in (%)",
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
                    controller: dl,
                    // obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(157, 157, 157, 0.5),
                          fontSize: 16,
                        ),
                        hintText: "5")),
              )),
          Padding(
            padding: EdgeInsets.only(top: 0.02 * height, left: 0.1 * width),
            child: Text(
              "Price right now",
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
                    controller: prn,
                    // obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(157, 157, 157, 0.5),
                          fontSize: 16,
                        ),
                        hintText: "20")),
              )),
          Padding(
            padding: EdgeInsets.only(top: 0.02 * height, left: 0.1 * width),
            child: Text(
              "Assets in hand (in units)",
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
                    controller: aih,
                    // obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(157, 157, 157, 0.5),
                          fontSize: 16,
                        ),
                        hintText: "5")),
              )),
          Padding(
            padding: EdgeInsets.only(top: 0.02 * height, left: 0.1 * width),
            child: Text(
              "Total assets in switch",
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
                    controller: tais,
                    // obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(157, 157, 157, 0.5),
                          fontSize: 16,
                        ),
                        hintText: "20000000")),
              )),
          Padding(
            padding: EdgeInsets.only(top: 0.02 * height, left: 0.1 * width),
            child: Text(
              "return switch in a day(%)",
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
                    controller: rsia,
                    // obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(157, 157, 157, 0.5),
                          fontSize: 16,
                        ),
                        hintText: "0.02")),
              )),
          Padding(
            padding: EdgeInsets.only(
                top: 0.04 * height, left: 0.1 * width, bottom: 0.025 * height),
            child: InkWell(
              onTap: () {
                calculate();
                // inserttypenproduct();
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
                    "Calculate",
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
      ),
    );
  }
}
