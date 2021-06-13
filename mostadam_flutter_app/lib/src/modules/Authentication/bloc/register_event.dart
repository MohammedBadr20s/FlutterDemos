part of 'register_bloc.dart';


class RegisterEvent extends Equatable {
  const RegisterEvent();
  
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class EngineerDataRequest extends RegisterEvent {
  const EngineerDataRequest();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class RegisterationDataChanged extends RegisterEvent {
  const RegisterationDataChanged();

  @override
  // TODO: implement props
  List<Object> get props => [];
}
class EngineeringDataChanged extends RegisterEvent {
  const EngineeringDataChanged({this.engineerData});
  final EngineerData engineerData;
  @override
  // TODO: implement props
  List<Object> get props => [engineerData];

}
class MembershipNumChanged extends RegisterEvent {
  
  const MembershipNumChanged({this.membershipNum});
  
  final String membershipNum;
  
  @override
  // TODO: implement props
  List<Object> get props => [membershipNum];
}

class IdentityNumChanged extends RegisterEvent {
  const IdentityNumChanged({this.identityNum});
  
  final String identityNum;
  
  @override
  // TODO: implement props
  List<Object> get props => [identityNum];
}

class BuildingQualityNumChanged extends RegisterEvent {
  final String buildingQualityNum;
  const BuildingQualityNumChanged({this.buildingQualityNum});
  
  @override
  // TODO: implement props
  List<Object> get props => [buildingQualityNum];
}

class ReadyBuildingQualityNumChanged extends RegisterEvent {
  final String readyBuildingQualityNum;
  const ReadyBuildingQualityNumChanged({this.readyBuildingQualityNum});

  @override
  // TODO: implement props
  List<Object> get props => [readyBuildingQualityNum];
}

class BuildingQualityCertFileChanged extends RegisterEvent {
  final PickedFile buildingQualityCertFile;
  const BuildingQualityCertFileChanged({this.buildingQualityCertFile});
  
  @override
  // TODO: implement props
  List<Object> get props => [buildingQualityCertFile];
}

class ReadyBuildingQualityCertFileChanged extends RegisterEvent {
  final PickedFile readyBuildingQualityCertFile;
  const ReadyBuildingQualityCertFileChanged({this.readyBuildingQualityCertFile});

  @override
  // TODO: implement props
  List<Object> get props => [readyBuildingQualityCertFile];
}
class UserNameChanged extends RegisterEvent {
  const UserNameChanged({this.userName});
  
  final String userName;
  
  @override
  // TODO: implement props
  List<Object> get props => [userName];
}

class EmailChanged extends RegisterEvent {
  const EmailChanged({this.email});
  
  final String email;
  
  @override
  // TODO: implement props
  List<Object> get props => [email];
}

class ConfirmEmailChanged extends RegisterEvent {
  const ConfirmEmailChanged({this.confirmEmail});

  final String confirmEmail;

  @override
  // TODO: implement props
  List<Object> get props => [confirmEmail];
}

class PhoneChanged extends RegisterEvent {
  const PhoneChanged({this.phone});

  final String phone;

  @override
  // TODO: implement props
  List<Object> get props => [phone];
}

class PasswordChanged extends RegisterEvent {
  const PasswordChanged({this.password});

  final String password;

  @override
  // TODO: implement props
  List<Object> get props => [password];
}

class ConfirmPasswordChanged extends RegisterEvent {
  const ConfirmPasswordChanged({this.confirmPassword});

  final String confirmPassword;

  @override
  // TODO: implement props
  List<Object> get props => [confirmPassword];
}
class RequestBankData extends RegisterEvent {
  const RequestBankData();
  
  @override
  // TODO: implement props
  List<Object> get props => [];
}
class BankDataChanged extends RegisterEvent {
  const BankDataChanged({this.bankData});

  final BankData bankData;

  @override
  // TODO: implement props
  List<Object> get props => [bankData];
}

class IbanNumberChanged extends RegisterEvent {
  const IbanNumberChanged({this.ibanNumber});

  final String ibanNumber;

  @override
  // TODO: implement props
  List<Object> get props => [ibanNumber];
}

class AcceptTermsChanged extends RegisterEvent {
  const AcceptTermsChanged({this.isSwitched});

  final bool isSwitched;

  @override
  // TODO: implement props
  List<Object> get props => [isSwitched];
}