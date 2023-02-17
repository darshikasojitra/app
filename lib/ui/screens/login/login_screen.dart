import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_splash_screen/model/auth_service.dart';
import 'package:demo_splash_screen/resources/all_colors.dart';
import 'package:demo_splash_screen/resources/all_style.dart';
import 'package:demo_splash_screen/ui/screens/dashboard/dashboard_screen.dart';
import 'package:demo_splash_screen/ui/screens/signup/signup_screen.dart';
import 'package:demo_splash_screen/ui/screens/signup/text_formfield.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:demo_splash_screen/resources/string_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Login_screen extends StatefulWidget {
  const Login_screen({super.key});
  static const String id = 'Login_screen';
  @override
  State<Login_screen> createState() => _Login_screenState();
}

class _Login_screenState extends State<Login_screen> {
  final AuthService auth = AuthService();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isprocessing = false;
  final fromKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context)!.login,
                style:
                    boldTextStyle(color: AllColors.maincolor, fontSize: 35.sp),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 30.w),
                child: Form(
                  key: fromKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    children: [
                      TextFormFeild1(
                        obscureText: false,
                        controller: emailController,
                        labelText: StringManager.email,
                        hintText: StringManager.enteremail,
                        validator: (email) {
                          return email != null &&
                                  !EmailValidator.validate(email)
                              ? StringManager.validemail
                              : null;
                        },
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      TextFormFeild1(
                        obscureText: true,
                        controller: passwordController,
                        labelText: StringManager.password,
                        hintText: StringManager.enterpassword,
                        validator: (password) {
                          return password != null && password.length < 6
                              ? StringManager.validpassword
                              : null;
                        },
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      MaterialButton(
                        height: 40.h,
                        minWidth: double.infinity,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40.r)),
                        onPressed: () async {
                          if (fromKey.currentState!.validate()) {
                            setState(() {
                              isprocessing = true;
                            });

                            final user = await auth.signInUsingEmailPassword(
                                email: emailController.text,
                                password: passwordController.text);

                            if (user != null) {
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                dashboard_screen.id,
                                (route) => false,
                              );
                              setState(() {
                                isprocessing = false;
                              });
                            }

                            // FirebaseFirestore.instance.collection("user").add({
                            //   'uid': auth.getUser()!.uid,
                            //   'name': user?.displayName,
                            //   'email': emailController.text
                            // });
                          }
                        },
                        color: AllColors.maincolor,
                        child: Text(
                          AppLocalizations.of(context)!.login,
                          style: regularTextStyle(
                              color: AllColors.white, fontSize: 23.sp),
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(StringManager.account),
                          TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, signup_screen.id);
                              },
                              child: Text(
                                StringManager.signup,
                                style: boldTextStyle(
                                    fontSize: 16.sp,
                                    color: AllColors.maincolor),
                              ))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
