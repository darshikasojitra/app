import 'package:demo_splash_screen/bottomnavigationbar_container.dart';
import 'package:demo_splash_screen/product_streambuilder.dart';
import 'package:demo_splash_screen/resources/all_colors.dart';
import 'package:demo_splash_screen/resources/all_images.dart';
import 'package:demo_splash_screen/resources/all_string.dart';
import 'package:demo_splash_screen/screens/list/list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Product_Page extends StatefulWidget {
  const Product_Page({super.key});

  @override
  State<Product_Page> createState() => _Product_PageState();
}
class _Product_PageState extends State<Product_Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: InkWell(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>  const List_Screen()));
              },
              child: Icon(
                Icons.arrow_back,
                color: AllColors.black,
              )),
        backgroundColor: AllColors.white,
        title: Text(
          AllStrings.home,
          style: TextStyle(color: AllColors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 5.w, horizontal: 8.h),
          child: Column(
            children: [
              Row(
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
                    size: 20,
                  ),
                  SizedBox(
                    width: 175.w,
                  ),
                  Icon(
                    Icons.people,
                    color: AllColors.maincolor,
                  ),
                  SizedBox(
                    width: 12.w,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 5, top: 20, bottom: 20, right: 20),
                    child: Icon(
                      Icons.share,
                      color: AllColors.maincolor,
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  MaterialButton(
                    onPressed: () {},
                    height: 30.h,
                    minWidth: 157.w,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: AllColors.maincolor, width: 1),
                        borderRadius: BorderRadius.circular(40)),
                    child: Row(
                      children: [
                        Icon(
                          Icons.store,
                          size: 22,
                          color: AllColors.maincolor,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text(
                          AllStrings.gotostore,
                          style: TextStyle(
                              color: AllColors.maincolor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  MaterialButton(
                    color: AllColors.buttoncolor,
                    onPressed: () {},
                    height: 30.h,
                    minWidth: 157.w,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: AllColors.maincolor, width: 1),
                        borderRadius: BorderRadius.circular(40)),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: 15.w, top: 9.h, bottom: 8.h, right: 30.w),
                          child: Text(
                            AllStrings.newidea,
                            style: TextStyle(
                                color: AllColors.maincolor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ),
                        Icon(
                          Icons.add_circle,
                          size: 22,
                          color: AllColors.maincolor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const ProductStreambuilder(),
            ],
          ),
        ),
      ),
      bottomNavigationBar:  const BottomnavigationbarContaineer(),
    );
  }
}
