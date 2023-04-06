import 'package:demo_splash_screen/ui/screens/screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:demo_splash_screen/resources/resources.dart';
import 'package:demo_splash_screen/widgets/widget.dart';

class AddNewUserScreen extends StatelessWidget {
  static const String id = 'AddNewUserScreen';
  const AddNewUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController name = TextEditingController();
    final TextEditingController websiteaddress = TextEditingController();
    final TextEditingController address = TextEditingController();
    final TextEditingController notes = TextEditingController();
    final ScrollController _scrollcontroller = ScrollController();
    return Scaffold(
      appBar: (appbar(context, () {
        Navigator.pushNamed(context, DashboardScreen.id);
      }, 'Add new vendor', AllColors.white)),
      body: SingleChildScrollView(
        physics:const  BouncingScrollPhysics(),
        controller: _scrollcontroller,
        child: Padding(
          padding: EdgeInsets.only(left: 20.w, right: 20.h, top: 30.h),
          child: Column(
            children: [
              CustomTextFields(
                obscureText: false,
                controller: name,
                labelText: ' Vendor Name',
                hintText: ' Vendor Name',
                validator: Validator.nameValidator,
              ),
              sizebox(height: 30.h),
              CustomTextFields(
                obscureText: false,
                controller: websiteaddress,
                labelText: ' Website Address',
                hintText: 'Website Address',
                validator: Validator.nameValidator,
              ),
              sizebox(height: 30.h),
              SizedBox(
                height: 90.h,
                child: CustomTextFields(
                  obscureText: false,
                  maxLines: 6,
                  controller: address,
                  labelText: ' Address',
                  hintText: 'Address',
                  validator: Validator.nameValidator,
                ),
              ),
              sizebox(height: 30.h),
              SizedBox(
                height: 150.h,
                child: CustomTextFields(
                  obscureText: false,
                  controller: notes,
                  maxLines: 8,
                  labelText: ' Notes',
                  hintText: 'Notes',
                  contentPadding: const EdgeInsets.only(
                    top: 10.0,
                  ),
                  validator: Validator.nameValidator,
                ),
              ),
              sizebox(height: 100.h),
              MaterialButton(
                height: 40.h,
                minWidth: double.infinity,
                color: AllColors.maincolor,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: AllColors.maincolor),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                onPressed: () {
                  //Navigator.pushNamed(context, AddNewUserScreen.id);
                },
                child: Text(
                  'Add Vendor',
                  style:
                      regularTextStyle(color: AllColors.white, fontSize: 16.sp),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

SizedBox sizebox({double? height, double? width}) {
  return SizedBox(
    height: height,
    width: width,
  );
}
