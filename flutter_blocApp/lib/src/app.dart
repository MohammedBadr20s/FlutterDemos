import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blocApp/src/components/AppLocalizations.dart';
import 'package:flutter_blocApp/src/components/connectivity.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../src/models/LanguageModel.dart';
import 'blocs/language_bloc.dart';
import 'blocs/movie_detail_bloc.dart';
import 'blocs/movies_bloc.dart';
import 'models/item_model.dart';
import 'ui/movie_detail.dart';
import 'ui/movie_list.dart';
import 'package:intl/intl.dart';

class App extends StatelessWidget {
  final MoviesBloc moviesBloc;
  final MovieDetailBloc movieDetailBloc;
  final LanguageBloc languageBloc;
  final MyConnectivity connectivity;

  App({this.moviesBloc, this.movieDetailBloc, this.languageBloc, this.connectivity});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight
    ]);
    return BlocProvider<LanguageBloc>.value(
      value: languageBloc..add(LanguageLoadStarted()),
      child: BlocBuilder<LanguageBloc, LanguageState>(
          // ignore: missing_return
          builder: (context, languageState) {
          return MaterialApp(
            theme: ThemeData.dark(),
            initialRoute: '/',
            // ignore: missing_return
            onGenerateRoute: (settings) {
              if (settings.name == 'movieDetail') {
                final Result result = settings.arguments;
                final DateTime now = result.releaseDate;
                final DateFormat formatter = DateFormat('yyyy-MM-dd');
                final String formattedReleaseDate = formatter.format(now);
                return MaterialPageRoute(builder: (context) {
                  return MovieDetail(
                    bloc: movieDetailBloc,
                    title: result.title,
                    posterUrl: result.posterPath,
                    description: result.overview,
                    releaseDate: formattedReleaseDate,
                    voteAverage: result.voteAverage.toString(),
                    movieId: result.id,
                  );
                });
              }
            },
            routes: {
              '/': (context) =>
                  MovieList(bloc: moviesBloc, languageBloc: languageBloc, connectivity: connectivity),
            },
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate
            ],
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
      }),
    );
  }
}
