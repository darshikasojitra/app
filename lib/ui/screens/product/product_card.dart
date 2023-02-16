import 'package:demo_splash_screen/resources/all_colors.dart';
import 'package:demo_splash_screen/resources/all_images.dart';
import 'package:demo_splash_screen/resources/all_style.dart';
import 'package:demo_splash_screen/resources/string_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductCard extends StatefulWidget {
  String image;
  String pname;
  String pid;
  String desc;
  String? prize;
  String? quantity;
  Function()? onTapminus;
  Function()? onTapplus;
  ProductCard({
    super.key,
    required this.image,
    required this.pname,
    required this.pid,
    this.prize,
    required this.desc,
    this.onTapminus,
    this.onTapplus,
    this.quantity,
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
          Container(
            height: 139.h,
            width: 92.w,
            
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10.r),topLeft: Radius.circular(10.r)),
              image: DecorationImage(
                image: NetworkImage(widget.image.toString(),),
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
                        Padding(
                            padding: EdgeInsets.only(top: 5.h, bottom: 5.h)),
                        Icon(
                          Icons.star,
                          size: 13.sp,
                          color: AllColors.maincolor,
                        ),
                        SizedBox(
                          width: 3.w,
                        ),
                        Text(
                          StringManager.ratingtext,
                          style: regularTextStyle(
                            color: AllColors.totals,
                            fontSize: 10.sp,
                          ),
                        ),
                      ],
                    ))),
          ),
          Padding(
            padding: EdgeInsets.only(left: 6.0.h),
            child: Padding(
          padding: EdgeInsets.only(left:5,right: 5,),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.only( top: 10.h,),
                    child: Image.asset(
                      AllImages.tesco,
                      fit: BoxFit.cover,
                      height: 17.h,
                      width: 70.w,
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Text(widget.pname),
                  Row(
                    children: [
                      Text(widget.pid),
                      SizedBox(
                        width: 165.w,
                      ),
                      const Text(StringManager.kg)
                    ],
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  Row(
                    children: [
                      Text(
                        '(500 g - 10₹)',
                        style: regularTextStyle(color: AllColors.prize,fontSize: 12.sp),
                      ),
                      SizedBox(
                        width: 120.w,
                      ),
                      Text(
                        '${widget.prize}₹',
                        style: boldTextStyle(
                          fontSize: 15.sp,
                          color: AllColors.maincolor,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  Text(
                    widget.desc,
                    style: regularTextStyle(color: AllColors.desc,fontSize: 12.sp),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.only(left: 130.w, bottom: 5.h, top: 10.h),
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
                                onTap: widget.onTapminus,
                                child: Icon(
                                  Icons.remove_circle_outline,
                                  color: AllColors.maincolor,
                                ),
                              ),
                              Text(widget.quantity.toString()),
                              GestureDetector(
                                onTap: widget.onTapplus,
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
