import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_splash_screen/model/auth_service.dart';
import 'package:demo_splash_screen/resources/all_colors.dart';
import 'package:demo_splash_screen/resources/all_string.dart';
import 'package:demo_splash_screen/screens/login/login_screen.dart';
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
                  AllStrings.signup,
                  style: TextStyle(
                    color: AllColors.teal,
                    fontWeight: FontWeight.bold,
                    fontSize: 35,
                  ),
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
                        TextFormField(
                          autofocus: true,
                          controller: nameController,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            labelText: AllStrings.name,
                            floatingLabelStyle:
                                TextStyle(color: AllColors.teal),
                            hintText: AllStrings.entername,
                            border: const OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: AllColors.teal),
                            ),
                          ),
                          validator: (value) {
                            return value!.isEmpty ? AllStrings.entername : null;
                          },
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        TextFormField(
                          autofocus: true,
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: AllStrings.email,
                            floatingLabelStyle:
                                TextStyle(color: AllColors.teal),
                            hintText: AllStrings.enteremail,
                            border: const OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: AllColors.teal),
                            ),
                          ),
                          validator: (value) {
                            return value != null &&
                                    !EmailValidator.validate(value)
                                ? AllStrings.validemail
                                : null;
                          },
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        TextFormField(
                          autofocus: true,
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: AllStrings.password,
                            floatingLabelStyle:
                                TextStyle(color: AllColors.teal),
                            hintText: AllStrings.enterpassword,
                            border: const OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: AllColors.teal),
                            ),
                          ),
                          validator: (value) {
                            confirmpass = value;
                            return value != null && value.length < 6
                                ? AllStrings.validpassword
                                : null;
                          },
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        TextFormField(
                          autofocus: true,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: AllStrings.cpassword,
                            floatingLabelStyle:
                                TextStyle(color: AllColors.teal),
                            hintText: AllStrings.entercpassword,
                            border: const OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: AllColors.teal),
                            ),
                          ),
                          validator: (value) {
                            return value!.isEmpty && value != confirmpass
                                ? AllStrings.entercpassword
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
                              borderRadius: BorderRadius.circular(40)),
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
                          color: Colors.teal,
                          child: Text(
                            AllStrings.signup,
                            style:
                                TextStyle(color: AllColors.white, fontSize: 25),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(AllStrings.alreadyaccount),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Login_screen()));
                                },
                                child: Text(
                                  AllStrings.login,
                                  style: TextStyle(
                                      fontSize: 20, color: AllColors.teal),
                                ))
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
