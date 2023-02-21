import 'package:demo_splash_screen/model/auth_service.dart';
import 'package:demo_splash_screen/ui/screens/dashboard/dashboard_screen.dart';
import 'package:demo_splash_screen/ui/screens/signup/signup_screen.dart';
import 'package:demo_splash_screen/ui/screens/signup/text_formfield.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:demo_splash_screen/resources/resources.dart';

// ignore: camel_case_types
class Login_screen extends StatefulWidget {
  const Login_screen({super.key});
  static const String id = 'Login_screen';
  @override
  State<Login_screen> createState() => _Login_screenState();
}

// ignore: camel_case_types
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
                        labelText: AppLocalizations.of(context)!.email,
                        hintText: AppLocalizations.of(context)!.enteremail,
                        validator: (email) {
                          return email != null &&
                                  !EmailValidator.validate(email)
                              ?  AppLocalizations.of(context)!.validemail
                              : null;
                        },
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      TextFormFeild1(
                        obscureText: true,
                        controller: passwordController,
                        labelText: AppLocalizations.of(context)!.password,
                        hintText: AppLocalizations.of(context)!.enterpassword,
                        validator: (password) {
                          return password != null && password.length < 6
                              ?  AppLocalizations.of(context)!.validpassword
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
                              // ignore: use_build_context_synchronously
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                dashboard_screen.id,
                                (route) => false,
                              );
                              setState(() {
                                isprocessing = false;
                              });
                            }
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
                           Text(AppLocalizations.of(context)!.account),
                          TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, signup_screen.id);
                              },
                              child: Text(
                                AppLocalizations.of(context)!.signup,
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
