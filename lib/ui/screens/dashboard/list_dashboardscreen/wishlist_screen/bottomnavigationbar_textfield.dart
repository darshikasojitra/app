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
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
    focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _textcontroller = TextEditingController();
    GlobalKey<FormFieldState> _fromKey = GlobalKey<FormFieldState>();
    return Padding(
        padding: EdgeInsets.only(left: 20.h, right: 20.h, bottom: 10.h),
        child: Container(
          height: 40,
          width: 335,
          child: TextFormField(
              autofocus: false,
              key: _fromKey,
              focusNode: focusNode,
              style: TextStyle(color: AllColors.maincolor),
              textAlign: TextAlign.center,
              controller: _textcontroller,
              decoration: InputDecoration(
                filled: true,
                fillColor: focusNode.hasFocus
                    ? AllColors.white
                    : AllColors.buttoncolor,
                hintText: focusNode.hasFocus
                    ? StringManager.enterlistname
                    : StringManager.newlist,
                hintStyle: focusNode.hasFocus
                    ? TextStyle(color: AllColors.black, fontSize: 14.sp)
                    : TextStyle(color: AllColors.maincolor, fontSize: 14.sp),
                contentPadding: EdgeInsets.symmetric(vertical: 5.h),
                suffixIcon: IconButton(
                    onPressed: () {
                      focusNode.requestFocus();
                      if (_fromKey.currentState!.validate()) {
                        Servives.addData(_textcontroller);
                      }
                    },
                    icon: Icon(Icons.add_circle, color: AllColors.maincolor)),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.r),
                  borderSide: BorderSide(color: AllColors.maincolor),
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.r),
                    borderSide: BorderSide(color: AllColors.maincolor)),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.r),
                    borderSide: BorderSide(color: AllColors.maincolor)),
                errorStyle: TextStyle(color: AllColors.maincolor),
              ),
              validator: Validator.newlistValidator),
        ));
  }
}
