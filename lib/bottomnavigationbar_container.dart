import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_splash_screen/resources/all_colors.dart';
import 'package:demo_splash_screen/resources/all_images.dart';
import 'package:demo_splash_screen/resources/all_string.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomnavigationbarContaineer extends StatelessWidget {
  const BottomnavigationbarContaineer({super.key});

  @override
  Widget build(BuildContext context) {
    
    var _totals = 0;
//DatabaseReference pref = FirebaseDatabase.instance.ref("wishlist");
 
    return Padding(
      padding: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 10.h),
      child: Container(
        height: 33.h,
        width: 350.w,
        decoration: BoxDecoration(
            color: AllColors.maincolor,
            borderRadius: BorderRadius.circular(40)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 40.w, right: 20.w),
              child: Icon(
                Icons.list,
                color: AllColors.white,
                size: 30,
              ),
            ),
            Container(
                height: 32.h,
                width: 110.w,
                decoration: BoxDecoration(
                    color: AllColors.white,
                    borderRadius: BorderRadius.circular(40)),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: 17.w, top: 7.h, bottom: 6.h, right: 10.w),
                      child: Image.asset(
                        AllImages.cart,
                        height: 26.h,
                        width: 20.w,
                      ),
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 3.0.h),
                          child: Row(
                            children: [
                              Text(AllStrings.total,
                                  style: TextStyle(
                                      color: AllColors.prize, fontSize: 12)),
                              SizedBox(
                                width: 2.w,
                              ),
                              Text('200',
                               // "$totals",
                                style: TextStyle(
                                    color: AllColors.black, fontSize: 12),
                              )
                            ],
                          ),
                        ),
                        Text(
                          '£2000',
                          style: TextStyle(
                              color: AllColors.maincolor,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                )),
            Padding(
              padding: EdgeInsets.only(
                  left: 5.w, top: 10.h, bottom: 10.h, right: 17.w),
              child: Text(
                AllStrings.buythelist,
                style: TextStyle(
                    color: AllColors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}
