import 'package:flutter/material.dart';
import 'package:flutter_blocApp/src/app.dart';
import 'src/di/injection.dart' as di;

void main() {
  di.init();
  runApp(App(
    moviesBloc: di.getIt(),
    movieDetailBloc: di.getIt(),
    languageBloc: di.getIt(),
    connectivity: di.getIt(),
  ));
}
