import 'package:demo_splash_screen/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'l10n/l1on.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:demo_splash_screen/l10n/localization.dart';
//import 'package:flutter_gen/gen_l10n/app_localizations.dart';
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        minTextAdapt: true,
        builder: (BuildContext context, Widget? child) {
          return MaterialApp(
            localizationsDelegates:  const [
                AppLocalizations.delegate,
                //  GlobalMaterialLocalizations.delegate,
                //  GlobalWidgetsLocalizations.delegate,
                // GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: L10n.all,
            home: const splashScreen(),
          );
        });
  }
}
