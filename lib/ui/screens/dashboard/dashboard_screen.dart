import 'package:demo_splash_screen/l10n/localization.dart';
import 'package:demo_splash_screen/ui/screens/dashboard/home_dashboardscreen.dart';
import 'package:demo_splash_screen/ui/screens/list/list_screen.dart';
import 'package:demo_splash_screen/resources/all_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: camel_case_types
class dashboard_screen extends StatefulWidget {
  static const String id = 'dashboard_screen';
  const dashboard_screen({super.key});

  @override
  State<dashboard_screen> createState() => _dashboard_screenState();
}

class _dashboard_screenState extends State<dashboard_screen> {
  int myIndex = 0;
  static TextStyle optionStyle = TextStyle(
      fontSize: 30.sp, fontWeight: FontWeight.bold, color: AllColors.fontcolor);
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
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 28.sp,
              ),
              label: AppLocalizations.of(context)!.home,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.people,
                size: 28.sp,
              ),
              label: AppLocalizations.of(context)!.vendor,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.list,
                size: 28.sp,
              ),
              label: AppLocalizations.of(context)!.list,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.category,
                size: 28.sp,
              ),
              label: AppLocalizations.of(context)!.category,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.more,
                size: 28.sp,
              ),
              label: AppLocalizations.of(context)!.more,
            ),
          ]),
    );
  }
}
