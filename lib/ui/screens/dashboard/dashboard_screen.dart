import 'package:demo_splash_screen/l10n/localization.dart';
import 'package:demo_splash_screen/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:demo_splash_screen/ui/screens/dashboard/dashboard.dart';

class DashboardScreen extends StatefulWidget {
  static const String id = 'dashboard_screen';
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _myIndex = 0;
  static TextStyle optionStyle = TextStyle(
      fontSize: 30.sp, fontWeight: FontWeight.bold, color: AllColors.fontcolor);
  static List<Widget> widgetList = [
    const HomeScreen(),
    const VendorScreen(),
    // Text(
    //   'Vendor',
    //   style: optionStyle,
    // ),
    const ListScreen(),
    const CategoryPage(),
    const MoreScreen(),
  ];
  Future<void> _selectIndex(int index) async {
    setState(() {
      _myIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: widgetList[_myIndex]),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: AllColors.white,
          onTap: (index) => _selectIndex(index),
          currentIndex: _myIndex,
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
