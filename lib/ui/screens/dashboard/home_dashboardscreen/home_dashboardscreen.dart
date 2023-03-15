import 'package:demo_splash_screen/l10n/localization.dart';
import 'package:demo_splash_screen/services/auth_service.dart';
import 'package:demo_splash_screen/resources/resources.dart';
import 'package:demo_splash_screen/ui/screens/dashboard/home_dashboardscreen/change_language.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:demo_splash_screen/ui/screens/login/login_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:demo_splash_screen/ui/screens/dashboard/dashboard.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? _user;
  final AuthService _auth = AuthService();

  Future<void> _signout() async {
    if (FirebaseAuth.instance.currentUser != null) {
      await FirebaseAuth.instance.signOut();
    }
    if (mounted) {
      Navigator.pushNamedAndRemoveUntil(
          context, LoginScreen.id, (route) => false);
    }
  }

  @override
  void initState() {
    _user = _auth.getUser();
    super.initState();
  }

  Future<void> _languagepage() async {
    Navigator.pushNamed(context, LanguageScreen.id);
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
                    '${_user?.displayName}'.substring(0, 1).toUpperCase(),
                    style: regularTextStyle(
                        color: AllColors.maincolor, fontSize: 36.sp)),
              ),
              accountName: Text("${_user?.displayName}",
                  style: regularTextStyle(
                      color: AllColors.white, fontSize: 17.sp)),
              accountEmail: Text("${_user?.email}",
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
              onTap: () => _languagepage(),
              leading: const Icon(Icons.language),
              title: Text(AppLocalizations.of(context)!.changelanguage),
            ),
            ListTile(
              leading: const Icon(Icons.home_filled),
              title: Text(AppLocalizations.of(context)!.household),
            ),
            ListTile(
              onTap: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  title: Text(
                    AppLocalizations.of(context)!.logout,
                    style: TextStyle(color: AllColors.maincolor),
                  ),
                  content: Text(AppLocalizations.of(context)!.wanttologout),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: Text(
                        AppLocalizations.of(context)!.cancle,
                        style: TextStyle(color: AllColors.maincolor),
                      ),
                    ),
                    TextButton(
                      onPressed: () => _signout(),
                      child: Text(
                        AppLocalizations.of(context)!.ok,
                        style: TextStyle(color: AllColors.maincolor),
                      ),
                    ),
                  ],
                ),
              ),
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
