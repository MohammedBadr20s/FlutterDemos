import 'dart:io';

import 'package:mostadam_flutter_app/src/modules/Authentication/model/BankDataModel.dart';
import 'package:mostadam_flutter_app/src/modules/Authentication/model/engineerDataModel.dart';
import 'package:mostadam_flutter_app/src/modules/Authentication/model/forget_password_model.dart';
import 'package:mostadam_flutter_app/src/modules/Authentication/model/login_model.dart';
import 'package:mostadam_flutter_app/src/modules/Authentication/model/register_model.dart';
import 'package:mostadam_flutter_app/src/resources/client.dart';

class Repository {
  final Client client;

  Repository({this.client});

  Future<LoginModel> postLogin(
      {String passwordType, String userName, String password}) =>
      client.postLogin(
          grant_type: passwordType, username: userName, password: password);

  Future<ForgetPasswordModel> postForgetPassword({String email}) =>
      client.postForgetPassword(email: email);

  Future<EngineerData> postEngineerData(
      {String membershipNumber, String identityNumber}) =>
      client.postEngineerData(
          membershipNumber: membershipNumber, identityNumber: identityNumber);

  Future<RegisterModel> postRegister(
      {Map<String, dynamic> inspectorProfile, Map<String,
          dynamic> aspNetUser, String membershipNum, File readyBuildingQualityCertificateFile, File qualityInspectionCertificateFile}) =>
      client.postRegister(inspectorProfile: inspectorProfile,
          aspNetUser: aspNetUser,
          membershipNum: membershipNum,
        ReadyBuildingQualityCertificateFile: readyBuildingQualityCertificateFile,
        QualityInspectionCertificateFile: qualityInspectionCertificateFile
      );
  Future<BankDataModel> getBanks() => client.getBankData();
}
