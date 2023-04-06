import 'package:demo_splash_screen/resources/resources.dart';
import 'package:demo_splash_screen/ui/screens/dashboard/list_dashboardscreen/product_screen/product_widget/product_widget.dart';
import 'package:demo_splash_screen/widgets/common_widget/customtextfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChangePassword extends StatefulWidget {
  static const String id = 'NewPassword';
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController __currentPassword = TextEditingController();
  final TextEditingController _newPassword = TextEditingController();
  final TextEditingController _confirmNewPassword = TextEditingController();
  String _errorMessage = '';
  bool _passwordVisible = false;
  @override
  void initState() {
    _passwordVisible = false;
    super.initState();
  }
    Future<void> _showpassword() async {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  void _changePassword() async {
    if (_formKey.currentState!.validate()) {
      try {
        final user = FirebaseAuth.instance.currentUser;
        final uid = user!.uid;

        final credential = EmailAuthProvider.credential(
          email: user.email as String,
          password: __currentPassword.text,
        );
        await user.reauthenticateWithCredential(credential);
        await user.updatePassword(_newPassword.text);
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            title: const Text('Success'),
            content: const Text('Your password has been changed.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  'OK',
                  style: regularTextStyle(
                      color: AllColors.maincolor, fontSize: 13.sp),
                ),
              ),
            ],
          ),
        );
      } on FirebaseAuthException catch (e) {
        setState(() {
          _errorMessage = e.message!;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(context, () {
        Navigator.pop(context);
      }, 'Change Password', AllColors.maincolor),
      body: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomTextFields(
                  obscureText: true,
                  maxLines: 1,
                  controller: __currentPassword,
                  validator: Validator.passValidator,
                  hintText: 'Current Password',
                  labelText: 'Current Password',
                ),
                sizedBoxSpacer(height: 15.h),
                CustomTextFields(
                  obscureText: true,
                  maxLines: 1,
                  controller: _newPassword,
                  validator: Validator.passValidator,
                  hintText: 'New Password',
                  labelText: 'New Password',
                ),
                sizedBoxSpacer(height: 40.h),
                MaterialButton(
                  height: 40.h,
                  minWidth: double.infinity,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r)),
                  onPressed: () => _changePassword(),
                  color: AllColors.maincolor,
                  child: Text('Save',
                      style: regularTextStyle(
                          fontSize: 16.sp, color: AllColors.white)),
                ),
              ],
            ),
          )),
    );
  }
}
