


import 'package:pagination_flutter/src/modules/transactions/model/transactionModel.dart';
import 'package:pagination_flutter/src/resources/client.dart';

class TransactionsRepo {
  final Client client;

  TransactionsRepo({this.client});

  Future<List<TransactionsModel>> getTransactions({int page, int limit}) => client.getTransactions(page: page, limit: limit);
}