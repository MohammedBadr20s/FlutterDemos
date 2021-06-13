


import 'package:mostadam_flutter_app/src/modules/base/base_model.dart';

class RegisterModel extends BaseModel<RegisterModel> {
  RegisterModel({
    this.message,
    this.success,
    this.statusCode,
  });

  String message;
  bool success;
  int statusCode;

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
    message: json["message"] == null ? null : json["message"],
    success: json["success"] == null ? null : json["success"],
    statusCode: json["statusCode"] == null ? null : json["statusCode"],
  );

  Map<String, dynamic> toJson() => {
    "message": message == null ? null : message,
    "success": success == null ? null : success,
    "statusCode": statusCode == null ? null : statusCode,
  };
}