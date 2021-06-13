
import 'dart:io';

import 'package:mostadam_flutter_app/src/modules/Authentication/bloc/register_bloc.dart';
import 'package:mostadam_flutter_app/src/modules/Authentication/model/RegisterValidations.dart';
import 'package:mostadam_flutter_app/src/modules/Authentication/model/loginValidations.dart';

import 'BankDataModel.dart';

class RegisterDataModel {
  RegisterStatus registerStatus;
  String membershipNumber;
  String identityNumber;
  String civilRegisterNum;
  String buildingQualityNum;
  String readyBuildingQualityNum;
  File buildingQualityCerFileData;
  File readyBuildingQualityCerFileData;
  String membershipExpirationDate;
  String membershipStatus;
  String membershipStatusCode;
  String specialization;
  String fullName;
  Username username;
  Email email;
  Email confirmEmail;
  PhoneNumber phoneNumber;
  Password password;
  Password confirmPassword;
  BankData bankData;
  BankDataModel bankDataList;
  IbanNumber ibanNumber;
  bool isSwitched;
}