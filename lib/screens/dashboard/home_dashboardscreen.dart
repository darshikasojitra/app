import 'package:demo_splash_screen/model/auth_service.dart';
import 'package:demo_splash_screen/resources/all_colors.dart';
import 'package:demo_splash_screen/resources/all_string.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:demo_splash_screen/screens/login/login_screen.dart';

class Home_Screen extends StatefulWidget {
  const Home_Screen({super.key});

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {
  User? user;
  final AuthService _auth = AuthService();

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
                color: AllColors.teal,
              ),
              currentAccountPicture: CircleAvatar(
                radius: 50,
                backgroundColor: AllColors.white,
                child: Text(
                  '${user?.displayName}'.substring(0,1).toUpperCase(),
                  style: TextStyle(color: AllColors.teal, fontSize: 40.0),
                ),
              ),
              accountName: Text(
                "${user?.displayName}",
                style: TextStyle(fontSize: 20, color: AllColors.white),
              ),
              accountEmail: Text(
                "${user?.email}",
                style: TextStyle(fontSize: 20, color: AllColors.white),
              ),
            ),
            const ListTile(
              leading: Icon(Icons.payment),
              title: Text('Payment method'),
            ),
            const ListTile(
              leading: Icon(Icons.house),
              title: Text('Addresses'),
            ),
            const ListTile(
              leading: Icon(Icons.password),
              title: Text('password'),
            ),
            const ListTile(
              leading: Icon(Icons.home_filled),
              title: Text('Household'),
            ),
            ListTile(
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Login_screen()));
              },
              leading: const Icon(Icons.logout),
              title: const Text(AllStrings.logout),
            ),
          ],
        ),
      ),
      // body:
    );
  }
}
