import 'package:cloud_firestore/cloud_firestore.dart';
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
  final ScrollController _scrollcontroller = ScrollController();
  final AuthService _auth = AuthService();
  final _fromKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isprocessing = false;
  bool _passwordVisible = false;
  @override
  void initState() {
    _passwordVisible = false;
    super.initState();
  }
    Future<void> _userdetail() async {
    await FirebaseFirestore.instance.collection("user").add({
      'uid': _auth.getUser()!.uid,
      //'name': _nameController.text,
      'email': _emailController.text
    });
  }
  Future<void> _showpassword() async {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  Future<void> _addAllData() async {
    if (_fromKey.currentState!.validate()) {
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
        body: SingleChildScrollView(
          controller: _scrollcontroller,
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.only(top: 150.h,),
            child: Column(children: [
              Text(
                AppLocalizations.of(context)!.login,
                style:
                    boldTextStyle(color: AllColors.maincolor, fontSize: 35.sp),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w,vertical: 20.h),
                child: Form(
                  key: _fromKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomTextFields(
                          obscureText: false,
                          controller: _emailController,
                          labelText: AppLocalizations.of(context)!.email,
                          hintText: AppLocalizations.of(context)!.enteremail,
                          validator: Validator.emailValidator, ),
                      buildSizedBoxSpacer(height: 20.h),
                      CustomTextFields(
                          obscureText: !_passwordVisible,
                          controller: _passwordController,
                          labelText: AppLocalizations.of(context)!.password,
                          hintText: AppLocalizations.of(context)!.enterpassword,
                          validator: Validator.passValidator,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: AllColors.maincolor,
                            ),
                            onPressed: () => _showpassword(),
                          ),),
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
                      _divider,
                      buildSizedBoxSpacer(height: 10.h),
                      _googlesignin(context, _auth),
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

Widget _googlesignin(BuildContext context, AuthService auth) => MaterialButton(
      height: 40.h,
      minWidth: double.infinity,
      color: AllColors.white,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: AllColors.maincolor, width: 1.w),
        borderRadius: BorderRadius.circular(40.r),
      ),
      onPressed: () => auth.signup(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 30,
            width: 30,
            child: Image.asset(
              AllImages.googleimage,
              fit: BoxFit.cover,
            ),
          ),
          buildSizedBoxSpacer(width: 30),
          Text(AppLocalizations.of(context)!.signingoogle)
        ],
      ),
    );

Widget _divider = Row(children: const [
  Expanded(
      child: Divider(
    thickness: 1,
  )),
  Text(
    "OR",
    style: TextStyle(color: Colors.grey),
  ),
  Expanded(
      child: Divider(
    thickness: 1,
  )),
]);
