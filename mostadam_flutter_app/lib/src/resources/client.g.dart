// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _Client implements Client {
  _Client(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'https://istedama-stag.housingapps.sa/MobileApp/';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<LoginModel> postLogin({grant_type, username, password}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _data = {
      'grant_type': grant_type,
      'username': username,
      'password': password
    };
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>('Token',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            contentType: 'application/x-www-form-urlencoded',
            baseUrl: baseUrl),
        data: _data);
    final value = LoginModel.fromJson(_result.data);
    return value;
  }

  @override
  Future<ForgetPasswordModel> postForgetPassword({email}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _data = {'email': email};
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>(
        'Api/Account/ForgotPassword',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            contentType: 'application/x-www-form-urlencoded',
            baseUrl: baseUrl),
        data: _data);
    final value = ForgetPasswordModel.fromJson(_result.data);
    return value;
  }

  @override
  Future<EngineerData> postEngineerData(
      {membershipNumber, identityNumber}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'membershipNumber': membershipNumber,
      r'identityNumber': identityNumber
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        'Api/Account/FindEngineerAuthorityMemeberByNumber',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            contentType: 'application/x-www-form-urlencoded',
            baseUrl: baseUrl),
        data: _data);
    final value = EngineerData.fromJson(_result.data);
    return value;
  }

  @override
  Future<RegisterModel> postRegister(
      {inspectorProfile,
      aspNetUser,
      membershipNum,
      ReadyBuildingQualityCertificateFile,
      QualityInspectionCertificateFile}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _data = {
      'inspectorProfile': inspectorProfile,
      'AspNetUser': aspNetUser,
      'membershipNumber': membershipNum
    };
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>(
        'Api/Account/RegisterInspectorProfile',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = RegisterModel.fromJson(_result.data);
    return value;
  }

  @override
  Future<BankDataModel> getBankData() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        'Api/LookUps/GetBanks',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = BankDataModel.fromJson(_result.data);
    return value;
  }
}
