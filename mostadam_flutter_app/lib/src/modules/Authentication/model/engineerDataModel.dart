


import 'package:mostadam_flutter_app/src/modules/base/base_model.dart';

import 'forget_password_model.dart';

class EngineerData extends BaseModel<EngineerData> {
  EngineerData({
    this.message,
    this.success,
    this.value,
    this.statusCode,
    this.errorCode,
    this.errors,
  });

  String message;
  bool success;
  Value value;
  int statusCode;
  String errorCode;
  dynamic errors;

  factory EngineerData.fromJson(Map<String, dynamic> json) => EngineerData(
    message: json["message"] == null ? null : json["message"],
    success: json["success"] == null ? null : json["success"],
    value: json["value"] == null ? null : Value.fromJson(json["value"]),
    statusCode: json["statusCode"] == null ? null : json["statusCode"],
    errorCode: json["errorCode"] == null ? null : json["errorCode"],
    errors: json["errors"],
  );

  Map<String, dynamic> toJson() => {
    "message": message == null ? null : message,
    "success": success == null ? null : success,
    "value": value == null ? null : value.toJson(),
    "statusCode": statusCode == null ? null : statusCode,
    "errorCode": errorCode == null ? null : errorCode,
    "errors": errors,
  };
}

class Value {
  Value({
    this.idNumber,
    this.fullName,
    this.membershipNo,
    this.membershipEndDate,
    this.membershipStatus,
    this.membershipStatusCode,
    this.nationality,
    this.nationalityCode,
    this.specialization,
    this.error,
    this.isMember,
    this.message,
  });

  String idNumber;
  String fullName;
  String membershipNo;
  String membershipEndDate;
  String membershipStatus;
  String membershipStatusCode;
  String nationality;
  String nationalityCode;
  String specialization;
  bool error;
  bool isMember;
  dynamic message;

  factory Value.fromJson(Map<String, dynamic> json) => Value(
    idNumber: json["idNumber"] == null ? null : json["idNumber"],
    fullName: json["fullName"] == null ? null : json["fullName"],
    membershipNo: json["membershipNo"] == null ? null : json["membershipNo"],
    membershipEndDate: json["membershipEndDate"] == null ? null : json["membershipEndDate"],
    membershipStatus: json["membershipStatus"] == null ? null : json["membershipStatus"],
    membershipStatusCode: json["membershipStatusCode"] == null ? null : json["membershipStatusCode"],
    nationality: json["nationality"] == null ? null : json["nationality"],
    nationalityCode: json["nationalityCode"] == null ? null : json["nationalityCode"],
    specialization: json["specialization"] == null ? null : json["specialization"],
    error: json["error"] == null ? null : json["error"],
    isMember: json["isMember"] == null ? null : json["isMember"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "idNumber": idNumber == null ? null : idNumber,
    "fullName": fullName == null ? null : fullName,
    "membershipNo": membershipNo == null ? null : membershipNo,
    "membershipEndDate": membershipEndDate == null ? null : membershipEndDate,
    "membershipStatus": membershipStatus == null ? null : membershipStatus,
    "membershipStatusCode": membershipStatusCode == null ? null : membershipStatusCode,
    "nationality": nationality == null ? null : nationality,
    "nationalityCode": nationalityCode == null ? null : nationalityCode,
    "specialization": specialization == null ? null : specialization,
    "error": error == null ? null : error,
    "isMember": isMember == null ? null : isMember,
    "message": message,
  };
}
