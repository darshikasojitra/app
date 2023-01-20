import 'package:demo_splash_screen/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:demo_splash_screen/dashboard_screen.dart';
import 'package:demo_splash_screen/auth_service.dart';

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
                'Login',
                style: TextStyle(
                    color: Colors.teal,
                    fontSize: 35,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
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
                          return password != null && password.length < 6
                              ? 'Enter Password atleast 6 character'
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
                            }else{print('123');}
                          }
                        },
                        child: const Text(
                          'Login',
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
                          Text('Dont have an account?'),
                          TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => signup_screen()));
                              },
                              child: Text(
                                'Sign up',
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
