import 'package:demo_splash_screen/l10n/localization.dart';
import 'package:demo_splash_screen/model/auth_service.dart';
import 'package:demo_splash_screen/resources/all_colors.dart';
import 'package:demo_splash_screen/resources/all_style.dart';
import 'package:demo_splash_screen/resources/string_manager.dart';
import 'package:demo_splash_screen/ui/screens/dashboard/change_language.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:demo_splash_screen/ui/screens/login/login_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: camel_case_types
class Home_Screen extends StatefulWidget {
  const Home_Screen({super.key});

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

// ignore: camel_case_types
class _Home_ScreenState extends State<Home_Screen> {
  User? user;
  final AuthService _auth = AuthService();
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    user = _auth.getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AllColors.maincolor,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: AllColors.maincolor,
              ),
              currentAccountPicture: CircleAvatar(
                radius: 50,
                backgroundColor: AllColors.white,
                child: Text(
                    '${user?.displayName}'.substring(0, 1).toUpperCase(),
                    style: regularTextStyle(
                        color: AllColors.maincolor, fontSize: 36.sp)),
              ),
              accountName: Text("${user?.displayName}",
                  style: regularTextStyle(
                      color: AllColors.white, fontSize: 17.sp)),
              accountEmail: Text("${user?.email}",
                  style: regularTextStyle(
                      color: AllColors.white, fontSize: 17.sp)),
            ),
            ListTile(
              leading: const Icon(Icons.payment),
              title: Text(AppLocalizations.of(context)!.paymentmethod),
            ),
            ListTile(
              leading: const Icon(Icons.house),
              title: Text(AppLocalizations.of(context)!.address),
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, LanguageScreen.id);
              },
              leading: const Icon(Icons.language),
              title: Text(AppLocalizations.of(context)!.changelanguage),
            ),
            ListTile(
              leading: const Icon(Icons.home_filled),
              title: Text(AppLocalizations.of(context)!.household),
            ),
            ListTile(
              onTap: () async {
                if (FirebaseAuth.instance.currentUser != null) {
                  await FirebaseAuth.instance.signOut();
                }
                if (mounted) {
                  Navigator.pushNamedAndRemoveUntil(
                      context, Login_screen.id, (route) => false);
                }
              },
              leading: const Icon(Icons.logout),
              title: Text(AppLocalizations.of(context)!.logout),
            ),
          ],
        ),
      ),
      //body:
    );
  }
}
