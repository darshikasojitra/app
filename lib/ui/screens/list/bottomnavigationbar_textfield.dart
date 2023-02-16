import 'package:demo_splash_screen/model/auth_service.dart';
import 'package:demo_splash_screen/resources/all_colors.dart';
import 'package:demo_splash_screen/resources/string_manager.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomnavigationbarTextfield extends StatelessWidget {
  const BottomnavigationbarTextfield({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController textcontroller = TextEditingController();
    DatabaseReference pref = FirebaseDatabase.instance.ref("wishlist");
    final AuthService auth = AuthService();
    return Padding(
        padding: EdgeInsets.only(left: 20.h, right: 20.h, bottom: 8.h),
        child: SizedBox(
          height: 35.h,
          width: 340.w,
          child: TextField(
            textAlign: TextAlign.center,
            controller: textcontroller,
            autofocus: true,
            decoration: InputDecoration(
              hintText: StringManager.newlist,
              suffixIcon: IconButton(
                  onPressed: () {
                    pref.push().set({
                      'uid': auth.getUser()!.uid,
                      'uname': auth.getUser()!.displayName,
                      'name': textcontroller.text,
                      'total_prize': 0,
                      'total_quantity': 0,
                    });
                  },
                  icon: Icon(Icons.add_circle, color: AllColors.maincolor)),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.r),
                borderSide: BorderSide(color: AllColors.maincolor),
              ),
            ),
          ),
        ));
  }
}
