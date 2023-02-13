import 'package:demo_splash_screen/model/auth_service.dart';
import 'package:demo_splash_screen/resources/all_style.dart';
import 'package:demo_splash_screen/screens/dashboard/dashboard_screen.dart';
import 'package:demo_splash_screen/screens/signup/signup_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../resources/all_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:demo_splash_screen/resources/all_string.dart';

class Login_screen extends StatefulWidget {
  const Login_screen({super.key});
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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                AllStrings.login,
                style: TextStyle(
                    color: AllColors.teal,
                    fontSize: 35,
                    fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 30.w),
                child: Form(
                  key: fromKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    children: [
                      TextFormField(
                        autofocus: true,
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: AllStrings.email,
                          floatingLabelStyle: TextStyle(color: AllColors.teal),
                          hintText: AllStrings.enteremail,
                          border: const OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AllColors.teal),
                          ),
                        ),
                        validator: (email) {
                          return email != null &&
                                  !EmailValidator.validate(email)
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
                          floatingLabelStyle: TextStyle(color: AllColors.teal),
                          hintText: AllStrings.enterpassword,
                          border: const OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AllColors.teal),
                          ),
                        ),
                        validator: (password) {
                          return password != null && password.length < 6
                              ? AllStrings.validpassword
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
                          if (fromKey.currentState!.validate()) {
                            setState(() {
                              isprocessing = true;
                            });

                            User? user = await auth.signInUsingEmailPassword(
                                email: emailController.text,
                                password: passwordController.text);

                            if (user != null) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          dashboard_screen()));

                              setState(() {
                                isprocessing = false;
                              });
                            } else {
                              print('123');
                            }
                          }
                        },
                        color: AllColors.teal,
                        child: Text(
                          AllStrings.login,
                          style:
                              TextStyle(color: AllColors.white, fontSize: 25),
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(AllStrings.account),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const signup_screen()));
                              },
                              child: Text(
                                AllStrings.signup,
                                style: TextStyle(
                                    fontSize: 20, color: AllColors.teal),
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
