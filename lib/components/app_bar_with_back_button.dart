import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recordinvest/models/data.dart';

class AppBarWithBackButton extends StatelessWidget {
  final String titleBar;
  var onTap;

  AppBarWithBackButton({super.key, required this.titleBar, this.onTap});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));
    return Container(
      width: 1.sw,
      height: 0.12.sh,
      // color: Color.fromRGBO(217, 215, 241, 1),
      color: theme,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 0.1.sw, top: 0.1.sw),
            child: InkWell(
              onTap: onTap,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                ),
                width: 0.125.sw,
                height: 0.125.sw,
                child: Icon(
                  Icons.arrow_back_ios_new,
                  color: theme,
                  size: 0.06.sw,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 0.08.sw, left: 0.05.sw),
            child: Align(
                alignment: Alignment.center,
                child: Text(
                  titleBar,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    // color: Color.fromRGBO(104, 103, 172, 1),
                    color: Color.fromRGBO(249, 249, 249, 1),
                    // color: Color.fromRGBO(246, 198, 234, 1),
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
