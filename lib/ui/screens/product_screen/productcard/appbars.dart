import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../resources/resources.dart';

AppBar appbar(BuildContext context, Function() onTap, String text,
    Color backgroundcolor) {
  return AppBar(
    leading: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.only(left: 10.w),
          child: Icon(
            Icons.arrow_back,
            color: AllColors.black,
          ),
        )),
    leadingWidth: 30,
    backgroundColor: backgroundcolor,
    title: Text(
      text,
      style: regularTextStyle(color: AllColors.black, fontSize: 16.sp),
    ),
  );
}
