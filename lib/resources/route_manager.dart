import 'package:demo_splash_screen/ui/screens/dashboard/dashboard.dart';
import 'package:demo_splash_screen/ui/screens/dashboard/dashboard_screen.dart';
import 'package:demo_splash_screen/ui/screens/dashboard/home_dashboardscreen/chat/chat_screen.dart';
import 'package:demo_splash_screen/ui/screens/login/login_screen.dart';
import 'package:demo_splash_screen/ui/screens/login/resetpassword_screen.dart';
import 'package:demo_splash_screen/ui/screens/signup/signup_screen.dart';
import 'package:flutter/cupertino.dart';
import '../ui/screens/dashboard/home_dashboardscreen/chat/detail_chatscreen.dart';
import '../ui/screens/splash/splash_screen.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.id: (context) => const SplashScreen(),
   HomeScreen.id: (context) => const HomeScreen(),
  ListScreen.id: (context) => const ListScreen(),
  LoginScreen.id: (context) => const LoginScreen(),
  DashboardScreen.id: (context) => const DashboardScreen(),
  SignupScreen.id:(context) => const SignupScreen(),
  LanguageScreen.id: (context) => const LanguageScreen(),
  ResetPasswordScreen.id: (context) => const ResetPasswordScreen(),
  AddNewUserScreen.id: (context) => const AddNewUserScreen(),
   AddressScreen.id: (context) => const AddressScreen(),
   PaymentMethodScreen.id:(context) => const PaymentMethodScreen(),
   ChangePassword.id: (context) => const ChangePassword(),
   ChatScreen.id: (context) => const ChatScreen(),
   DetailChatScreen.id: (context) => const DetailChatScreen(),
};

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}