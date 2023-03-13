import 'package:demo_splash_screen/resources/resources.dart';
import 'package:demo_splash_screen/services/product_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomnavigationbarTextfield extends StatefulWidget {
  const BottomnavigationbarTextfield({super.key});

  @override
  State<BottomnavigationbarTextfield> createState() =>
      _BottomnavigationbarTextfieldState();
}

class _BottomnavigationbarTextfieldState
    extends State<BottomnavigationbarTextfield> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _textcontroller = TextEditingController();
    return Padding(
        padding: EdgeInsets.only(left: 20.h, right: 20.h, bottom: 10.h),
        child: Container(
          height: 40,
          width: 335,
          child: TextFormField(
            style: TextStyle(color: AllColors.maincolor),
            textAlign: TextAlign.center,
            controller: _textcontroller,
            decoration: InputDecoration(
              filled: true,
              fillColor: AllColors.buttoncolor,
              hintText: StringManager.newlist,
              hintStyle: TextStyle(color: AllColors.maincolor,fontSize: 14.sp),
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
          ),
        ));
  }
}
