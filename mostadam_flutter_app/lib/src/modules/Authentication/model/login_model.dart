


import 'package:mostadam_flutter_app/src/modules/base/base_model.dart';

class LoginModel extends BaseModel<LoginModel> {

  LoginModel({
    this.accessToken,
    this.tokenType,
    this.expiresIn,
    this.userName,
    this.fullName,
    this.isVerifiedAccount,
    this.userRoles,
    this.issued,
    this.expires,
  });

  String accessToken;
  String tokenType;
  int expiresIn;
  String userName;
  String fullName;
  String isVerifiedAccount;
  String userRoles;
  String issued;
  String expires;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    accessToken: json["access_token"],
    tokenType: json["token_type"],
    expiresIn: json["expires_in"],
    userName: json["userName"],
    fullName: json["fullName"],
    isVerifiedAccount: json["isVerifiedAccount"],
    userRoles: json["userRoles"],
    issued: json[".issued"],
    expires: json[".expires"],
  );

  Map<String, dynamic> toJson() => {
    "access_token": accessToken,
    "token_type": tokenType,
    "expires_in": expiresIn,
    "userName": userName,
    "fullName": fullName,
    "isVerifiedAccount": isVerifiedAccount,
    "userRoles": userRoles,
    ".issued": issued,
    ".expires": expires,
  };
}