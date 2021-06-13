

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mostadam_flutter_app/src/modules/Authentication/bloc/login_bloc.dart';
import 'package:mostadam_flutter_app/src/modules/Authentication/bloc/register_bloc.dart';
import 'package:mostadam_flutter_app/src/modules/Authentication/ui/RegistrationViews/RegisterView.dart';
import 'package:mostadam_flutter_app/src/modules/Authentication/ui/forget_password.dart';
import 'components/AppLocalizations.dart';
import 'components/SharedPreference.dart';
import 'modules/Authentication/ui/login_view.dart';
import 'modules/base/language_bloc.dart';
import 'modules/base/language_model.dart';
import 'modules/home/homeView.dart';



class App extends StatefulWidget {
  final LanguageBloc languageBloc;
  final LoginBloc loginBloc;
  final RegisterBloc registerBloc;
  final String initialRoute;
  App({this.languageBloc, this.loginBloc, this.registerBloc, this.initialRoute});

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight
    ]);
    return BlocProvider<LanguageBloc>.value(
      value: widget.languageBloc..add(LanguageLoadStarted()),
      child: BlocBuilder<LanguageBloc, LanguageState>(
        builder: (context, languageState) {
          return MaterialApp(
            theme: ThemeData.light(),
            initialRoute: widget.initialRoute,
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate
            ],
            routes: {
              '/': (context) => LoginView(bloc: widget.loginBloc),
              '/forget_password': (context) => ForgetPassword(bloc: widget.loginBloc),
              'register': (context) => RegisterView(registerBloc: widget.registerBloc),
              '/home': (context) => HomeView()
            },
            supportedLocales: Language.values.map((e) => Locale(e.toString().split(".").last.toLowerCase())).toList(),
            locale: languageState.locale,
            localeResolutionCallback: (currentLang, supportedLang) {
              if (currentLang != null) {
                for (Locale local in supportedLang) {
                  if (local.languageCode == currentLang.languageCode) {
                    return currentLang;
                  }
                }
              }
              return supportedLang.first;
            },
          );
        },
      ),
    );
  }
}
