import 'package:demo_splash_screen/bloc/network_cubit.dart';
import 'package:demo_splash_screen/bloc/network_services.dart';
import 'package:demo_splash_screen/controller/local_provider.dart';
import 'package:demo_splash_screen/ui/screens/splash/splash_screen.dart';
import 'package:demo_splash_screen/user_preferences/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:demo_splash_screen/l10n/localization.dart';
import 'package:provider/provider.dart' as prov;

import 'resources/routes_manager/route_manager.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? locale;
  @override
  void initState() {
    super.initState();
    UserPreferences.getLocaleLanguageCode().then((value) => {
          setState(() {
            LocaleProvider().setLocale(locale = Locale(value));
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    var networkService = NetworkService();
    return MultiBlocProvider(
      providers: [
        BlocProvider<NetworkCubit>(
          create: (context) =>
              NetworkCubit(networkService: networkService, context: context),
        ),
      ],
      child: prov.ChangeNotifierProvider(
        create: (_) => LocaleProvider(),
        child: prov.Consumer<LocaleProvider>(builder: (context, model, child) {
          return ScreenUtilInit(
              minTextAdapt: false,
              builder: (BuildContext context, Widget? child) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  onGenerateTitle: (context) =>
                            AppLocalizations.of(context)!.appName,
                            locale: model.locale ?? locale,
                  localizationsDelegates: const [
                    AppLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  supportedLocales: L10n.all,
                  initialRoute: splashScreen.id,
                        routes: routes,
                );
              });
        }),
      ),
    );
  }
}
