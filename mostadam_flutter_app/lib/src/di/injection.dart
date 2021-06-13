import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:mostadam_flutter_app/src/components/Connectivity.dart';
import 'package:mostadam_flutter_app/src/components/SharedPreference.dart';
import 'package:mostadam_flutter_app/src/modules/Authentication/bloc/login_bloc.dart';
import 'package:mostadam_flutter_app/src/modules/Authentication/bloc/register_bloc.dart';
import 'package:mostadam_flutter_app/src/resources/client.dart';
import 'package:mostadam_flutter_app/src/modules/base/language_bloc.dart';
import 'package:mostadam_flutter_app/src/modules/Authentication/repo/AuthenticationRepo.dart';

final getIt = GetIt.instance;
final logger = Logger();

void init() {
  getIt.registerSingleton<Dio>(Dio());
  getIt.registerSingleton<Logger>(Logger());
  getIt.registerSingleton(MyConnectivity.instance);
  getIt.registerSingleton<Future<SharedPreferencesService>>(SharedPreferencesService.instance);
  getIt.registerSingleton<LanguageBloc>(LanguageBloc());
  getIt.registerLazySingleton<Client>(() => Client(getIt()));
  getIt.registerLazySingleton<Repository>(
      () => Repository(client: getIt()));
  getIt.registerFactory<LoginBloc>(() => LoginBloc(repository: getIt()));
  getIt.registerFactory<RegisterBloc>(() => RegisterBloc(repository: getIt()));
}
