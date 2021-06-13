import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mostadam_flutter_app/src/modules/Authentication/model/BankDataModel.dart';
import 'package:mostadam_flutter_app/src/modules/Authentication/model/engineerDataModel.dart';
import 'package:mostadam_flutter_app/src/modules/Authentication/model/forget_password_model.dart';
import 'package:mostadam_flutter_app/src/modules/Authentication/model/register_model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:mostadam_flutter_app/src/modules/Authentication/model/login_model.dart';
import 'package:mostadam_flutter_app/src/resources/URLS.dart';

part 'client.g.dart';

@RestApi(baseUrl: URLS.baseURL)
abstract class Client {
  factory Client(Dio client, {String baseUrl}) = _Client;

  @POST(URLS.login)
  @FormUrlEncoded()
  Future<LoginModel> postLogin(
      {@Field() String grant_type,
      @Field() String username,
      @Field() String password});

  @POST(URLS.forgetPassword)
  @FormUrlEncoded()
  Future<ForgetPasswordModel> postForgetPassword({@Field() String email});

  @POST(URLS.getEngineerData)
  @FormUrlEncoded()
  Future<EngineerData> postEngineerData(
      {@Query('membershipNumber') String membershipNumber,
      @Query('identityNumber') String identityNumber});

  @POST(URLS.registerProfile)
  Future<RegisterModel> postRegister({
    @Field() Map<String, dynamic> inspectorProfile,
    @Field('AspNetUser') Map<String, dynamic> aspNetUser,
    @Field('membershipNumber') String membershipNum,
    @Part() File  ReadyBuildingQualityCertificateFile,
    @Part() File  QualityInspectionCertificateFile,
  });

  @GET(URLS.getBankData)
  Future<BankDataModel> getBankData();
}
