import 'dart:io';
import 'package:dio/dio.dart';
import 'package:formz/formz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mostadam_flutter_app/src/components/ValidationMixin.dart';
import 'package:mostadam_flutter_app/src/modules/Authentication/model/BankDataModel.dart';
import 'package:mostadam_flutter_app/src/modules/Authentication/model/RegisterDataModel.dart';
import 'package:mostadam_flutter_app/src/modules/Authentication/model/RegisterValidations.dart';
import 'package:mostadam_flutter_app/src/modules/Authentication/model/engineerDataModel.dart';
import 'package:mostadam_flutter_app/src/modules/Authentication/model/loginValidations.dart';
import 'package:mostadam_flutter_app/src/modules/Authentication/model/register_model.dart';
import 'package:mostadam_flutter_app/src/modules/Authentication/repo/AuthenticationRepo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'register_state.dart';

part 'register_event.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState>
    with ValidationMixin {
  final Repository repository;
  RegisterDataModel registerData;
  //
  // PublishSubject<BaseModel<EngineerData>> engineerDataRes;
  // PublishSubject<BaseModel<RegisterModel>> registerDataRes;
  // PublishSubject<BaseModel<BankDataModel>> bankDataRes;
  // BehaviorSubject<String> membershipNumber;
  // BehaviorSubject<String> identityNumber;
  // BehaviorSubject<String> civil_registeryNum;
  // BehaviorSubject<String> buildingQualityNum;
  // BehaviorSubject<String> readyBuildingQualityNum;
  // BehaviorSubject<PickedFile> buildingQualityCerFileData;
  // BehaviorSubject<PickedFile> readyBuildingQualityCerFileData;
  // BehaviorSubject<String> membershipExpirationDate;
  // BehaviorSubject<String> membershipStatus;
  // BehaviorSubject<String> membershipStatusCode;
  // BehaviorSubject<String> specialization;
  // BehaviorSubject<String> fullName;
  // BehaviorSubject<String> userName;
  // BehaviorSubject<String> email;
  // BehaviorSubject<String> confirmEmail;
  // BehaviorSubject<String> phone;
  // BehaviorSubject<String> password;
  // BehaviorSubject<String> confirmPassword;
  // BehaviorSubject<BankData> bankData;
  // BehaviorSubject<String> ibanNumber;
  // BehaviorSubject<bool> isSwitched;

  RegisterBloc({this.repository}) : super(const UnknownState());

  // //Streams
  // Stream<String> get validateIdentityNumber =>
  //     identityNumber.stream.transform(validatorIdentityNum);
  //
  // Stream<String> get validateMembership =>
  //     membershipNumber.stream.transform(validatorMembership);
  //
  // Stream<bool> get validateIdentity_Membership => Rx.combineLatest2(
  //     validateIdentityNumber, validateMembership, (a, b) => true);
  //
  // Stream<String> get validateUsername =>
  //     userName.stream.transform(validatorUserName);
  //
  // Stream<String> get validateEmail => email.stream.transform(validatorEmail);
  //
  // Stream<String> get validateConfirmEmail =>
  //     confirmEmail.stream.transform(validatorEmail);
  //
  // Stream<String> get validatePassword =>
  //     password.stream.transform(validatorPassword);
  //
  // Stream<String> get validateConfirmPassword =>
  //     confirmPassword.stream.transform(validatorPassword);
  //
  // Stream<String> get validatePhone => phone.stream.transform(validatorPhone);
  //
  // Stream<String> get validateReadyBuildingQualityNum =>
  //     readyBuildingQualityNum.stream.transform(validatorCertificate);
  //
  // Stream<BankData> get validateBankData =>
  //     bankData.stream.transform(validatorBankData);
  //
  // Stream<String> get validateIBANum =>
  //     ibanNumber.stream.transform(validatorIBAN);
  //
  // Stream<bool> get validateAcceptTerms =>
  //     isSwitched.stream.transform(validatorSwitch);
  //
  // Stream<bool> get validateAccountContainerFields => Rx.combineLatest9(
  //     validateUsername,
  //     validateEmail,
  //     validateConfirmEmail,
  //     validatePhone,
  //     validatePassword,
  //     validateConfirmPassword,
  //     validateBankData,
  //     validateIBANum,
  //     validateAcceptTerms,
  //     (a, b, c, d, e, f, g, h, i) => true);

  // Stream<String> get validatebuildingQualityNum =>
  //     buildingQualityNum.stream.transform(validatorCertificate);
  //
  // Stream<PickedFile> get validateReadyBuildingQualityFile =>
  //     readyBuildingQualityCerFileData.stream.transform(validatorFile);
  //
  // Stream<PickedFile> get validateBuildingQualityCerFileData =>
  //     buildingQualityCerFileData.stream.transform(validatorFile);
  //
  // Stream<bool> get continueToPrimaryValidation => Rx.combineLatest4(
  //     validatebuildingQualityNum,
  //     validateReadyBuildingQualityNum,
  //     validateBuildingQualityCerFileData,
  //     validateReadyBuildingQualityFile,
  //     (a, b, c, d) => true);

  init() {
    registerData = RegisterDataModel();
    registerData.membershipNumber = '64826';
    registerData.identityNumber = '2306821436';
    // engineerDataRes = PublishSubject<BaseModel<EngineerData>>();
    // membershipNumber = BehaviorSubject<String>();
    // membershipNumber.sink.add('64826');
    // identityNumber = BehaviorSubject<String>();
    // identityNumber.sink.add('2306821436');
    // civil_registeryNum = BehaviorSubject<String>();
    // buildingQualityNum = BehaviorSubject<String>();
    // readyBuildingQualityNum = BehaviorSubject<String>();
    // buildingQualityCerFileData = BehaviorSubject<PickedFile>();
    // readyBuildingQualityCerFileData = BehaviorSubject<PickedFile>();
    // membershipExpirationDate = BehaviorSubject<String>();
    // membershipStatus = BehaviorSubject<String>();
    // membershipStatusCode = BehaviorSubject<String>();
    // specialization = BehaviorSubject<String>();
    // fullName = BehaviorSubject<String>();
    // userName = BehaviorSubject<String>();
    // email = BehaviorSubject<String>();
    // confirmEmail = BehaviorSubject<String>();
    // phone = BehaviorSubject<String>();
    // password = BehaviorSubject<String>();
    // confirmPassword = BehaviorSubject<String>();
    // bankData = BehaviorSubject<BankData>();
    // ibanNumber = BehaviorSubject<String>();
    // isSwitched = BehaviorSubject<bool>();
    // isSwitched.sink.add(false);
    // registerDataRes = PublishSubject<BaseModel<RegisterModel>>();
    // bankDataRes = PublishSubject<BaseModel<BankDataModel>>();
    // buildingQualityNum.listen((value) {
    //   print("Building Quality Num value: $value");
    // });
    // readyBuildingQualityNum.listen((value) {
    //   print("Ready Building Quality Num value: $value");
    // });
    // buildingQualityCerFileData.listen((value) {
    //   final File file = File(value.path);
    //   print("buildingQualityCerFileData is :${file}");
    // });
    // readyBuildingQualityCerFileData.listen((value) {
    //   print("constractionQualityCerFileData is ::${value.path}");
    // });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    registerData = null;
    // engineerDataRes.close();
    // membershipNumber.close();
    // identityNumber.close();
    // readyBuildingQualityNum.close();
    // buildingQualityNum.close();
    // buildingQualityCerFileData.close();
    // readyBuildingQualityCerFileData.close();
    // userName.close();
    // email.close();
    // confirmEmail.close();
    // phone.close();
    // password.close();
    // confirmPassword.close();
    // bankData.close();
    // ibanNumber.close();
    // isSwitched.close();
    // specialization.close();
    // registerDataRes.close();
    // membershipExpirationDate.close();
    // fullName.close();
    // bankDataRes.close();
    // civil_registeryNum.close();
  }

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    if (event is EngineerDataRequest) {
      yield* postEngineerData(event: event);
    } else if (event is MembershipNumChanged) {
      yield* setupState(state: _mapMembershipNumToState(event: event));
    } else if (event is IdentityNumChanged) {
      yield* setupState(state: _mapIdentityNumToState(event: event));
    } else if (event is RegisterationDataChanged) {
      yield* postRegister(event: event);
    } else if (event is UserNameChanged) {
      yield* setupState(state: _mapUserNameToState(event: event));
    } else if (event is EmailChanged) {
      yield* setupState(state: _mapEmailChangedToState(event: event));
    } else if (event is ConfirmEmailChanged) {
      yield* setupState(state: _mapConfirmEmailChangedToState(event: event));
    } else if (event is PhoneChanged) {
      yield* setupState(state: _mapPhoneChangedToState(event: event));
    } else if (event is PasswordChanged) {
      yield* setupState(state: _mapPasswordChangedToState(event: event));
    } else if (event is ConfirmPasswordChanged) {
      yield* setupState(state: _mapConfirmPasswordChangedToState(event: event));
    } else if (event is BankDataChanged) {
      yield* _mapBankDataChangedToState(event: event);
    } else if (event is IbanNumberChanged) {
      yield* setupState(state: _mapIbanNumChangedToState(event: event));
    } else if (event is AcceptTermsChanged) {
      yield* setupState(state: _mapAcceptTermsToState(event: event));
    } else if (event is RequestBankData) {
      yield* getBankData();
    } else if (event is BuildingQualityNumChanged) {
      yield* setupState(state: _mapBuildingQualityNumToState(event: event));
    } else if (event is ReadyBuildingQualityNumChanged) {
      yield* setupState(state: _mapReadyBuildingQualityNumToState(event: event));
    } else if (event is BuildingQualityCertFileChanged) {
      yield* setupState(state: _mapBuildingQualityFileToState(event: event));
    } else if (event is ReadyBuildingQualityCertFileChanged) {
      yield* setupState(state: _mapReadyBuildingQualityFileToState(event: event));
    }
  }

  Stream<RegisterState> postEngineerData(
      {EngineerDataRequest event}) async* {
    print(
        "membershipNumber ${registerData.membershipNumber}, identityNumber: ${registerData.identityNumber}");
    try {
      yield LoadingState();
      EngineerData data = await repository.postEngineerData(
          membershipNumber: registerData.membershipNumber,
          identityNumber: registerData.identityNumber);
      registerData.fullName = data.value.fullName;
      registerData.civilRegisterNum = data.value.idNumber;
      registerData.specialization = data.value.specialization;
      registerData.membershipStatusCode = data.value.membershipStatusCode;
      registerData.membershipStatus = data.value.membershipStatus;
      String formattedMembershipExpirationDate;
      final DateTime now = DateFormat('dd/MM/yyyy HH:mm:ss')
          .parse(data.value.membershipEndDate);
      final DateFormat formatter = DateFormat("dd/MM/yyyy");
      formattedMembershipExpirationDate = formatter.format(now);
      registerData.membershipExpirationDate =  formattedMembershipExpirationDate;
      yield EngineeringDataState(engineerData: data);
    } catch (error) {
      final res = error as DioError;
      yield RegisterError(error: res);
    }
  }

  RegisterState _mapMembershipNumToState(
      {MembershipNumChanged event}) {
    final membershipNum = event.membershipNum;
    registerData.membershipNumber = membershipNum;
    return state;
  }

  RegisterState _mapIdentityNumToState(
      {IdentityNumChanged event}) {
    final identityNum = event.identityNum;
    registerData.identityNumber = identityNum;
    return state;
  }

  RegisterState _mapBuildingQualityNumToState(
      {BuildingQualityNumChanged event}) {
    final buildingQualityNum = event.buildingQualityNum;
    registerData.buildingQualityNum = buildingQualityNum;
    return state;
  }

  RegisterState _mapBuildingQualityFileToState(
      {BuildingQualityCertFileChanged event}) {
    final buildingQualityFile = File(event.buildingQualityCertFile.path);
    print("buildingQualityCerFileData is :${buildingQualityFile}");
    registerData.buildingQualityCerFileData = buildingQualityFile;
    return state;
  }

  RegisterState _mapReadyBuildingQualityNumToState(
      {ReadyBuildingQualityNumChanged event}) {
    final readyBuildingQualityNum = event.readyBuildingQualityNum;
    registerData.readyBuildingQualityNum = readyBuildingQualityNum;
    return state;
  }

  RegisterState _mapReadyBuildingQualityFileToState(
      {ReadyBuildingQualityCertFileChanged event}) {
    final readyBuildingQualityFile =
        File(event.readyBuildingQualityCertFile.path);
    print("constractionQualityCerFileData is ::${readyBuildingQualityFile}");
    registerData.readyBuildingQualityCerFileData = readyBuildingQualityFile;
    return state;
  }

  RegisterState _mapUserNameToState(
      {UserNameChanged event}) {
    final userName = Username.dirty(event.userName);
    registerData.username = userName;
    return state;  }

  RegisterState _mapEmailChangedToState(
      {EmailChanged event}) {
    final email = Email.dirty(event.email);
    registerData.email = email;
    return state;
  }

  RegisterState _mapConfirmEmailChangedToState(
      {ConfirmEmailChanged event}) {
    final confirmEmail = Email.dirty(event.confirmEmail);
    registerData.confirmEmail = confirmEmail;
    return state;
  }

  RegisterState _mapPhoneChangedToState(
      {PhoneChanged event}) {
    final phone = PhoneNumber.dirty(event.phone);
    registerData.phoneNumber = phone;
    return state;  }

  RegisterState _mapPasswordChangedToState(
      {PasswordChanged event}) {
    final password = Password.dirty(event.password);
    registerData.password = password;
    return state;
  }

  RegisterState _mapConfirmPasswordChangedToState(
      {ConfirmPasswordChanged event}) {
    final confirmPassword = Password.dirty(event.confirmPassword);
    registerData.confirmPassword = confirmPassword;
    return state;
  }

  Stream<RegisterState> _mapBankDataChangedToState(
      {BankDataChanged event}) async* {
    final bankData = event.bankData;
    registerData.bankData = bankData;
    yield BankDataChangeState(bankData: bankData);
  }

  RegisterState _mapIbanNumChangedToState(
      {IbanNumberChanged event}) {
    final ibanNum = IbanNumber.dirty(event.ibanNumber);
    registerData.ibanNumber = ibanNum;
    return state;
  }

  RegisterState _mapAcceptTermsToState(
      {AcceptTermsChanged event}) {
    final isSwitched = event.isSwitched;
    registerData.isSwitched = isSwitched;
    return state;
  }

  Stream<RegisterState> postRegister(
      {RegisterationDataChanged event, RegisterState state}) async* {
    try {
      var inspectorProfile = {
        'IdentityNumber': registerData.identityNumber,
        'MembershipNumber': registerData.membershipNumber,
        'MembershipExpiryDate': registerData.membershipExpirationDate,
        'Specialization': registerData.specialization,
        "membershipStatus": registerData.membershipStatus,
        "membershipStatusCode": registerData.membershipStatusCode,
        "BankId": registerData.bankData.id,
        "IBAN": registerData.ibanNumber.value,
        "IsAgreed": registerData.isSwitched,
        "QualityInspectionCertificateNumber": registerData.buildingQualityNum,
        "ReadyBuildingQualityCertificateNumber": registerData.readyBuildingQualityNum,
        "InspectorTypeId": "1"
      };
      var aspNetUser = {
        "FullName": registerData.fullName,
        "IDNumber": registerData.identityNumber,
        "FirstName": registerData.fullName.split(' ').first,
        "UserName": registerData.username.value,
        "Email": registerData.email.value,
        "EmailConfirm": registerData.confirmEmail.value,
        "Password": registerData.password.value,
        "ConfirmPassword": registerData.confirmPassword.value,
        "PhoneNumber": registerData.phoneNumber.value,
      };
      final readyBuildingCertFile = registerData.readyBuildingQualityCerFileData;

      // {
      //   'name': readyBuildingCertFile.path.split('_').last,
      // 'data': readyBuildingCertFile,
      // 'mimeType': lookupMimeType(readyBuildingCertFile.path)
      // }
      final buildingQualityCertFile = registerData.buildingQualityCerFileData;
      // {
      //   'name': buildingQualityCertFile.path.split('_').last,
      // 'data': buildingQualityCertFile,
      // 'mimeType': lookupMimeType(buildingQualityCertFile.path)
      // }
      yield LoadingState();
      RegisterModel res = await repository.postRegister(
          inspectorProfile: inspectorProfile,
          aspNetUser: aspNetUser,
          readyBuildingQualityCertificateFile: readyBuildingCertFile,
          qualityInspectionCertificateFile: buildingQualityCertFile,
          membershipNum: registerData.membershipNumber);
      yield RegisterAuthenticatedState(registerModel: res);
    } catch (error) {
      final res = (error as DioError);
      yield RegisterError(error: res);
    }
  }

  Stream<RegisterState> getBankData() async* {
    try {
      yield LoadingState();
      BankDataModel value = await repository.getBanks();
      var data = value;
      var list = [
        BankData(
            id: 0,
            nameAr: 'أسم البنك',
            name: 'أسم البنك',
            nameEn: 'Bank name',
            code: "0")
      ];
      list.addAll(value.value);
      data.value = list;
      registerData.bankDataList = data;
      yield BankDataDownloadedState(bankDataModel: data);
    } catch (error) {
      final resErr = (error as DioError);
      RegisterError(error: resErr);
    }
  }


  Stream<RegisterState> setupState({ RegisterState state}) async* {
    yield StartState();
    yield state;
  }
}

enum FileDataType { READY_BUILDING_CERTIFICATE, QUALITY_CERTIFICATE }
