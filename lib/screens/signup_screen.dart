import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_splash_screen/resources/all_string.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'Login_screen.dart';
import 'package:demo_splash_screen/auth_service.dart';
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
                padding:  EdgeInsets.only(top: 100.h),
                child: const Text(
                  AllStrings.signup,
                  style: TextStyle(
                    color: Colors.teal,
                    fontWeight: FontWeight.bold,
                    fontSize: 35,
                  ),
                ),
              ),
               SizedBox(
                height: 10.h,
              ),
              Padding(
                padding:
                     EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
                child: Form(
                    key: formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      children: [
                        TextFormField(
                          autofocus: true,
                          controller: nameController,
                          keyboardType: TextInputType.name,
                          decoration: const InputDecoration(
                            labelText: AllStrings.name,
                            floatingLabelStyle: TextStyle(color: Colors.teal),
                            hintText: AllStrings.entername,
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.teal),),
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
                          decoration: const InputDecoration(
                            labelText: AllStrings.email,
                            floatingLabelStyle: TextStyle(color: Colors.teal),
                            hintText: AllStrings.enteremail,
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.teal),),
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
                          decoration: const InputDecoration(
                            labelText: AllStrings.password,
                            floatingLabelStyle: TextStyle(color: Colors.teal),
                            hintText: AllStrings.enterpassword,
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.teal),),
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
                          decoration: const InputDecoration(
                            labelText: AllStrings.cpassword,
                            floatingLabelStyle: TextStyle(color: Colors.teal),
                            hintText: AllStrings.entercpassword,
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.teal),),
                          ),
                          validator: (value) {
                            return value!.isEmpty &&
                                    value != confirmpass
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
                                            Login_screen()));
                              }
                            }
                            FirebaseFirestore.instance.collection("user").add({'uid':auth.getUser()!.uid,'name':nameController.text,'email':emailController.text});
                          },
                          child: Text(
                            AllStrings.signup,
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
                          color: Colors.teal,
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
                                child: const Text(
                                  AllStrings.login,
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.teal),
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
