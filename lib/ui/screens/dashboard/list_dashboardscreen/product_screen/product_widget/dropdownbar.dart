import 'package:demo_splash_screen/resources/resources.dart';
import 'package:demo_splash_screen/ui/screens/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DropDownBar extends StatelessWidget {
  const DropDownBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          AllImages.tesco,
          fit: BoxFit.cover,
          height: 17.h,
          width: 70.w,
        ),
        Icon(
          Icons.arrow_drop_down,
          color: AllColors.maincolor,
          size: 17.sp,
        ),
        sizedBoxSpacer(width: 175.w,),
        Icon(
          Icons.people,
          color: AllColors.maincolor,
        ),
        sizedBoxSpacer(width: 12.w),
        Padding(
          padding:
              EdgeInsets.only(left: 5.w, top: 17.h, bottom: 17.h, right: 17.w),
          child: Icon(
            Icons.share,
            color: AllColors.maincolor,
          ),
        )
      ],
    );
  }
}
