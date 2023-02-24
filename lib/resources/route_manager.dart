import 'package:demo_splash_screen/ui/screens/dashboard/change_language.dart';
import 'package:demo_splash_screen/ui/screens/dashboard/dashboard_screen.dart';
import 'package:demo_splash_screen/ui/screens/list_dashboardscreen/wishlist_screen.dart';
import 'package:demo_splash_screen/ui/screens/login/login_screen.dart';
import 'package:demo_splash_screen/ui/screens/product_screen/product_screen.dart';
import 'package:demo_splash_screen/ui/screens/signup/signup_screen.dart';
import 'package:flutter/cupertino.dart';
import '../ui/screens/splash/splash_screen.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.id: (context) => const SplashScreen(),
  ProductPage.id: (context) => const ProductPage(),
  ListScreen.id: (context) => const ListScreen(),
  LoginScreen.id: (context) => const LoginScreen(),
  DashboardScreen.id: (context) => const DashboardScreen(),
  SignupScreen.id:(context) => const SignupScreen(),
  LanguageScreen.id: (context) => const LanguageScreen(),
};

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}