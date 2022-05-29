import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:magdsoft_flutter_structure/business_logic/bloc_observer.dart';
import 'package:magdsoft_flutter_structure/data/local/cache_helper.dart';
import 'package:magdsoft_flutter_structure/data/models/account_model.dart';
import 'package:magdsoft_flutter_structure/data/remote/dio_helper.dart';
import 'package:magdsoft_flutter_structure/presentation/screens/user/login_screen.dart';
import 'package:magdsoft_flutter_structure/presentation/screens/user/register_screen.dart';
import 'package:magdsoft_flutter_structure/presentation/screens/user/user_data_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'data/local/local_data.dart';


late LocalizationDelegate delegate;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  BlocOverrides.runZoned(
        () async {
      DioHelper.init();
      await CacheHelper.init();

       lang = CacheHelper.getDataFromSharedPreference(key: 'lang') ?? "ar";


      if (CacheHelper.getDataFromSharedPreference(key: "currentAccount") != null) {
        currentAccount = Account.fromJson(jsonDecode(CacheHelper.getDataFromSharedPreference(key: "currentAccount")));
      }


      String? widgetId;

      if (currentAccount != null) {
        widgetId = UserDataScreen.id;
      } else {
        widgetId = LoginScreen.id;
      }


      runApp(MyHomePageApp(widgetId: widgetId,));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyHomePageApp extends StatefulWidget {

  final String widgetId;
  const MyHomePageApp({Key? key, required this.widgetId}) : super(key: key);


  static void setLocale(BuildContext context, Locale newLocale) async {
    _MyHomePageAppState? state =
    context.findAncestorStateOfType<_MyHomePageAppState>();
    state?.changeLanguage(newLocale);
  }

  @override
  State<MyHomePageApp> createState() => _MyHomePageAppState();
}

class _MyHomePageAppState extends State<MyHomePageApp> {



  Locale _locale = Locale.fromSubtags(languageCode: lang);

  changeLanguage(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      restorationScopeId: 'root',
      debugShowCheckedModeBanner: false,
      title: 'Werash',

      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      locale: _locale,
      supportedLocales: const [
        Locale('en', ''), // English, no country code
        Locale('ar', ''), // Arabic, no country code
      ],

      theme: ThemeData(
        fontFamily: 'cairo',
        //scaffoldBackgroundColor: AppColors.white,
        appBarTheme: const AppBarTheme(
          elevation: 0.0,
          systemOverlayStyle: SystemUiOverlayStyle(
            //statusBarColor: AppColors.transparent,
            statusBarIconBrightness: Brightness.dark,
          ),
        ),
      ),


      routes: {
        LoginScreen.id: (context) => const LoginScreen(),
        UserDataScreen.id: (context) => const UserDataScreen(),
        RegisterScreen.id: (context) => const RegisterScreen(),
      },

      initialRoute: widget.widgetId,


    );
  }
}