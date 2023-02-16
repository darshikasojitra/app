import 'package:demo_splash_screen/resources/all_colors.dart';
import 'package:demo_splash_screen/resources/all_images.dart';
import 'package:demo_splash_screen/resources/all_style.dart';
import 'package:demo_splash_screen/resources/string_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomnavigationbarContaineer extends StatelessWidget {
  const BottomnavigationbarContaineer({super.key, required this.total});
  final int total;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 10.h),
      child: Container(
        height: 33.h,
        width: 350.w,
        decoration: BoxDecoration(
            color: AllColors.maincolor,
            borderRadius: BorderRadius.circular(40.r)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 40.w, right: 20.w),
              child: Icon(
                Icons.list,
                color: AllColors.white,
                size: 26.sp,
              ),
            ),
            Container(
                height: 32.h,
                width: 110.w,
                decoration: BoxDecoration(
                    color: AllColors.white,
                    borderRadius: BorderRadius.circular(40.r)),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: 17.w, top: 7.h, bottom: 6.h, right: 6.w),
                      child: Image.asset(
                        AllImages.cart,
                        height: 26.h,
                        width: 20.w,
                      ),
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 10.0.h),
                          child: Row(
                            children: [
                              Text(StringManager.total,
                                  style: regularTextStyle(
                                    color: AllColors.prize,
                                    fontSize: 11.sp,
                                  )),
                              SizedBox(
                                width: 2.w,
                              ),
                              Text(
                                '$total₹',
                                style: regularTextStyle(
                                  color: AllColors.black,
                                  fontSize: 13.sp,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
            Padding(
              padding: EdgeInsets.only(
                  left: 5.w, top: 10.h, bottom: 10.h, right: 20.w),
              child: Text(
                StringManager.buythelist,
                style: boldTextStyle(
                  color: AllColors.white,
                  fontSize: 13.sp,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
