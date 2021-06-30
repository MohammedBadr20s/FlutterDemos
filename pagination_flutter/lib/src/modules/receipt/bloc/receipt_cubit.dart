
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pagination_flutter/src/modules/base/model/base_model.dart';
import 'package:pagination_flutter/src/modules/receipt/model/receipt_model.dart';

part 'receipt_state.dart';


class ReceiptCubit extends Cubit<ReceiptState>{
  ReceiptCubit() : super(ReceiptInital());



  void loadReceiptData() async {
    emit(ReceiptLoading());
    var jsonText = await rootBundle.loadString('assets/receiptJSON.json');
    var receiptData = BaseModel<ReceiptModel>.fromJson(json.decode(jsonText), ReceiptModel.fromJson(json.decode(jsonText)['value']));
    emit(ReceiptLoaded(receiptData: receiptData));
  }
}