

import 'package:mostadam_flutter_app/src/modules/base/base_model.dart';

class ForgetPasswordModel extends BaseModel<ForgetPasswordModel> {
  ForgetPasswordModel({
    this.message,
    this.success,
    this.value,
    this.statusCode,
    this.errorCode,
    this.errors,
  });

  String message;
  bool success;
  dynamic value;
  int statusCode;
  String errorCode;
  dynamic errors;

  factory ForgetPasswordModel.fromJson(Map<String, dynamic> json) => ForgetPasswordModel(
    message: json["message"] == null ? null : json["message"],
    success: json["success"] == null ? null : json["success"],
    value: json["value"],
    statusCode: json["statusCode"] == null ? null : json["statusCode"],
    errorCode: json["errorCode"] == null ? null : json["errorCode"],
    errors: json["errors"],
  );

  Map<String, dynamic> toJson() => {
    "message": message == null ? null : message,
    "success": success == null ? null : success,
    "value": value,
    "statusCode": statusCode == null ? null : statusCode,
    "errorCode": errorCode == null ? null : errorCode,
    "errors": errors,
  };
}
