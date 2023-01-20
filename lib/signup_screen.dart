import 'package:demo_splash_screen/Login_screen.dart';
import 'package:demo_splash_screen/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'dashboard_screen.dart';

class signup_screen extends StatefulWidget {
  const signup_screen({super.key});

  @override
  State<signup_screen> createState() => _signup_screenState();
}

class _signup_screenState extends State<signup_screen> {
  String email = '';
  String password = '';
  String cpassword = '';
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
                padding: const EdgeInsets.only(top: 200),
                child: const Text(
                  'Sign Up',
                  style: TextStyle(
                    color: Colors.teal,
                    fontWeight: FontWeight.bold,
                    fontSize: 35,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
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
                            labelText: 'Name',
                            floatingLabelStyle: TextStyle(color: Colors.teal),
                            hintText: 'Enter Name',
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.teal),),
                          ),
                          validator: (value) {
                            return value!.isEmpty ? 'please enter Name' : null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          autofocus: true,
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            floatingLabelStyle: TextStyle(color: Colors.teal),
                            hintText: 'Enter Email',
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.teal),),
                          ),
                          validator: (email) {
                            return email != null &&
                                    !EmailValidator.validate(email)
                                ? 'Enter valid Email'
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
                            labelText: 'Password',
                            floatingLabelStyle: TextStyle(color: Colors.teal),
                            hintText: 'Enter Password',
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.teal),),
                          ),
                          validator: (password) {
                            confirmpass = password;
                            return password != null && password.length < 6
                                ? 'enter password atleast 6 character'
                                : null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          autofocus: true,
                          obscureText: true,
                          decoration: const InputDecoration(
                            labelText: 'Confirm Password',
                            floatingLabelStyle: TextStyle(color: Colors.teal),
                            hintText: 'Enter confirm Password',
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.teal),),
                          ),
                          validator: (cpassword) {
                            return cpassword!.isEmpty &&
                                    cpassword != confirmpass
                                ? 'Enter confirm password'
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
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            dashboard_screen()));
                              }
                            }
                          },
                          child: Text(
                            'Sign up',
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
                          color: Colors.teal,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Already have an account?'),
                            TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Login_screen()));
                                },
                                child: const Text(
                                  'Sign In',
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
