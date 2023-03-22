import 'dart:io';

import 'package:demo_splash_screen/l10n/localization.dart';
import 'package:demo_splash_screen/services/auth_service.dart';
import 'package:demo_splash_screen/widgets/common_widget/customtextfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:demo_splash_screen/resources/resources.dart';
import 'package:demo_splash_screen/ui/screens/screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});
  static const String id = 'signup_screen';
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final AuthService _auth = AuthService();
   User? _user;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cpasswordController = TextEditingController();
  bool isprocessing = false;
  final formKey = GlobalKey<FormState>();
  String? _userId;
  XFile? _imagefile;
  PickedFile? pickedFile;
  final ImagePicker _picker = ImagePicker();

  Future<void> _takephoto(ImageSource src) async {
    final pickedFile = await _picker.pickImage(source: src);
    setState(() {
      _imagefile = pickedFile;
    });
    Reference ref = FirebaseStorage.instance.ref().child('path');
    await ref.putFile(File(_imagefile!.path));
  }
  Future<void> _getuserid()async{
    setState(() {
      _userId = _auth.getUser()!.uid;
    });
  }
  Future<void> _addData() async {
    setState(() {
      isprocessing = true;
    });
    if (formKey.currentState!.validate()) {
      _auth.registerUsingEmailPassword(
          name: _nameController.text.trim(),
          email: _emailController.text,
          password: _passwordController.text,);
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
    _getuserid();
    Navigator.pushNamed(context, LoginScreen.id);
  }

  @override
  void initState() {
     _user = _auth.getUser();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20.w),
              child: Container(
                padding: EdgeInsets.only(top: 50.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.welcome,
                      style: boldTextStyle(
                          color: AllColors.maincolor, fontSize: 35.sp),
                    ),
                    buildSizedBoxSpacer(height: 5.h),
                    Text(
                      AppLocalizations.of(context)!.createyouraccount,
                      style: TextStyle(color: AllColors.black, fontSize: 15.sp),
                    ),
                  ],
                ),
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
                      profileimage(_imagefile),
                      buildSizedBoxSpacer(height: 10.h),
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

  Widget profileimage(XFile? imagefile) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 40.r,
          backgroundColor: Colors.transparent,
          backgroundImage: (imagefile) == null
              ? const ExactAssetImage('assets/images/addphoto.png')
              : FileImage(File((imagefile.path).toString())) as ImageProvider,
        ),
        Positioned(
            bottom: 5.h,
            right: 1.h,
            left: 62.w,
            child: InkWell(
              onTap: () {
                showModalBottomSheet(
                    builder: ((builder) => bottomsheet()), context: context);
              },
              child: Icon(
                Icons.photo_camera,
                color: AllColors.maincolor,
                size: 30,
              ),
            ))
      ],
    );
  }

  Widget bottomsheet() {
    return Container(
      height: 100,
      margin: EdgeInsets.symmetric(horizontal: 20.h, vertical: 20.h),
      child: Column(
        children: [
          const Text(
            'choose profile photo',
            style: TextStyle(fontSize: 20),
          ),
          buildSizedBoxSpacer(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  IconButton(
                      onPressed: () async {
                        await _takephoto(ImageSource.camera);
                        Navigator.of(context).pop();
                      },
                      icon: Icon(
                        Icons.camera,
                        size: 30.sp,
                        color: AllColors.maincolor,
                      )),
                  const Text('Camera')
                ],
              ),
              buildSizedBoxSpacer(width: 30),
              Column(
                children: [
                  IconButton(
                      onPressed: () async {
                        await _takephoto(ImageSource.gallery);
                        Navigator.of(context).pop();
                      },
                      icon: Icon(
                        Icons.image,
                        size: 30.sp,
                        color: AllColors.maincolor,
                      )),
                  const Text('Gallery'),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}

SizedBox buildSizedBoxSpacer({double? height, double? width}) {
  return SizedBox(
    height: height,
    width: width,
  );
}
