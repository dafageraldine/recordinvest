import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recordinvest/models/data.dart';

class AppBarWithBackButtonAndIconButton extends StatelessWidget {
  var onTapIcon;
  var onTap;
  final String titleBar;

  AppBarWithBackButtonAndIconButton(
      {super.key, this.onTapIcon, required this.titleBar, this.onTap});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));
    return Container(
      width: 1.sw,
      height: 0.12.sh,
      color: theme,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 0.1.sw),
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
            padding: EdgeInsets.only(top: 0.04.sh),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  titleBar,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: Color.fromRGBO(249, 249, 249, 1),
                  ),
                )),
          ),
          Padding(
            padding: EdgeInsets.only(top: 0.1.sw),
            child: InkWell(
              onTap: onTapIcon,
              child: Container(
                width: 0.12.sw,
                height: 0.12.sw,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)),
                child: const Icon(
                  Icons.filter_list_rounded,
                  size: 20,
                  color: Color.fromRGBO(82, 82, 82, 1),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
