import 'package:pagination_flutter/src/modules/transactions/model/transactionModel.dart';
import 'package:pagination_flutter/src/resources/urls.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';


part 'client.g.dart';

@RestApi(baseUrl: urls.baseURL)
abstract class Client {
  factory Client(Dio client, {String baseUrl}) = _Client;

  @GET(urls.transactions)
  @FormUrlEncoded()
  Future<List<TransactionsModel>> getTransactions({
    @Query('_page') int page,
    @Query('_limit') int limit
  });

}