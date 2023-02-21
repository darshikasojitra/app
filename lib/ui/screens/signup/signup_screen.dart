import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_splash_screen/l10n/localization.dart';
import 'package:demo_splash_screen/model/auth_service.dart';
import 'package:demo_splash_screen/ui/screens/login/login_screen.dart';
import 'package:demo_splash_screen/ui/screens/signup/text_formfield.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:demo_splash_screen/resources/resources.dart';

// ignore: camel_case_types
class signup_screen extends StatefulWidget {
  const signup_screen({super.key});
  static const String id = 'signup_screen';

  @override
  State<signup_screen> createState() => _signup_screenState();
}

// ignore: camel_case_types
class _signup_screenState extends State<signup_screen> {
  DatabaseReference uref = FirebaseDatabase.instance.ref("user");
  final AuthService auth = AuthService();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController cpasswordController = TextEditingController();
  bool isprocessing = false;
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(top: 100.h),
                child: Text(
                  AppLocalizations.of(context)!.signup,
                  style: boldTextStyle(
                      color: AllColors.maincolor, fontSize: 35.sp),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
                child: Form(
                    key: formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      children: [
                        TextFormFeild1(
                          obscureText: false,
                          controller: nameController,
                          labelText: AppLocalizations.of(context)!.name,
                          hintText: AppLocalizations.of(context)!.entername,
                          validator: (name) {
                            return name!.isEmpty
                                ? AppLocalizations.of(context)!.entername
                                : null;
                          },
                        ),
                        buildSizedBoxSpacer(),
                        TextFormFeild1(
                          obscureText: false,
                          controller: emailController,
                          labelText: AppLocalizations.of(context)!.email,
                          hintText: AppLocalizations.of(context)!.enteremail,
                          validator: (email) {
                            return email != null &&
                                    !EmailValidator.validate(email)
                                ? AppLocalizations.of(context)!.validemail
                                : null;
                          },
                        ),
                        buildSizedBoxSpacer(),
                        TextFormFeild1(
                          obscureText: true,
                          controller: passwordController,
                          labelText: AppLocalizations.of(context)!.password,
                          hintText: AppLocalizations.of(context)!.enterpassword,
                          validator: (password) {
                            return password != null && password.length < 6
                                ? AppLocalizations.of(context)!.validpassword
                                : null;
                          },
                        ),
                        buildSizedBoxSpacer(),
                        TextFormFeild1(
                          obscureText: true,
                          controller: cpasswordController,
                          labelText: AppLocalizations.of(context)!.cpassword,
                          hintText: AppLocalizations.of(context)!.entercpassword,
                          validator: (cpassword) {
                            if (cpassword!.isEmpty &&
                                cpassword == passwordController.text &&
                                cpassword.length < 6) {
                              return AppLocalizations.of(context)!.entercpassword;
                            }
                            if (cpassword != passwordController.text) {
                              return AppLocalizations.of(context)!.entercpassword;
                            }
                            return null;
                          },
                        ),
                        buildSizedBoxSpacer(),
                        MaterialButton(
                          height: 40.h,
                          minWidth: double.infinity,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40.r)),
                          onPressed: () async {
                            setState(() {
                              isprocessing = true;
                            });
                            if (formKey.currentState!.validate()) {
                              Future<User?> user =
                                  auth.registerUsingEmailPassword(
                                      name: nameController.text.trim(),
                                      email: emailController.text,
                                      password: passwordController.text);
                              setState(() {
                                isprocessing = false;
                              });
                              FirebaseFirestore.instance
                                  .collection("user")
                                  .add({
                                'uid': auth.getUser()!.uid,
                                'name': nameController.text,
                                'email': emailController.text
                              });
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                Login_screen.id,
                                (route) => false,
                              );
                            }
                          },
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
                                onPressed: () {
                                  Navigator.pushNamed(context, Login_screen.id);
                                },
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
      ),
    );
  }
}

SizedBox buildSizedBoxSpacer() {
  return SizedBox(
    height: 20.h,
  );
}
