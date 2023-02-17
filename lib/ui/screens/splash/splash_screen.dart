import 'dart:async';

import 'package:demo_splash_screen/resources/all_images.dart';
import 'package:demo_splash_screen/ui/screens/login/login_screen.dart';
import 'package:demo_splash_screen/ui/screens/dashboard/dashboard_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class splashScreen extends StatefulWidget {
  const splashScreen({super.key});
  static const String id = 'splashScreen';
  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  @override
  void initState() {
    super.initState();

   Timer(const Duration(seconds: 3), () {
      FirebaseAuth.instance.authStateChanges().listen((event) {
        if (event != null) {
          Navigator.pushReplacementNamed(
            context,
            dashboard_screen.id,
          );
        } else {
          if(mounted){
                      Navigator.pushNamedAndRemoveUntil(context, Login_screen.id, (route) => false);

          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(AllImages.splashimage),
        ],
      )),
    );
  }
}
