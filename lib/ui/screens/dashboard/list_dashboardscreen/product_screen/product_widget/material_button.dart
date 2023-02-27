import 'package:demo_splash_screen/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class CustomMaterialButtons extends StatefulWidget {
  IconData? icon;
  String buttontext;
  Color? color;
  CustomMaterialButtons({super.key, this.icon, required this.buttontext, this.color});

  @override
  State<CustomMaterialButtons> createState() => _CustomMaterialButtonsState();
}

class _CustomMaterialButtonsState extends State<CustomMaterialButtons> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: widget.color,
      onPressed: () {},
      height: 30.h,
      minWidth: 157.w,
      shape: RoundedRectangleBorder(
          side: BorderSide(color: AllColors.maincolor, width: 1.w),
          borderRadius: BorderRadius.circular(40.r)),
      child: Row(
        children: [
          Icon(
            widget.icon,
            size: 20.sp,
            color: AllColors.maincolor,
          ),
          SizedBox(
            width: 10.w,
          ),
          Text(
            widget.buttontext,
            style: boldTextStyle(color: AllColors.maincolor, fontSize: 14.sp),
          ),
        ],
      ),
    );
  }
}
