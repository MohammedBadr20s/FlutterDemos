


import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:pagination_flutter/src/modules/transactions/bloc/transaction_cubit.dart';
import 'package:pagination_flutter/src/modules/transactions/repo/transactions_repo.dart';
import 'package:pagination_flutter/src/resources/client.dart';

final getIt = GetIt.instance;
final logger = Logger();

void init() {
  getIt.registerSingleton<Dio>(Dio());
  getIt.registerSingleton<Logger>(Logger());
  getIt.registerLazySingleton<Client>(() => Client(getIt()));
  getIt.registerLazySingleton<TransactionsRepo>(() => TransactionsRepo(client: getIt()));
  getIt.registerFactory<TransactionCubit>(() => TransactionCubit(repo: getIt()));
}