import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pagination_flutter/src/components/Generic+Views.dart';
import 'package:pagination_flutter/src/modules/base/model/base_model.dart';
import 'package:pagination_flutter/src/modules/receipt/bloc/receipt_cubit.dart';
import 'package:pagination_flutter/src/modules/receipt/model/receipt_model.dart';

class ReceiptView extends StatefulWidget {
  final ReceiptCubit receiptCubit;

  ReceiptView({this.receiptCubit});
  @override
  _ReceiptViewState createState() => _ReceiptViewState();
}

class _ReceiptViewState extends State<ReceiptView> {

  @override
  void initState() {
    // TODO: implement initState
    widget.receiptCubit.loadReceiptData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => widget.receiptCubit,
        child: ReceiptData()
    );
  }
}

class ReceiptData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Receipt'),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: BlocBuilder<ReceiptCubit, ReceiptState>(

            builder: (context, state) {
              if (state is ReceiptLoaded) {
                BaseModel<ReceiptModel> receipt;
                receipt = state.receiptData;

                final DateFormat formatterDate = DateFormat("dd/MM/yyyy");
                var trxDate = formatterDate.format(receipt.value.trxDate);
                final DateFormat formatterTime = DateFormat("h:mm:ss");
                var trxTime = formatterTime.format(receipt.value.trxDate);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset('assets/images/madaLogo.jpg',
                            width: 200, height: 100, fit: BoxFit.contain)),
                    Container(height: 10),
                    CustomAppText(
                        title: receipt.value.merchantNameAr,
                        fontColor: Colors.black,
                        fontSize: 16),
                    CustomAppText(
                        title: receipt.value.merchantNameEn,
                        fontColor: Colors.black,
                        fontSize: 16),
                    CustomAppText(
                        title: receipt.value.merchantAddressAr, fontColor: Colors.black, fontSize: 16),
                    CustomAppText(
                        title: receipt.value.merchantAddressEn,
                        fontColor: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                    CustomAppText(
                        title: receipt.value.merchantPhone,
                        fontColor: Colors.black,
                        fontSize: 16),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CustomAppText(
                              title: trxTime,
                              fontColor: Colors.black,
                              fontSize: 16),
                          Container(width: 120),
                          CustomAppText(
                              title: trxDate,
                              fontColor: Colors.black,
                              fontSize: 16),
                        ]),
                    MadaDataView(receiptData: receipt),
                    TransactionDataView(receiptData: receipt),
                    Container(height: 20)
                  ],
                );
              } else {
                return Center(child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.black)));
              }

            }
          ),
        ),
      ),
    );
  }
}

class MadaDataView extends StatelessWidget {
  final BaseModel<ReceiptModel> receiptData;
  MadaDataView({this.receiptData});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomAppText(
                  title: receiptData.value.fullTid,
                  fontColor: Colors.black,
                  fontSize: 16),
              Container(width: 50),
              CustomAppText(
                  title: receiptData.value.merchantCode,
                  fontColor: Colors.black,
                  fontSize: 16),
              CustomAppText(
                  title: receiptData.value.bankAbbreviation,
                  fontColor: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ]),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomAppText(
                  title: receiptData.value.rrn,
                  fontColor: Colors.black,
                  fontSize: 16),
              Container(width: 60),
              CustomAppText(
                  title: '${receiptData.value.aquireId}${receiptData.value.stan}${receiptData.value.appVersion}',
                  fontColor: Colors.black,
                  fontSize: 16),
            ]),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomAppText(
                  title: receiptData.value.schemaNameAr,
                  fontColor: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
              Container(width: 60),
              CustomAppText(
                  title: receiptData.value.schemaNameEn,
                  fontColor: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ]),
      ],
    );

  }
}

class TransactionDataView extends StatelessWidget {
  final BaseModel<ReceiptModel> receiptData;
  TransactionDataView({this.receiptData});

  @override
  Widget build(BuildContext context) {
    final DateFormat formatterDate = DateFormat("dd/MM/yyyy");
    var trxDate = formatterDate.format(receiptData.value.trxDate);
    final DateFormat formatterTime = DateFormat("h:mm:ss");
    var trxTime = formatterTime.format(receiptData.value.trxDate);
    return Column(
      children: [
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomAppText(
                  title: receiptData.value.getTransType(lang: "ar", transType: receiptData.value.trxType),
                  fontColor: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
              Container(width: 60),
              CustomAppText(
                  title: receiptData.value.getTransType(lang: "en", transType: receiptData.value.trxType),
                  fontColor: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ]),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomAppText(
                  title: receiptData.value.expireDate != null ? receiptData.value.expireDate : "تاريخ الإنتهاء غير متوفر",
                  fontColor: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
              Container(width: 60),
              CustomAppText(
                  title: receiptData.value.pan,
                  fontColor: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ]),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomAppText(
                  title: 'مبلغ ${receiptData.value.getTransType(transType: receiptData.value.trxType, lang: "ar")}',
                  fontColor: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
              Container(width: 60),
              CustomAppText(
                  title: '${receiptData.value.amount} ريال ',
                  fontColor: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ]),
        Visibility(
            visible: receiptData.value.trxType == "1",
            child: Column(
              children: [
                Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomAppText(
                      title: 'مبلغ النقد',
                      fontColor: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                  Container(width: 60),
                  CustomAppText(
                      title: '${receiptData.value.otherAmount} ريال ',
                      fontColor: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ]),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomAppText(
                          title: 'المبلغ الإجمالي',
                          fontColor: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                      Container(width: 60),
                      CustomAppText(
                          title: '${double.tryParse(receiptData.value.amount ?? "0").toDouble() + (double.tryParse(receiptData.value.otherAmount ?? "0") ?? 0).toDouble()} ريال ',
                          fontColor: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ]),
              ],
            )
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomAppText(
                  title: '${receiptData.value.getTransType(transType: receiptData.value.trxType, lang: "en")} AMOUNT',
                  fontColor: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),

            ]),
        Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomAppText(
                  title: '${receiptData.value.amount} SAR',
                  fontColor: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),

            ]),
        Visibility(
            visible: receiptData.value.trxType == "1",
            child: Column(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomAppText(
                          title: 'NAQD Amount',
                          fontColor: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                      Container(width: 60),
                      CustomAppText(
                          title: '${receiptData.value.otherAmount} SAR',
                          fontColor: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ]),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomAppText(
                          title: 'Total Amount',
                          fontColor: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                      Container(width: 60),
                      CustomAppText(
                          title: '${double.tryParse(receiptData.value.amount ?? "0").toDouble() + (double.tryParse(receiptData.value.otherAmount ?? "0") ?? 0).toDouble()} SAR',
                          fontColor: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ]),
              ],
            )
        ),
        CustomAppText(
            title: receiptData.value.getTransResult(
                trxRes: receiptData.value.trxResult,
                trxType: receiptData.value.trxType,
                trxResponse: receiptData.value.trxResponseCode,
                trxOffline: receiptData.value.offlineTrx,
            lang: "ar"),
            fontColor: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w200),
        CustomAppText(
            title: receiptData.value.getTransResult(
                trxRes: receiptData.value.trxResult,
                trxType: receiptData.value.trxType,
                trxResponse: receiptData.value.trxResponseCode,
                trxOffline: receiptData.value.offlineTrx,
            lang: "en"),
            fontColor: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold),
        Visibility(
          visible: receiptData.value.trxResult == "0",
          child: Column(
            children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomAppText(
                        title: 'رمز الموافقة',
                        fontColor: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                    Container(width: 60),
                    CustomAppText(
                        title: '707112',
                        fontColor: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomAppText(
                        title: '707112',
                        fontColor: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                    Container(width: 60),
                    CustomAppText(
                        title: 'APPROVAL CODE',
                        fontColor: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ]),
            ],
          ),
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomAppText(
                  title: trxTime,
                  fontColor: Colors.black,
                  fontSize: 16),
              Container(width: 120),
              CustomAppText(
                  title: trxDate,
                  fontColor: Colors.black,
                  fontSize: 16),
            ]),
        Container(height: 20),
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomAppText(
                  title: 'شكرًا لإستخدامكم مدى',
                  fontColor: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w200),
              CustomAppText(
                  title: 'THANK YOU FOR USING MADA',
                  fontColor: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.normal),
              CustomAppText(
                  title: 'يرجى الإحتفاظ بالإيصال',
                  fontColor: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w200),
              CustomAppText(
                  title: 'PLEASE RETAIN YOU RECEIPT',
                  fontColor: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.normal),
              CustomAppText(
                  title: '** نسخه التاجر **',
                  fontColor: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w200),
              CustomAppText(
                  title: '** RETAILER COPY **',
                  fontColor: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.normal),
              CustomAppText(
                  title: receiptData.value.leapIccTagInfo,
                  fontColor: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.normal),
            ],
          ),
        )
      ],
    );
  }
}

