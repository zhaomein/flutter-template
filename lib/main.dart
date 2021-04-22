import 'package:bloc/bloc.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mcaio/config/routes.dart';
import 'package:mcaio/helpers/file_helpers.dart';
import 'package:mcaio/bloc_observer.dart';
import 'app/app_bloc.dart';
import 'language.dart';

void main() {
  Bloc.observer = AppBlocObserver();
  runApp(App());
  FileHelper.createAppDirectories();
  // Firebase.initializeApp();
}

class App extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppBloc>(
      create: (context) => AppBloc(),
      child: MaterialApp(
        title: 'Template',
        localizationsDelegates: [
          AppLocalizationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate
        ],
        supportedLocales: [
          // const Locale('en', 'US'),
          const Locale('vi', 'VN'),
        ], 
        localeResolutionCallback: (Locale locale, Iterable<Locale> supportedLocales) {  
          if (locale == null) {
            debugPrint("Language locale is null!!. Set support to first!");
            return supportedLocales.first;
          }

          for (Locale supportedLocale in supportedLocales) {  
            if (supportedLocale.languageCode == locale.languageCode || supportedLocale.countryCode == locale.countryCode) {  
              return supportedLocale;  
            }
          }
          return supportedLocales.first;  
        },
        locale: Locale('vi', 'VN'),
        theme: ThemeData(
          // textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
          backgroundColor: Colors.grey[300],
          primarySwatch: Colors.blue,
          buttonTheme: ButtonThemeData(
            textTheme: ButtonTextTheme.accent,
            colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: Colors.orange,
              secondary: Colors.white,
            ),
          )
        ),
        initialRoute: Routes.splash,
        routes: Routes.map,
      )
    );
  }
}
