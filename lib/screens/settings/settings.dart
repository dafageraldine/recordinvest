import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recordinvest/components/app_bar_only.dart';
import 'package:recordinvest/components/appversion.dart';
import 'package:recordinvest/components/listsetting.dart';
import 'package:recordinvest/controller/settingcontroller.dart';
import 'package:recordinvest/models/data.dart';
import 'package:recordinvest/screens/camera/camera.dart';
import 'package:recordinvest/screens/web_view/initialpage.dart';

import '../submenu/updatestock.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({super.key});
  int counter = 0;
  final SettingController _settingController = Get.put(SettingController());

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(children: [
        const AppBarOnly(titleBar: 'Application Settings'),
        5.verticalSpace,
        Divider(
          color: Colors.grey.shade300,
          thickness: 2,
          indent: 30,
          endIndent: 30,
        ),
        ListSetting(
            ontap: () {
              _settingController.showAlertDialog(() async {
                _settingController.logout();
              }, "Warning", "Do you want to log out ?");
            },
            title: "Log Out",
            icon: Icons.exit_to_app_rounded,
            desc: "Exit Application"),
        5.verticalSpace,
        Divider(
          color: Colors.grey.shade300,
          thickness: 2,
          indent: 30,
          endIndent: 30,
        ),
        ListSetting(
          ontap: () {
            Get.to(InitialPage(
              urlweb: 'http://dafageraldine.pythonanywhere.com/',
              title: "Developer",
            ));
          },
          title: "Developer Profile",
          desc: "About Developer Profile",
          icon: Icons.code_rounded,
        ),
        5.verticalSpace,
        Divider(
          color: Colors.grey.shade300,
          thickness: 2,
          indent: 30,
          endIndent: 30,
        ),
        ListSetting(
          ontap: () {
            Get.to(UpdateStock());
          },
          title: "Update Stock",
          desc: "Update historical price data",
          icon: Icons.web_sharp,
        ),
        5.verticalSpace,
        Divider(
          color: Colors.grey.shade300,
          thickness: 2,
          indent: 30,
          endIndent: 30,
        ),
        ListSetting(
          ontap: () {
            Get.to(InitialPage(
              urlweb: 'https://www.pythonanywhere.com/',
              title: 'Webserver',
            ));
          },
          title: "Extend Server",
          desc: "Extend Webserver",
          icon: Icons.computer_rounded,
        ),
        5.verticalSpace,
        Divider(
          color: Colors.grey.shade300,
          thickness: 2,
          indent: 30,
          endIndent: 30,
        ),
        ListSetting(
          ontap: () {
            Get.to(InitialPage(
              urlweb: 'https://dafageraldine.pythonanywhere.com/webview',
              title: 'Other Menu',
            ));
          },
          title: "Other Menu",
          desc: "Access Webview Menu",
          icon: Icons.link_sharp,
        ),
        5.verticalSpace,
        Divider(
          color: Colors.grey.shade300,
          thickness: 2,
          indent: 30,
          endIndent: 30,
        ),
        5.verticalSpace,
        InkWell(
            onTap: () {
              if (counter > 3) {
                counter = 0;
                SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
                    overlays: []);
                Get.to(const CameraApp());
                return;
              }
              counter++;
            },
            child: const AppVersion())
      ]),
    );
  }
}
