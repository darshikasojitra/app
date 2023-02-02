import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:demo_splash_screen/auth_service.dart';
import 'package:demo_splash_screen/screens/login_screen.dart';

class Home_Screen extends StatefulWidget {
  const Home_Screen({super.key});

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {
  User? user;
  AuthService _auth = AuthService();

  void initState() {
    user = _auth.getUser();
    super.initState();
  }
    bool _issignout = false;

  @override
  Widget build(BuildContext context) {
     final  height =MediaQuery.of(context).size.height;
   print(height);
    return Scaffold(appBar: AppBar(backgroundColor: Colors.teal,),
      drawer: Drawer(
        child: ListView( 
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Colors.teal,
              ),
              currentAccountPicture: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white,
                child: Text(
                  '${user?.displayName}'.substring(0,1).toUpperCase(),
                  style: TextStyle(color: Colors.teal, fontSize: 40.0),
                ),
              ),
              accountName: Text(
                "${user?.displayName}",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              accountEmail: Text(
                "${user?.email}",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
            ListTile(
              leading: Icon(Icons.payment),
              title: Text('Payment method'),
            ),
            ListTile(
              leading: Icon(Icons.house),
              title: Text('Addresses'),
            ),
            ListTile(
              leading: Icon(Icons.password),
              title: Text('password'),
            ),
            ListTile(
              leading: Icon(Icons.home_filled),
              title: Text('Household'),
            ),
            ListTile(
              onTap: () async{
                setState(() {
                  _issignout =true;
                });
                await FirebaseAuth.instance.signOut();
                setState(() {
                  _issignout=false;
                });
                Navigator.push(context, MaterialPageRoute(builder: (context)=> Login_screen()));
              },
              leading: Icon(Icons.logout),
              title: Text('logout'),
            ),
          ],
        ),
      ),
      body: Center(child: Text('hello')),
    );
  }
}
