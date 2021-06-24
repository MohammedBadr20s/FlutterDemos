
part of 'transaction_cubit.dart';

abstract class TransactionState{}

class TransactionsInitial extends TransactionState {}


class TransactionsLoaded extends TransactionState {
  final List<TransactionsModel> transactions;

  TransactionsLoaded({this.transactions});

}


class TransactionsLoading extends TransactionState {
  final List<TransactionsModel> oldTransactions;
  final bool isFirstFetch;
  TransactionsLoading({this.oldTransactions, this.isFirstFetch = false});
}
class TransactionError extends TransactionState {
  final DioError error;
  final List<TransactionsModel> currentTransactions;

  TransactionError({this.error, this.currentTransactions});
}