import 'package:demo_splash_screen/screens/dashboard/home_dashboardscreen.dart';
import 'package:demo_splash_screen/screens/list/list_screen.dart';
import 'package:demo_splash_screen/resources/all_colors.dart';
import 'package:flutter/material.dart';

class dashboard_screen extends StatefulWidget {
  const dashboard_screen({super.key});

  @override
  State<dashboard_screen> createState() => _dashboard_screenState();
}

class _dashboard_screenState extends State<dashboard_screen> {
  int myIndex = 0;
  static TextStyle optionStyle = TextStyle(
      fontSize: 30, fontWeight: FontWeight.bold, color: AllColors.fontcolor);
  static List<Widget> widgetList = [
    const Home_Screen(),
    Text(
      'Vendor',
      style: optionStyle,
    ),
    const List_Screen(),
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
          backgroundColor: AllColors.white,
          onTap: (index) {
            setState(() {
              myIndex = index;
            });
          },
          currentIndex: myIndex,
          unselectedItemColor: AllColors.maincolor,
          selectedItemColor: AllColors.fontcolor,
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
