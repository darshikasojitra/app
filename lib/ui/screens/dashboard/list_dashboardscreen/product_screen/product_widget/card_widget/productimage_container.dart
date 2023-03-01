import 'package:demo_splash_screen/l10n/localization.dart';
import 'package:demo_splash_screen/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:demo_splash_screen/ui/screens/dashboard/dashboard.dart';

class ProductImage extends StatefulWidget {
  final String image;
  const ProductImage({
    super.key,
    required this.image,
  });

  @override
  State<ProductImage> createState() => _ProductImageState();
}

class _ProductImageState extends State<ProductImage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 139.h,
          width: 91.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10.r),
                topLeft: Radius.circular(10.r)),
            image: DecorationImage(
              image: NetworkImage(
                widget.image.toString(),
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Align(
              alignment: Alignment.bottomRight,
              child: Container(
                  margin: EdgeInsets.all(5.h),
                  height: 15.h,
                  width: 35.w,
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(40.r)),
                  child: Row(
                    children: [
                      Padding(padding: EdgeInsets.only(top: 5.h, bottom: 5.h)),
                      Icon(
                        Icons.star,
                        size: 13.sp,
                        color: AllColors.maincolor,
                      ),
                      sizedBoxSpacer(height: 3.w),
                      Text(
                        AppLocalizations.of(context)!.ratingtext,
                        style: regularTextStyle(
                          color: AllColors.totals,
                          fontSize: 10.sp,
                        ),
                      ),
                    ],
                  ))),
        ),
        Positioned(
            right: 13.w,
            child: Container(
              height: 15.h,
              width: 78.w,
              alignment: Alignment.topLeft,
              decoration: BoxDecoration(
                  color: AllColors.fontcolor,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(20.r),
                      topLeft: Radius.circular(10.r))),
              child: Padding(
                padding: EdgeInsets.only(left: 5.w, top: 2.h),
                child: Text(
                  AppLocalizations.of(context)!.discount,
                  style:
                      regularTextStyle(fontSize: 10.sp, color: AllColors.white),
                ),
              ),
            ))
      ],
    );
  }
}
