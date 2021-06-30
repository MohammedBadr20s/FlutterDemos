import 'package:flutter/material.dart';

import 'src/app.dart';
import 'src/di/injection.dart' as di;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  di.init();

  runApp(PaginationScreen(transactionCubit: di.getIt(), receiptCubit: di.getIt()));
}


