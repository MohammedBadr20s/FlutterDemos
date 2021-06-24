import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pagination_flutter/src/modules/transactions/bloc/transaction_cubit.dart';
import 'package:pagination_flutter/src/modules/transactions/model/transactionModel.dart';

class TransactionView extends StatelessWidget {

  final TransactionCubit transactionCubit;

  TransactionView({this.transactionCubit});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => transactionCubit,
      child: Transactions(),
    );
  }
}


class Transactions extends StatelessWidget {

  final scrollController = ScrollController();
  void setupScrollController(BuildContext context) {
    scrollController.addListener(() {
      if ((scrollController.position.maxScrollExtent - 10 != 0) && scrollController.position.pixels != 0 && BlocProvider.of<TransactionCubit>(context).page != 3)  {
        BlocProvider.of<TransactionCubit>(context).loadTransactions();
      }

    });
  }
  @override
  Widget build(BuildContext context) {
    setupScrollController(context);
    BlocProvider.of<TransactionCubit>(context).loadTransactions();
    return Scaffold(
      appBar: AppBar(
        title: Text('المدفوعات'),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
          child: _TransactionList(context: context)
      ),
    );
  }

  Widget _TransactionList({BuildContext context}) {
    return BlocBuilder<TransactionCubit, TransactionState>(
        builder: (context, state) {
          if (state is TransactionsLoading && state.isFirstFetch) {
            return _loadingIndicator();
          }

          List<TransactionsModel> transactions = [];
          bool isLoading = false;
          bool isError = false;
          if (BlocProvider.of<TransactionCubit>(context).page == 3 &&  state is TransactionError == false) {
            BlocProvider.of<TransactionCubit>(context).loadTransactions(showError: true);
          }
          if (state is TransactionsLoading) {
            transactions = state.oldTransactions;
            isLoading = true;
          }
          if (state is TransactionsLoaded) {
            transactions = state.transactions;
            isLoading = false;
          }
          if (state is TransactionError) {
            transactions = state.currentTransactions;
            isError = true;
            isLoading = false;
          }
          return ListView.separated(
            controller: scrollController,
              itemBuilder: (context, index) {
                if (index < transactions.length) {
                  return InkWell(
                      child: _transactionsCell(model: transactions[index], context: context),
                    onTap: () {
                        Navigator.pushNamed(context, 'transaction_detail');
                    },
                  );
                } else {

                  if (isError == true) {
                    return _errorView(context: context);
                  } else {
                    scrollController.jumpTo(
                        scrollController.position.maxScrollExtent
                    );
                    return _loadingIndicator();
                  }
                }
              },
              separatorBuilder: (context, index) {
                return Divider(
                  color: Colors.transparent,
                );
          },
              itemCount: transactions.length + (isLoading ? 1 : (isError ? 1 : 0))
          );
        }
    );
  }

  Widget _loadingIndicator() {
    return Center(child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.black)));
  }

  Widget _errorView({BuildContext context}) {
    return Column(
      children: [
        Text('حدث خطأ ما يرجى المحاولة مرة أخرى',
          style: TextStyle(
              fontSize: 17,
              color: Colors.redAccent,
              fontWeight: FontWeight.normal
          ),
        ),
        Container(height: 20),
        TextButton.icon(
            onPressed: () {
              BlocProvider.of<TransactionCubit>(context).loadTransactions(showError: false);
            }, label: Text('إعادة المحاولة',
          style: TextStyle(
              fontSize: 17,
              color: Colors.black,
              fontWeight: FontWeight.bold
          )
        ),
          icon: Icon(Icons.refresh, color: Colors.black),
        )
      ],
    );
  }
  Widget _transactionsCell({TransactionsModel model, BuildContext context}) {
    var currentDate = DateFormat('dd/MM/yyyy HH:MM:ss', 'ar').format(DateTime.now());
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black, width: 0.5)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
              children: [
            Container(
              width: 150,
              child: Text('${model.id} التاجر',
                style: TextStyle(
                    fontSize: 17,
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
            Text('محمد أحمد',
              style: TextStyle(
                  fontSize: 17,
                  color: Colors.black,
                  fontWeight: FontWeight.bold
              ),
            ),
          ]
          ),
          Container(height: 20),
          Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
            Container(
              width: 150,
              child: Text('التاريخ',
                style: TextStyle(
                    fontSize: 17,
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width - 250,
              child: FittedBox(
                fit: BoxFit.contain,
                child: Text('${currentDate}',
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
          ]
          ),
          Container(height: 10),
          Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 150,
                  child: Text('المبلغ',
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.black,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Text('٢٠٠٠٠ ريال سعودي',
                  style: TextStyle(
                      fontSize: 17,
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ]
          ),
          Container(height: 10),
          Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 150,
                  child: Text('المبلغ المخصوم',
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.black,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Text('٢٠٠٠ ريال سعودي',
                  style: TextStyle(
                      fontSize: 17,
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ]
          ),
          Container(height: 10),
          Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 150,
                  child: Text('نسبة المخصوم',
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.black,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Text("٢٥٪",
                  style: TextStyle(
                      fontSize: 17,
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ]
          ),
          Container(height: 10),
          Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 150,
                  child: Text('البنك',
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.black,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Text("بنك الرياض",
                  style: TextStyle(
                      fontSize: 17,
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ]
          ),
        ],
      ),
    );
  }
}
