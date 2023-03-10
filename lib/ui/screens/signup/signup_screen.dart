import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_splash_screen/l10n/localization.dart';
import 'package:demo_splash_screen/services/auth_service.dart';
import 'package:demo_splash_screen/widgets/common_widget/customtextfield.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:demo_splash_screen/resources/resources.dart';
import 'package:demo_splash_screen/ui/screens/screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});
  static const String id = 'signup_screen';
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final AuthService _auth = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cpasswordController = TextEditingController();
  bool isprocessing = false;
  final formKey = GlobalKey<FormState>();
  Future<void> _userdetail() async {
    await FirebaseFirestore.instance.collection("user").add({
      'uid': _auth.getUser()!.uid,
      'name': _nameController.text,
      'email': _emailController.text
    });
  }

  Future<void> _addData() async {
    setState(() {
      isprocessing = true;
    });
    if (formKey.currentState!.validate()) {
      final _user = _auth.registerUsingEmailPassword(
          name: _nameController.text.trim(),
          email: _emailController.text,
          password: _passwordController.text);
      setState(() {
        isprocessing = false;
      });
      Navigator.pushNamedAndRemoveUntil(
        context,
        LoginScreen.id,
        (route) => false,
      );
    }
  }

  Future<void> _loginpage() async {
    Navigator.pushNamed(context, LoginScreen.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.only(top: 100.h),
              child: Text(
                AppLocalizations.of(context)!.signup,
                style:
                    boldTextStyle(color: AllColors.maincolor, fontSize: 35.sp),
              ),
            ),
            buildSizedBoxSpacer(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
              child: Form(
                  key: formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    children: [
                      CustomTextFields(
                          obscureText: false,
                          controller: _nameController,
                          labelText: AppLocalizations.of(context)!.name,
                          hintText: AppLocalizations.of(context)!.entername,
                          validator: Validator.nameValidator),
                      buildSizedBoxSpacer(height: 20.h),
                      CustomTextFields(
                          obscureText: false,
                          controller: _emailController,
                          labelText: AppLocalizations.of(context)!.email,
                          hintText: AppLocalizations.of(context)!.enteremail,
                          validator: Validator.emailValidator),
                      buildSizedBoxSpacer(height: 20.h),
                      CustomTextFields(
                          obscureText: true,
                          controller: _passwordController,
                          labelText: AppLocalizations.of(context)!.password,
                          hintText: AppLocalizations.of(context)!.enterpassword,
                          validator: Validator.passValidator),
                      buildSizedBoxSpacer(height: 20.h),
                      CustomTextFields(
                        obscureText: true,
                        controller: _cpasswordController,
                        labelText: AppLocalizations.of(context)!.cpassword,
                        hintText: AppLocalizations.of(context)!.entercpassword,
                        validator: (value) => Validator.confirmpassworrd(
                            value, _passwordController.text),
                      ),
                      buildSizedBoxSpacer(height: 20.h),
                      MaterialButton(
                        height: 40.h,
                        minWidth: double.infinity,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40.r)),
                        onPressed: () => _addData(),
                        color: AllColors.maincolor,
                        child: Text(AppLocalizations.of(context)!.signup,
                            style: regularTextStyle(
                                fontSize: 23.sp, color: AllColors.white)),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(AppLocalizations.of(context)!.alreadyaccount),
                          TextButton(
                              onPressed: () => _loginpage(),
                              child: Text(AppLocalizations.of(context)!.login,
                                  style: boldTextStyle(
                                      color: AllColors.maincolor,
                                      fontSize: 16.sp)))
                        ],
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

SizedBox buildSizedBoxSpacer({ double? height,double? width}) {
  return SizedBox(
    height: height,
    width: width,
  );
}
