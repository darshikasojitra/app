import 'package:demo_splash_screen/l10n/localization.dart';
import 'package:demo_splash_screen/services/auth_service.dart';
import 'package:demo_splash_screen/resources/resources.dart';
import 'package:demo_splash_screen/ui/screens/dashboard/home_dashboardscreen/chat/chat_screen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:demo_splash_screen/ui/screens/login/login_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:demo_splash_screen/ui/screens/dashboard/home_dashboardscreen/side_drawer/side_drawer.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'HomeScreen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? _user;
  final AuthService _auth = AuthService();
  String? url;
  String? _imageurl;
  String? _userId;
  Future<void> _signout() async {
    if (FirebaseAuth.instance.currentUser != null) {
      await FirebaseAuth.instance.signOut();
    }
    if (mounted) {
      Navigator.pushNamedAndRemoveUntil(
          context, LoginScreen.id, (route) => false);
    }
  }

  Future<void> downloadURLExample() async {
    _userId = _user!.uid;
    final ref = FirebaseStorage.instance.ref().child('path');
    url = await ref.getDownloadURL();
    setState(() {
      _imageurl = url;
    });
  }

  @override
  void initState() {
    _user = _auth.getUser();
    //downloadURLExample();
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
                  radius: 40.r,
                  backgroundColor: AllColors.white,
                  // backgroundImage: (_imageurl) == null
                  //     ? const ExactAssetImage('assets/images/addphoto.png')
                  //     : NetworkImage((_imageurl!).toString()) as ImageProvider,
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
                onTap: () =>
                    Navigator.pushNamed(context, PaymentMethodScreen.id),
                leading: const Icon(Icons.payment),
                title: Text(AppLocalizations.of(context)!.paymentmethod),
              ),
              ListTile(
                onTap: () => Navigator.pushNamed(context, AddressScreen.id),
                leading: const Icon(Icons.house),
                title: Text(AppLocalizations.of(context)!.address),
              ),
              ListTile(
                onTap: () => _languagepage(),
                leading: const Icon(Icons.language),
                title: Text(AppLocalizations.of(context)!.changelanguage),
              ),
              ListTile(
                onTap: () => Navigator.pushNamed(context, ChangePassword.id),
                leading: const Icon(Icons.lock),
                title: Text(AppLocalizations.of(context)!.password),
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
                        onPressed: () => Navigator.pop(context, 'No'),
                        child: Text(
                          AppLocalizations.of(context)!.no,
                          style: TextStyle(color: AllColors.maincolor),
                        ),
                      ),
                      TextButton(
                        onPressed: () => _signout(),
                        child: Text(
                          AppLocalizations.of(context)!.yes,
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
        body: Padding(
          padding: EdgeInsets.only(right: 10.h, bottom: 10.h),
          child: Align(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, ChatScreen.id, (route) => false);
                  },
                  child: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40.r),
                        color: AllColors.chat),
                        child:Image.asset(AllImages.chatimage),
                  ))),
        ));
  }
}
