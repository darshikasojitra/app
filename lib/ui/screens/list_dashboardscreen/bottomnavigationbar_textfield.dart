import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_splash_screen/services/auth_service.dart';
import 'package:demo_splash_screen/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomnavigationbarTextfield extends StatelessWidget {
  const BottomnavigationbarTextfield({super.key});

  @override
  Widget build(BuildContext context) {
  final AuthService auth = AuthService();
    TextEditingController textcontroller = TextEditingController();
     var wishlist = FirebaseFirestore.instance.collection('wishlist');
    Future addData() async {
      await wishlist.doc(auth.getUser()!.uid).collection("userwishlist").add({
        'uid': auth.getUser()!.uid,
        'uname': auth.getUser()!.displayName,
        'name': textcontroller.text,
        'total_prize': 0,
        'total_quantity': 0,
      });
    }
  
    return Padding(
        padding: EdgeInsets.only(left: 20.h, right: 20.h,bottom: 10.h),
        child: TextFormField(
          textAlign: TextAlign.center,
          controller: textcontroller,
          decoration: InputDecoration(
            hintText: StringManager.newlist,
            contentPadding: EdgeInsets.symmetric(vertical: 5.h),
            suffixIcon: IconButton(
                onPressed: () =>addData(),
                icon: Icon(Icons.add_circle, color: AllColors.maincolor)),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.r),
              borderSide: BorderSide(color: AllColors.maincolor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.r),
              borderSide: BorderSide(color: AllColors.maincolor)),
          ),
        ));
  }
}
