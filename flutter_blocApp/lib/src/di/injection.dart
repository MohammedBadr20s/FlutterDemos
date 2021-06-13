import 'package:dio/dio.dart';
import 'package:flutter_blocApp/src/blocs/language_bloc.dart';
import 'package:flutter_blocApp/src/blocs/movie_detail_bloc.dart';
import 'package:flutter_blocApp/src/blocs/movies_bloc.dart';
import 'package:flutter_blocApp/src/components/connectivity.dart';
import 'package:flutter_blocApp/src/resources/movie_api_provider.dart';
import 'package:flutter_blocApp/src/resources/repository.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

final getIt = GetIt.instance;
final logger = Logger();
void init() {
  final _apiKey = '67a9c266b3ab9aa364cc5ddd59b2fbc3';
  getIt.registerSingleton<Dio>(Dio());
  getIt.registerSingleton<Logger>(Logger());
  getIt.registerSingleton(MyConnectivity.instance);
  getIt.registerSingleton<LanguageBloc>(LanguageBloc());
  getIt.registerLazySingleton<MovieApiProvider>(() => MovieApiProvider(getIt()));
  getIt.registerLazySingleton<Repository>( () =>
      Repository(moviesApiProvider: getIt(), apiKey: _apiKey));
  getIt.registerFactory<MoviesBloc>(() => MoviesBloc(repository: getIt()));
  getIt.registerFactory<MovieDetailBloc>(
          () => MovieDetailBloc(repository: getIt()));
}