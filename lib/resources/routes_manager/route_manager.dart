import 'package:demo_splash_screen/ui/screens/dashboard/change_language.dart';
import 'package:demo_splash_screen/ui/screens/dashboard/dashboard_screen.dart';
import 'package:demo_splash_screen/ui/screens/list/list_screen.dart';
import 'package:demo_splash_screen/ui/screens/login/login_screen.dart';
import 'package:demo_splash_screen/ui/screens/product/product_screen.dart';
import 'package:flutter/cupertino.dart';
import '../../ui/screens/splash/splash_screen.dart';

final Map<String, WidgetBuilder> routes = {
  splashScreen.id: (context) => const splashScreen(),
  Product_Page.id: (context) => const Product_Page(),
  List_Screen.id: (context) => const List_Screen(),
  Login_screen.id: (context) => const Login_screen(),
  dashboard_screen.id: (context) => const dashboard_screen(),
  LanguageScreen.id: (context) => const LanguageScreen(),
};

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}