import 'package:demo_splash_screen/model/language.dart';
import 'package:demo_splash_screen/resources/all_colors.dart';
import 'package:demo_splash_screen/resources/all_images.dart';
import 'package:demo_splash_screen/user_preferences/global_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class ServiceUtils {


  static showErrorMsg(String msg, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        msg,
        style: TextStyle(fontSize: 16.sp, color: Colors.white),
      ),
      backgroundColor: Colors.grey.shade600,
      elevation: 0,
      duration: const Duration(seconds: 2),
    ));
  }

  static showSuccessMsg(String msg, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        msg,
        style: TextStyle(fontSize: 16.sp, color: Colors.white),
      ),
      backgroundColor: Colors.black,
      elevation: 0,
      duration: const Duration(seconds: 2),
    ));
  }

  // languageList for Localization
  static List<Language> languageList = [
    Language(
        name: 'English',
        langCode: 'en',
        image: AllImages.english,
        isChecked: true),
    Language(
        name: 'Arabic',
        langCode: 'ar',
        image: AllImages.arabic,
        isChecked: false)
  ];

  getHeaderWithBackArrowAndTitle(BuildContext context, String title,
      void Function() onBackClick, String lngCode) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: onBackClick,
          child: SizedBox(
            height: 21.h,
            width: 27.w,
            child: Icon(Icons.arrow_back,size: 25.sp,),
            // child: Image.asset(
            //   lngCode == LanguageCode.languageCodeArabic
            //       ? AllImages.backarrow
            //       : AllImages.arabic,
            //   fit: BoxFit.fitHeight,
            //   //color: Colors.black,
            // ),
          ),
        ),
        SizedBox(
          width: 4.w,
        ),
        Text(
          title,
          textAlign: TextAlign.left,
          overflow: TextOverflow.visible,
          style: TextStyle(
              fontSize: 18.sp, color: AllColors.black),
        ),
      ],
    );
  }
}