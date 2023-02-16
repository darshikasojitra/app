import 'package:demo_splash_screen/resources/all_colors.dart';
import 'package:demo_splash_screen/resources/all_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MaterialButtons extends StatefulWidget {
  IconData? icon;
  String buttontext;
  Color? color;
  MaterialButtons({super.key, this.icon, required this.buttontext, this.color});

  @override
  State<MaterialButtons> createState() => _MaterialButtonsState();
}

class _MaterialButtonsState extends State<MaterialButtons> {
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
