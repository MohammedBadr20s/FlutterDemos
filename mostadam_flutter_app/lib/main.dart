import 'package:flutter/material.dart';
import 'package:mostadam_flutter_app/src/app.dart';
import 'src/components/SharedPreference.dart';
import 'src/di/injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  di.init();
  final sharedPrefs = await SharedPreferencesService.instance;
  final initialRoute = sharedPrefs.getToken == null ? '/' : '/';
  runApp(App(languageBloc: di.getIt(), loginBloc: di.getIt(), registerBloc: di.getIt(), initialRoute: initialRoute));
}
