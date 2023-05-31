import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recordinvest/components/app_bar_only.dart';
import 'package:recordinvest/components/appversion.dart';
import 'package:recordinvest/controller/settingcontroller.dart';
import 'package:recordinvest/models/data.dart';
import 'package:recordinvest/screens/web_view/initialpage.dart';

import '../submenu/updatestock.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({super.key});

  final SettingController _settingController = Get.put(SettingController());

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(children: [
        const AppBarOnly(
          titleBar: 'Application Settings',
        ),
        5.verticalSpace,
        Divider(
          color: Colors.grey.shade300,
          thickness: 2,
          indent: 30,
          endIndent: 30,
        ),
        Padding(
          padding: EdgeInsets.only(left: 0.1.sw),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Log Out",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600, fontSize: 14.sp)),
                    Text("Exit Application",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.normal, fontSize: 12.sp))
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(right: 0.1.sw),
                  child: InkWell(
                    onTap: () {
                      _settingController.showAlertDialog();
                    },
                    child: Container(
                      width: 0.15.sw,
                      height: 0.05.sh,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: theme,
                      ),
                      child: const Icon(Icons.exit_to_app_rounded,
                          color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        5.verticalSpace,
        Divider(
          color: Colors.grey.shade300,
          thickness: 2,
          indent: 30,
          endIndent: 30,
        ),
        Padding(
          padding: EdgeInsets.only(left: 0.1.sw),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Developer Profile",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600, fontSize: 14.sp)),
                    Text("About Developer Profile",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.normal, fontSize: 12.sp))
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(right: 0.1.sw),
                  child: InkWell(
                    onTap: () {
                      Get.to(InitialPage(
                        urlweb: 'http://dafageraldine.pythonanywhere.com/',
                        title: "Developer",
                      ));
                    },
                    child: Container(
                      width: 0.15.sw,
                      height: 0.05.sh,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: theme,
                      ),
                      child:
                          const Icon(Icons.code_rounded, color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        5.verticalSpace,
        Divider(
          color: Colors.grey.shade300,
          thickness: 2,
          indent: 30,
          endIndent: 30,
        ),
        Padding(
          padding: EdgeInsets.only(left: 0.1.sw),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Update Stock",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600, fontSize: 14.sp)),
                    Text("Update historical price data",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.normal, fontSize: 12.sp))
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(right: 0.1.sw),
                  child: InkWell(
                    onTap: () {
                      Get.to(UpdateStock());
                    },
                    child: Container(
                      width: 0.15.sw,
                      height: 0.05.sh,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: theme,
                      ),
                      child: const Icon(Icons.web_sharp, color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        5.verticalSpace,
        Divider(
          color: Colors.grey.shade300,
          thickness: 2,
          indent: 30,
          endIndent: 30,
        ),
        Padding(
          padding: EdgeInsets.only(left: 0.1.sw),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Extend Server",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600, fontSize: 14.sp)),
                    Text("Extend Webserver",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.normal, fontSize: 12.sp))
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(right: 0.1.sw),
                  child: InkWell(
                    onTap: () {
                      Get.to(InitialPage(
                        urlweb: 'https://www.pythonanywhere.com/',
                        title: 'Webserver',
                      ));
                    },
                    child: Container(
                      width: 0.15.sw,
                      height: 0.05.sh,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: theme,
                      ),
                      child: const Icon(Icons.computer_rounded,
                          color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        5.verticalSpace,
        Divider(
          color: Colors.grey.shade300,
          thickness: 2,
          indent: 30,
          endIndent: 30,
        ),
        5.verticalSpace,
        const AppVersion()
      ]),
    );
  }
}
