

// To parse this JSON data, do
//
//     final bankData = bankDataFromJson(jsonString);

import 'dart:convert';


class BankDataModel {
  BankDataModel({
    this.message,
    this.success,
    this.value,
    this.statusCode,
    this.errorCode,
    this.errors,
  });

  String message;
  bool success;
  List<BankData> value;
  int statusCode;
  String errorCode;
  dynamic errors;

  factory BankDataModel.fromJson(Map<String, dynamic> json) => BankDataModel(
    message: json["message"] == null ? null : json["message"],
    success: json["success"] == null ? null : json["success"],
    value: json["value"] == null ? null : List<BankData>.from(json["value"].map((x) => BankData.fromJson(x))),
    statusCode: json["statusCode"] == null ? null : json["statusCode"],
    errorCode: json["errorCode"] == null ? null : json["errorCode"],
    errors: json["errors"],
  );

  Map<String, dynamic> toJson() => {
    "message": message == null ? null : message,
    "success": success == null ? null : success,
    "value": value == null ? null : List<dynamic>.from(value.map((x) => x.toJson())),
    "statusCode": statusCode == null ? null : statusCode,
    "errorCode": errorCode == null ? null : errorCode,
    "errors": errors,
  };
}

class BankData {
  BankData({
    this.id,
    this.nameAr,
    this.name,
    this.nameEn,
    this.code,
  });

  int id;
  String nameAr;
  String name;
  String nameEn;
  String code;

  factory BankData.fromJson(Map<String, dynamic> json) => BankData(
    id: json["id"] == null ? null : json["id"],
    nameAr: json["nameAr"] == null ? null : json["nameAr"],
    name: json["name"] == null ? null : json["name"],
    nameEn: json["nameEn"] == null ? null : json["nameEn"],
    code: json["code"] == null ? null : json["code"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "nameAr": nameAr == null ? null : nameAr,
    "name": name == null ? null : name,
    "nameEn": nameEn == null ? null : nameEn,
    "code": code == null ? null : code,
  };
}
