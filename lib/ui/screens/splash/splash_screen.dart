import 'dart:async';
import 'package:demo_splash_screen/resources/resources.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:demo_splash_screen/ui/screens/screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const String id = 'splashScreen';
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      FirebaseAuth.instance.authStateChanges().listen((event) {
        if (event != null) {
          if (mounted) {
            Navigator.pushReplacementNamed(
              context,
              DashboardScreen.id,
            );
          }
        } else {
          if (mounted) {
            Navigator.pushNamedAndRemoveUntil(
                context, LoginScreen.id, (route) => false);
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
