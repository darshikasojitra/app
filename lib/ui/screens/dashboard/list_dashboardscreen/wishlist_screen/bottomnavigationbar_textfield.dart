import 'package:demo_splash_screen/resources/resources.dart';
import 'package:demo_splash_screen/services/product_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomnavigationbarTextfield extends StatelessWidget {
  const BottomnavigationbarTextfield({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController _textcontroller = TextEditingController();
    return Padding(
        padding: EdgeInsets.only(left: 20.h, right: 20.h, bottom: 10.h),
        child: TextFormField(
          textAlign: TextAlign.center,
          controller: _textcontroller,
          decoration: InputDecoration(
            hintText: StringManager.newlist,
            contentPadding: EdgeInsets.symmetric(vertical: 5.h),
            suffixIcon: IconButton(
                onPressed: () => Servives.addData(_textcontroller),
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
