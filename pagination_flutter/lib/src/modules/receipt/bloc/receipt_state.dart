

part of 'receipt_cubit.dart';


abstract class ReceiptState {}

class ReceiptInital extends ReceiptState {}

class ReceiptLoading extends ReceiptState {}

class ReceiptLoaded extends ReceiptState {
  final BaseModel<ReceiptModel> receiptData;
  ReceiptLoaded({this.receiptData});
}