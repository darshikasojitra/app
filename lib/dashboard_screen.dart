import 'package:demo_splash_screen/auth_service.dart';
import 'package:demo_splash_screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class dashboard_screen extends StatefulWidget {
  const dashboard_screen({super.key});

  @override
  State<dashboard_screen> createState() => _dashboard_screenState();
}

class _dashboard_screenState extends State<dashboard_screen> {
  User? user;
  AuthService _auth = AuthService();
 
  void initState() {
     user =  _auth.getUser();
    super.initState();
  }

  void signOut() {
  FirebaseAuth.instance.signOut();
  User? user = FirebaseAuth.instance.currentUser;
  runApp(
      new MaterialApp(
        home: new Login_screen(),
      )

  );
}
  
  int myIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.teal);

  static const List<Widget> widgetList = [
    Text(
      'Home',
      style: optionStyle,
    ),
    Text(
      'Vendors',
      style: optionStyle,
    ),
    Text(
      'List',
      style: optionStyle,
    ),
    Text(
      'Category',
      style: optionStyle,
    ),
    Text(
      'More',
      style: optionStyle,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
      ),
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
               onTap: signOut,
              leading: Icon(Icons.logout),
              title: Text('logout'),
            ),
          ],
        ),
      ),
      body: Center(child: widgetList[myIndex]),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.teal,
          onTap: (index) {
            setState(() {
              myIndex = index;
            });
          },
          currentIndex: myIndex,
          selectedItemColor: Colors.white,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 30,
              ),
              label: 'home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.people,
                size: 30,
              ),
              label: 'Vendors',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.list,
                size: 30,
              ),
              label: 'list',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.category,
                size: 30,
              ),
              label: 'category',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.more,
                size: 30,
              ),
              label: 'more',
            ),
          ]),
    );
  }
}
