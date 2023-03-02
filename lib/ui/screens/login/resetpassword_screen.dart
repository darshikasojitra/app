import 'package:demo_splash_screen/l10n/localization.dart';
import 'package:demo_splash_screen/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:demo_splash_screen/widget/widget.dart';
import 'package:demo_splash_screen/resources/resources.dart';

class ResetPasswordScreen extends StatefulWidget {
  static const String id = 'ResetPasswordScreen';
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  TextEditingController emailController = TextEditingController();
  final fromKey = GlobalKey<FormState>();
  final AuthService auth = AuthService();
  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future<void> _resetPassword() async {
    if (fromKey.currentState!.validate()) {
      auth.resetpassword(email: emailController.text);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(context, () {
        Navigator.pop(context);
      }, AppLocalizations.of(context)!.resetpassword, AllColors.maincolor),
      body: Form(
        key: fromKey,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
          child: Column(
            children: [
              CustomTextFields(
                  obscureText: false,
                  controller: emailController,
                  labelText: AppLocalizations.of(context)!.email,
                  hintText: AppLocalizations.of(context)!.enteremail,
                  validator: Validator.emailValidator),
              SizedBox(
                height: 20.h,
              ),
              MaterialButton(
                height: 40.h,
                minWidth: double.infinity,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40.r)),
                onPressed: () => _resetPassword(),
                color: AllColors.maincolor,
                child: Text(
                  AppLocalizations.of(context)!.resetpassword,
                  style:
                      regularTextStyle(color: AllColors.white, fontSize: 20.sp),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
