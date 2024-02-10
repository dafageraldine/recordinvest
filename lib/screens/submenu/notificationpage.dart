import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:recordinvest/models/data.dart';

import '../../components/app_bar_with_back_button.dart';
import '../../controller/homecontroller.dart';

class NotificationPage extends StatelessWidget {
  NotificationPage({super.key});
  final HomeController _homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppBarWithBackButton(
            titleBar: "Notifications",
            onTap: () {
              Get.back();
            },
          ),
          Obx(() => _homeController.listNotif.isEmpty
              ? Padding(
                  padding: EdgeInsets.only(top: 0.1.sh),
                  child: Center(
                      child: Column(
                    children: [
                      Lottie.asset('assets/empty.json', width: 0.5.sw),
                      Padding(
                        padding: const EdgeInsets.only(top: 25),
                        child: Text("Tidak Ada Notif",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              fontSize: 15.sp,
                              color: Colors.grey.shade600,
                            )),
                      ),
                    ],
                  )),
                )
              : SizedBox(
                  height: 0.88.sh,
                  child: ListView.builder(
                    itemBuilder: (c, i) {
                      return notificationsItem(
                        _homeController.listNotif[i].title,
                        _homeController.listNotif[i].msg,
                        _homeController.listNotif[i].date,
                      );
                    },
                    itemCount: _homeController.listNotif.length,
                    physics: const BouncingScrollPhysics(),
                  ),
                ))
        ],
      ),
    );
  }

  Widget notificationsItem(
      String titleNotif, String msgNotif, String tglNotif) {
    return SizedBox(
      width: 1.sw,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15.0, top: 5),
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                    color: themewithopacity, shape: BoxShape.circle),
                child: Icon(
                  Icons.notifications_none_rounded,
                  color: theme,
                  size: 0.05.sw,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, top: 5),
              child: Text(titleNotif,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                    color: Colors.grey.shade600,
                  )),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(left: 0.15.sw, top: 5, right: 20),
          child: Text(msgNotif,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.normal,
                fontSize: 12.sp,
                color: Colors.grey.shade600,
              )),
        ),
        Padding(
          padding: EdgeInsets.only(left: 0.15.sw, top: 5, right: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(tglNotif,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 12.sp,
                    color: Colors.grey.shade400,
                  )),
              InkWell(
                onTap: () {
                  _homeController.showAlertDialog(() {
                    _homeController.deleteNotif();
                    Get.back();
                  }, "Konfirmasi Hapus",
                      "Apakah anda ingin hapus notifikasi ?");
                },
                child: Icon(
                  Icons.delete,
                  color: Colors.grey.shade700,
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Divider(
          thickness: 2,
          color: Colors.grey.shade300,
        )
      ]),
    );
  }
}
