import 'package:demo_splash_screen/l10n/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:demo_splash_screen/resources/resources.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  int newquantity =0;
  void setquantity() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setInt('getquantity', widget.quantity);
    });
  }
  void getquantity() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
       String? savedvalue = prefs.getString("getquantity");
       if(savedvalue!=null){
    widget.quantity = savedvalue as int;
  }
    });
  }
  @override
  void initState(){
    super.initState();
    getquantity();
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.r)),
      ),
      child: Row(
        children: [
          Stack(
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
                            Padding(
                                padding:
                                    EdgeInsets.only(top: 5.h, bottom: 5.h)),
                            Icon(
                              Icons.star,
                              size: 13.sp,
                              color: AllColors.maincolor,
                            ),
                            SizedBox(
                              width: 3.w,
                            ),
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
                        style: regularTextStyle(
                            fontSize: 10.sp, color: AllColors.white),
                      ),
                    ),
                  ))
            ],
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
                      Text(AppLocalizations.of(context)!.kg)
                    ],
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  Row(
                    children: [
                      Text(
                        StringManager.text500g,
                        style: regularTextStyle(
                            color: AllColors.prize, fontSize: 12.sp),
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
                                  ?widget.quantity.toString()
                                  : "0"),
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
