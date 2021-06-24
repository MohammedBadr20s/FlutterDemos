
import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pagination_flutter/src/modules/transactions/model/transactionModel.dart';
import 'package:pagination_flutter/src/modules/transactions/repo/transactions_repo.dart';

part 'transaction_state.dart';

class TransactionCubit extends Cubit<TransactionState> {

  TransactionCubit({this.repo}): super(TransactionsInitial());

  int page = 1;
  static const fetch_limit = 15;
  final TransactionsRepo repo;


  void loadTransactions({bool showError = false}) {
    if (state is TransactionsLoading) return;
    final currentState = state;

    var oldTransactions = <TransactionsModel>[];
    if (currentState is TransactionError) {
      oldTransactions = currentState.currentTransactions;
    }
    if (currentState is TransactionsLoaded) {
      oldTransactions = currentState.transactions;
    }
    emit(TransactionsLoading(oldTransactions: oldTransactions, isFirstFetch: page == 1));
    if (showError == true) {
      emit(TransactionError(error: null, currentTransactions: oldTransactions));
    } else {
      Timer(Duration(seconds: 5), () {
        repo.getTransactions(page: page, limit: fetch_limit).then((newTransactions) {
          page++;
          final transactions = (state as TransactionsLoading).oldTransactions;
          transactions.addAll(newTransactions);
          emit(TransactionsLoaded(transactions:transactions));
        }).onError((error, stackTrace) {
          final errorRes = error as DioError;
          emit(TransactionError(error: errorRes, currentTransactions: oldTransactions));
        });
      });

    }

  }
}