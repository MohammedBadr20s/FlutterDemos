



import 'package:pagination_flutter/src/modules/base/model/base_model.dart';

class ReceiptModel extends BaseValue {
  ReceiptModel({
    this.id,
    this.pan,
    this.amount,
    this.otherAmount,
    this.expireDate,
    this.schemaId,
    this.schemaNameEn,
    this.schemaNameAr,
    this.cardHolderName,
    this.authCode,
    this.rrn,
    this.merchantCode,
    this.merchantNameEn,
    this.merchantNameAr,
    this.merchantAddressEn,
    this.merchantAddressAr,
    this.merchantPhone,
    this.trxType,
    this.trxResponseCode,
    this.trxResult,
    this.trxResponseMessage,
    this.aId,
    this.stan,
    this.madaSpec,
    this.appVersion,
    this.fullTid,
    this.aquireId,
    this.adsMessage,
    this.cvmMessage,
    this.bankAbbreviation,
    this.leapIccTagInfo,
    this.offlineTrx,
    this.isTransferredForAgg,
    this.terminalId,
    this.trxDate,
    this.trxStartDate,
    this.trxEndDate,
    this.counter,
    this.createdBy,
    this.createdOn,
    this.merchantId,
    this.terminal,
    this.merchant,
    this.cleintRefNumber,
    this.mobileNumber,
  });

  final String id;
  final String pan;
  final String amount;
  final String otherAmount;
  final String expireDate;
  final dynamic schemaId;
  final String schemaNameEn;
  final String schemaNameAr;
  final String cardHolderName;
  final String authCode;
  final String rrn;
  final String merchantCode;
  final String merchantNameEn;
  final String merchantNameAr;
  final String merchantAddressEn;
  final String merchantAddressAr;
  final String merchantPhone;
  final String trxType;
  final dynamic trxResponseCode;
  final String trxResult;
  final String trxResponseMessage;
  final String aId;
  final String stan;
  final String madaSpec;
  final String appVersion;
  final String fullTid;
  final String aquireId;
  final String adsMessage;
  final String cvmMessage;
  final String bankAbbreviation;
  final String leapIccTagInfo;
  final String offlineTrx;
  final bool isTransferredForAgg;
  final String terminalId;
  final DateTime trxDate;
  final String trxStartDate;
  final String trxEndDate;
  final int counter;
  final String createdBy;
  final DateTime createdOn;
  final int merchantId;
  final dynamic terminal;
  final dynamic merchant;
  final dynamic cleintRefNumber;
  final dynamic mobileNumber;

  factory ReceiptModel.fromJson(Map<String, dynamic> json) => ReceiptModel(
    id: json["id"] == null ? null : json["id"],
    pan: json["pan"] == null ? null : json["pan"],
    amount: json["amount"] == null ? null : json["amount"],
    otherAmount: json["otherAmount"] == null ? null : json["otherAmount"],
    expireDate: json["expireDate"],
    schemaId: json["schemaId"],
    schemaNameEn: json["schemaNameEn"] == null ? null : json["schemaNameEn"],
    schemaNameAr: json["schemaNameAr"] == null ? null : json["schemaNameAr"],
    cardHolderName: json["cardHolderName"] == null ? null : json["cardHolderName"],
    authCode: json["authCode"] == null ? null : json["authCode"],
    rrn: json["rrn"] == null ? null : json["rrn"],
    merchantCode: json["merchantCode"] == null ? null : json["merchantCode"],
    merchantNameEn: json["merchantNameEn"] == null ? null : json["merchantNameEn"],
    merchantNameAr: json["merchantNameAr"] == null ? null : json["merchantNameAr"],
    merchantAddressEn: json["merchantAddressEn"] == null ? null : json["merchantAddressEn"],
    merchantAddressAr: json["merchantAddressAr"] == null ? null : json["merchantAddressAr"],
    merchantPhone: json["merchantPhone"] == null ? null : json["merchantPhone"],
    trxType: json["trxType"] == null ? null : json["trxType"],
    trxResponseCode: json["trxResponseCode"],
    trxResult: json["trxResult"] == null ? null : json["trxResult"],
    trxResponseMessage: json["trxResponseMessage"] == null ? null : json["trxResponseMessage"],
    aId: json["aId"] == null ? null : json["aId"],
    stan: json["stan"] == null ? null : json["stan"],
    madaSpec: json["madaSpec"] == null ? null : json["madaSpec"],
    appVersion: json["appVersion"] == null ? null : json["appVersion"],
    fullTid: json["fullTid"] == null ? null : json["fullTid"],
    aquireId: json["aquireId"] == null ? null : json["aquireId"],
    adsMessage: json["adsMessage"] == null ? null : json["adsMessage"],
    cvmMessage: json["cvmMessage"] == null ? null : json["cvmMessage"],
    bankAbbreviation: json["bankAbbreviation"] == null ? null : json["bankAbbreviation"],
    leapIccTagInfo: json["leapICCTagInfo"] == null ? null : json["leapICCTagInfo"],
    offlineTrx: json["offlineTrx"] == null ? null : json["offlineTrx"],
    isTransferredForAgg: json["isTransferredForAgg"] == null ? null : json["isTransferredForAgg"],
    terminalId: json["terminalId"] == null ? null : json["terminalId"],
    trxDate: json["trxDate"] == null ? null : DateTime.parse(json["trxDate"]),
    trxStartDate: json["trxStartDate"] == null ? null : json["trxStartDate"],
    trxEndDate: json["trxEndDate"] == null ? null : json["trxEndDate"],
    counter: json["counter"] == null ? null : json["counter"],
    createdBy: json["createdBy"] == null ? null : json["createdBy"],
    createdOn: json["createdOn"] == null ? null : DateTime.parse(json["createdOn"]),
    merchantId: json["merchantId"] == null ? null : json["merchantId"],
    terminal: json["terminal"],
    merchant: json["merchant"],
    cleintRefNumber: json["cleintRefNumber"],
    mobileNumber: json["mobileNumber"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "pan": pan == null ? null : pan,
    "amount": amount == null ? null : amount,
    "otherAmount": otherAmount == null ? null : otherAmount,
    "expireDate": expireDate,
    "schemaId": schemaId,
    "schemaNameEn": schemaNameEn == null ? null : schemaNameEn,
    "schemaNameAr": schemaNameAr == null ? null : schemaNameAr,
    "cardHolderName": cardHolderName == null ? null : cardHolderName,
    "authCode": authCode == null ? null : authCode,
    "rrn": rrn == null ? null : rrn,
    "merchantCode": merchantCode == null ? null : merchantCode,
    "merchantNameEn": merchantNameEn == null ? null : merchantNameEn,
    "merchantNameAr": merchantNameAr == null ? null : merchantNameAr,
    "merchantAddressEn": merchantAddressEn == null ? null : merchantAddressEn,
    "merchantAddressAr": merchantAddressAr == null ? null : merchantAddressAr,
    "merchantPhone": merchantPhone == null ? null : merchantPhone,
    "trxType": trxType == null ? null : trxType,
    "trxResponseCode": trxResponseCode,
    "trxResult": trxResult == null ? null : trxResult,
    "trxResponseMessage": trxResponseMessage == null ? null : trxResponseMessage,
    "aId": aId == null ? null : aId,
    "stan": stan == null ? null : stan,
    "madaSpec": madaSpec == null ? null : madaSpec,
    "appVersion": appVersion == null ? null : appVersion,
    "fullTid": fullTid == null ? null : fullTid,
    "aquireId": aquireId == null ? null : aquireId,
    "adsMessage": adsMessage == null ? null : adsMessage,
    "cvmMessage": cvmMessage == null ? null : cvmMessage,
    "bankAbbreviation": bankAbbreviation == null ? null : bankAbbreviation,
    "leapICCTagInfo": leapIccTagInfo == null ? null : leapIccTagInfo,
    "offlineTrx": offlineTrx == null ? null : offlineTrx,
    "isTransferredForAgg": isTransferredForAgg == null ? null : isTransferredForAgg,
    "terminalId": terminalId == null ? null : terminalId,
    "trxDate": trxDate == null ? null : trxDate.toIso8601String(),
    "trxStartDate": trxStartDate == null ? null : trxStartDate,
    "trxEndDate": trxEndDate == null ? null : trxEndDate,
    "counter": counter == null ? null : counter,
    "createdBy": createdBy == null ? null : createdBy,
    "createdOn": createdOn == null ? null : createdOn.toIso8601String(),
    "merchantId": merchantId == null ? null : merchantId,
    "terminal": terminal,
    "merchant": merchant,
    "cleintRefNumber": cleintRefNumber,
    "mobileNumber": mobileNumber,
  };


  String getTransResult({String trxRes, String trxType, String trxResponse, String trxOffline, String lang}) {
    if (trxRes == "0") {
      if (trxType == "3" && trxResponse == "400") {
        switch (lang) {
          case "en": return "ACCEPTED";
          case "ar": return "مستلمة";
        }
      } else if (trxOffline == "1") {
        switch (lang) {
          case "en": return "OFFLINE APPROVED";
          case "ar": return "مقبولة (ب)";
        }
      } else {
        switch (lang) {
          case "en": return "ACCEPTED";
          case "ar": return  "مقبولة";
        }
      }
    } else if (trxRes == "1") {
      if (trxOffline == "1") {
        switch (lang) {
          case "en": return "OFFLINE DECLINED";
          case "ar": return "مرفوضة (ب)";
        }
      } else {
        switch (lang) {
          case "en": return "DECLINED";
          case "ar": return "مرفوضة";
        }
      }
    } else if (trxRes == "2") {
      switch (lang) {
        case "en": return "TRANSACTION VOID\nRETAILER PLEASE CHECK COMMUNICATION";
        case "ar": return "العملية ملغاة\n" + "الرجاء من التاجر التحقق من الإتصال";
      }
    } else {
      switch (lang) {
        case "en": return "CANCELLED";
        case "ar": return "ملغي";
      }
    }
  }
  String getTransType({String transType, String lang}) {
    switch (transType) {
      case "0":
        switch (lang) {
          case "en": return "PURCHASE";
          case "ar": return "شراء";
        }
        break;
      case "1":
        switch (lang) {
          case "en": return "PURCHASE WITH NAQD";
          case "ar": return "شراء مع نقد";
        }
        break;
      case "2":
        switch (lang) {
          case "en": return "REFUND";
          case "ar": return "استرداد";
        }
        break;
      case "3":
        switch (lang) {
          case "en": return "REVERSAL";
          case "ar": return "عملية معكوسة";
        }
        break;
      case "4":
        switch (lang) {
          case "en": return "AUTHORIZATION";
          case "ar": return "تفويض";
        }
        break;
      case "5":
        switch (lang) {
          case "en": return "PURCHASE ADVICE";
          case "ar": return "إشعار بالشراء";
        }
        break;
      case "6":
        switch (lang) {
          case "en": return "CASH ADVANCE";
          case "ar": return "سلفة نقدية";
        }
        break;

    }
  }
}

