import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pagination_flutter/src/modules/landing_view.dart';
import 'package:pagination_flutter/src/modules/receipt/bloc/receipt_cubit.dart';
import 'package:pagination_flutter/src/modules/receipt/ui/receipt_view.dart';
import 'package:pagination_flutter/src/modules/transactions/bloc/transaction_cubit.dart';
import 'package:pagination_flutter/src/modules/transactions/ui/charts_view.dart';
import 'package:pagination_flutter/src/modules/transactions/ui/transactions_view.dart';

import 'modules/transactions/ui/file_picker.dart';
import 'modules/transactions/ui/hijri_date_picker.dart';
import 'modules/transactions/ui/transaction_details.dart';

class PaginationScreen extends StatelessWidget {
  final TransactionCubit transactionCubit;
  final ReceiptCubit receiptCubit;

  PaginationScreen({this.transactionCubit, this.receiptCubit});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      initialRoute: '/',
      routes: {
        '/': (context) => LandingView(),
        'transaction_view': (context) => TransactionView(transactionCubit: transactionCubit),
        'charts_view': (context) => ChartsView(),
        'transaction_detail': (context) => TransactionDetails(),
        'date_picker': (context) => HijriDatePicker(),
        'file_picker': (context) => FilePickerView(),
        'receipt_view': (context) => ReceiptView(receiptCubit: receiptCubit)
      },
      localizationsDelegates: [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale("ar", "SA"), // OR Locale('ar', 'AE') OR Other RTL locales
        Locale("en", "")
      ],
      locale: Locale("ar", "SA"),
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
  }
}
