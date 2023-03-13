import 'package:demo_splash_screen/services/auth_service.dart';
import 'package:demo_splash_screen/widgets/common_widget/customtextfield.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:demo_splash_screen/resources/resources.dart';
import 'package:demo_splash_screen/ui/screens/screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String id = 'Login_screen';
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _auth = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isprocessing = false;
  final fromKey = GlobalKey<FormState>();
  Future<void> _addAllData() async {
    if (fromKey.currentState!.validate()) {
      setState(() {
        isprocessing = true;
      });
      final user = await _auth.signInUsingEmailPassword(
          email: _emailController.text, password: _passwordController.text);
      if (user != null) {
        // ignore: use_build_context_synchronously
        Navigator.pushNamedAndRemoveUntil(
          context,
          DashboardScreen.id,
          (route) => false,
        );
        setState(() {
          isprocessing = false;
        });
      }
    }
  }

  Future<void> _signuppage() async {
    Navigator.pushNamed(context, SignupScreen.id);
  }

  Future<void> _resetpasswordpage() async {
    Navigator.pushNamed(context, ResetPasswordScreen.id);
  }

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
                      Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () => _resetpasswordpage(),
                            child: Text(
                                AppLocalizations.of(context)!.forgotpassword,
                                style: regularTextStyle(
                                    color: AllColors.maincolor,
                                    fontSize: 11.sp)),
                          )),
                      buildSizedBoxSpacer(height: 5.h),
                      MaterialButton(
                        height: 40.h,
                        minWidth: double.infinity,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40.r)),
                        onPressed: () => _addAllData(),
                        color: AllColors.maincolor,
                        child: Text(
                          AppLocalizations.of(context)!.login,
                          style: regularTextStyle(
                              color: AllColors.white, fontSize: 23.sp),
                        ),
                      ),
                      buildSizedBoxSpacer(height: 5.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(AppLocalizations.of(context)!.account),
                          TextButton(
                              onPressed: () => _signuppage(),
                              child: Text(
                                AppLocalizations.of(context)!.signup,
                                style: boldTextStyle(
                                    fontSize: 16.sp,
                                    color: AllColors.maincolor),
                              ))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
