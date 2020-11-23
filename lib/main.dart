import 'package:com.kaiyouit.caiwai/blocs/app/bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:com.kaiyouit.caiwai/config/themes.dart';
import 'package:com.kaiyouit.caiwai/repositories/chat_repository.dart';
import 'package:com.kaiyouit.caiwai/widgets/restart_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:com.kaiyouit.caiwai/config/routes.dart';
import 'package:com.kaiyouit.caiwai/bloc_delegate.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:intl/intl.dart';
import 'language.dart';

void main() {
  BlocSupervisor.delegate = AppBlocDelegate();
  runApp(RestartApp(child: App()));
}

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);

    return BlocProvider<AppBloc>(
        create: (BuildContext context) => AppBloc(),
        child: BlocListener<AppBloc, AppState>(
            listener: (context, state) {
              if(state.isAuthenticated) {
                ChatRepository.initialize(state.token);
              }
            },
            child: BlocBuilder<AppBloc, AppState>(
              condition: (currentState, comingState) {
                return comingState.language != currentState.language;
              },
              builder: (context, state) {
                Intl.defaultLocale = state.language;
                return MaterialApp(
                  title: 'Caiwai',
                  localizationsDelegates: [
                    AppLocalizationsDelegate(),
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate
                  ],
                  supportedLocales: AppLg.getLocales,
                  localeResolutionCallback: (Locale locale, Iterable<Locale> supportedLocales) {
                    if (locale == null) {
                      print("Language locale is null!!. Set support to first!");
                      return supportedLocales.first;
                    }
                    for (Locale supportedLocale in supportedLocales) {
                      if (supportedLocale.languageCode == locale.languageCode || supportedLocale.countryCode == locale.countryCode) {
                        return supportedLocale;
                      }
                    }
                    return supportedLocales.first;
                  },
                  locale: Locale(state.language),
                  theme: lightTheme,
                  initialRoute: Routes.splash,  //set default route
                  routes: Routes.map,
                );
              },
            )
        )
    );
  }
}