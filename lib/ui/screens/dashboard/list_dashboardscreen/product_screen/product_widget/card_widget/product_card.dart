import 'package:demo_splash_screen/l10n/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:demo_splash_screen/resources/resources.dart';
import 'package:demo_splash_screen/ui/screens/dashboard/dashboard.dart';

// ignore: must_be_immutable
class ProductCard extends StatefulWidget {
  final String image;
  final String pname;
  final String pid;
  final String desc;
  final int prize;
  int quantity = 0;
  final Function() onTapminus;
  final Function() onTapplus;
  ProductCard({
    super.key,
    required this.image,
    required this.pname,
    required this.pid,
    required this.prize,
    required this.desc,
    required this.onTapminus,
    required this.onTapplus,
    required this.quantity,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.r)),
      ),
      child: Row(
        children: [
          ProductImage(
            image: widget.image,
          ),
          Padding(
            padding: EdgeInsets.only(left: 6.0.h),
            child: Padding(
              padding: EdgeInsets.only(
                left: 5.w,
                right: 5.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      top: 10.h,
                    ),
                    child: Image.asset(
                      AllImages.tesco,
                      fit: BoxFit.cover,
                      height: 17.h,
                      width: 70.w,
                    ),
                  ),
                  sizedBoxSpacer(height: 8.h),
                  Text(widget.pname),
                  Row(
                    children: [
                      Text(widget.pid),
                      sizedBoxSpacer(width: 160.w),
                      Text(AppLocalizations.of(context)!.kg)
                    ],
                  ),
                  sizedBoxSpacer(height: 6.h),
                  Row(
                    children: [
                      Text(
                        StringManager.text500g,
                        style: regularTextStyle(
                            color: AllColors.prize, fontSize: 12.sp),
                      ),
                      sizedBoxSpacer(width: 120.w),
                      Text(
                        '${widget.prize}₹',
                        style: boldTextStyle(
                          fontSize: 15.sp,
                          color: AllColors.maincolor,
                        ),
                      )
                    ],
                  ),
                  sizedBoxSpacer(height: 6.h),
                  Text(
                    widget.desc,
                    style: regularTextStyle(
                        color: AllColors.desc, fontSize: 12.sp),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: 130.w, bottom: 5.h, top: 10.h),
                        child: Container(
                          height: 20.h,
                          width: 90.w,
                          decoration: BoxDecoration(
                              color: AllColors.slidable,
                              borderRadius: BorderRadius.circular(20.r)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  widget.onTapminus();
                                },
                                child: Icon(
                                  Icons.remove_circle_outline,
                                  color: AllColors.maincolor,
                                ),
                              ),
                              Text(widget.quantity >= 0
                                  ? widget.quantity.toString()
                                  : '0'),
                              GestureDetector(
                                onTap: () {
                                  widget.onTapplus();
                                },
                                child: Icon(
                                  Icons.add_circle_outline,
                                  color: AllColors.maincolor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

SizedBox sizedBoxSpacer({double? height, double? width}) {
  return SizedBox(
    height: height,
    width: width,
  );
}
