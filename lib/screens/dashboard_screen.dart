import 'package:demo_splash_screen/home_dashboardscreen.dart';
import 'package:demo_splash_screen/list_screen.dart';
import 'package:flutter/material.dart';

class dashboard_screen extends StatefulWidget {
  const dashboard_screen({super.key});

  @override
  State<dashboard_screen> createState() => _dashboard_screenState();
}

class _dashboard_screenState extends State<dashboard_screen> {
  int myIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Color(0xff8BC53F));
  static const List<Widget> widgetList = [
    Home_Screen(),
    Text(
      'Vendor',
      style: optionStyle,
    ),
    List_Screen(),
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
      body: Center(child: widgetList[myIndex]),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          onTap: (index) {
            setState(() {
              myIndex = index;
            });
          },
          currentIndex: myIndex,
          unselectedItemColor: Color(0xff1E8040),
          selectedItemColor: Color(0xff8BC53F),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 30,
              ),
              label: 'Home',
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
              label: 'List',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.category,
                size: 30,
              ),
              label: 'Category',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.more,
                size: 30,
              ),
              label: 'More',
            ),
          ]),
    );
  }
}
