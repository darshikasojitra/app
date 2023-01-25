import 'package:cloud_firestore/cloud_firestore.dart';
import 'signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'dashboard_screen.dart';
import 'package:demo_splash_screen/auth_service.dart';
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
              const Text(
                AllStrings.login,
                style: TextStyle(
                    color: Colors.teal,
                    fontSize: 35,
                    fontWeight: FontWeight.bold),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                child: Form(
                  key: fromKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    children: [
                      TextFormField(
                        autofocus: true,
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          labelText: AllStrings.email,
                          floatingLabelStyle: TextStyle(color: Colors.teal),
                          hintText: AllStrings.enteremail,
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal),
                          ),
                        ),
                        validator: (email) {
                          return email != null &&
                                  !EmailValidator.validate(email)
                              ? AllStrings.validemail
                              : null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
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
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal),
                          ),
                        ),
                        validator: (password) {
                          return password != null && password.length < 6
                              ? AllStrings.validpassword
                              : null;
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      MaterialButton(
                        height: 60,
                        minWidth: double.infinity,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40)),
                        onPressed: () async {
                          if (fromKey.currentState!.validate()) {
                            setState(() {
                              isprocessing = true;
                            });

                            User? user = await auth
                                .signInUsingEmailPassword(
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
                        child: const Text(
                          AllStrings.login,
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                        color: Colors.teal,
                      ),
                      const SizedBox(
                        height: 5,
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
                                        builder: (context) => signup_screen()));
                              },
                              child: const Text(
                                AllStrings.signup,
                                style:
                                    TextStyle(fontSize: 20, color: Colors.teal),
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
