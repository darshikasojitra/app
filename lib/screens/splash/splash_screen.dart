import 'package:demo_splash_screen/resources/all_images.dart';
import 'package:demo_splash_screen/screens/login/Login_screen.dart';
import 'package:demo_splash_screen/screens/dashboard/dashboard_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class splashScreen extends StatefulWidget {
  const splashScreen({super.key});

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  // void setState(fn) {
  //   if (mounted) {
  //     super.setState(fn);
  //   }
  // }
  void discope(){
    super.dispose();
  }
  void initState() {
    super.initState();

    Future.delayed( Duration(seconds: 5), () {
      // Navigator.pushReplacement(
      //     context, MaterialPageRoute(builder: (context) => Login_screen()));
      FirebaseAuth.instance.authStateChanges().listen((event) {
        if (event != null) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => dashboard_screen()));
        } else {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Login_screen()));
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
          Image.asset(AllImages.iconimage),
        ],
      )),
    );
  }
}
