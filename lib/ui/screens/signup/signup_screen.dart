import 'package:demo_splash_screen/model/auth_service.dart';
import 'package:demo_splash_screen/resources/all_colors.dart';
import 'package:demo_splash_screen/resources/all_style.dart';
import 'package:demo_splash_screen/resources/string_manager.dart';
import 'package:demo_splash_screen/ui/screens/login/login_screen.dart';
import 'package:demo_splash_screen/ui/screens/signup/text_formfield.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class signup_screen extends StatefulWidget {
  const signup_screen({super.key});

  @override
  State<signup_screen> createState() => _signup_screenState();
}

class _signup_screenState extends State<signup_screen> {
  var confirmpass;
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
                  StringManager.signup,
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
                          labelText: StringManager.name,
                          hintText: StringManager.entername,
                          validator: (value) {
                            return value!.isEmpty
                                ? StringManager.entername
                                : null;
                          },
                        ),
                        buildSizedBoxSpacer(),
                        TextFormFeild1(
                          obscureText: false,
                          controller: emailController,
                          labelText: StringManager.email,
                          hintText: StringManager.enteremail,
                          validator: (value) {
                            return value != null &&
                                    !EmailValidator.validate(value)
                                ? StringManager.validemail
                                : null;
                          },
                        ),
                        buildSizedBoxSpacer(),
                        TextFormFeild1(
                          obscureText: true,
                          controller: passwordController,
                          labelText: StringManager.password,
                          hintText: StringManager.enterpassword,
                          validator: (value) {
                            confirmpass = value;
                            return value != null && value.length < 6
                                ? StringManager.validpassword
                                : null;
                          },
                        ),
                        buildSizedBoxSpacer(),
                        TextFormFeild1(
                          obscureText: true,
                          controller: cpasswordController,
                          labelText: StringManager.cpassword,
                          hintText: StringManager.entercpassword,
                          validator: (value) {
                            return value!.isEmpty && value != confirmpass
                                ? StringManager.entercpassword
                                : null;
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
                                      name: nameController.text,
                                      email: emailController.text,
                                      password: passwordController.text);
                              setState(() {
                                isprocessing = false;
                              });

                              if (user != null) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const Login_screen()));
                              }
                            }
                            uref.push().set({
                              'uid': auth.getUser()!.uid,
                              'name': nameController.text,
                              'email': emailController.text
                            });
                          },
                          color: AllColors.maincolor,
                          child: Text(StringManager.signup,
                              style: regularTextStyle(
                                  fontSize: 23.sp, color: AllColors.white)),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(StringManager.alreadyaccount),
                            TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, Login_screen.id);
                                },
                                child: Text(StringManager.login,
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
