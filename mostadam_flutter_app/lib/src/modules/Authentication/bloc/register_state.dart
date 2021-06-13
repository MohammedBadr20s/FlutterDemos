part of 'register_bloc.dart';

enum RegisterStatus { unknown, authenticated, unauthenticated, loading, loaded, error }
class RegisterState extends Equatable {

  const RegisterState({this.registerStatus});
  final RegisterStatus registerStatus;

  @override
  // TODO: implement props
  List<Object> get props => [registerStatus];
}



class RegisterAuthenticatedState extends RegisterState {
  final RegisterModel registerModel;

  const RegisterAuthenticatedState({this.registerModel})
      : super(registerStatus: RegisterStatus.authenticated);

  @override
  // TODO: implement props
  List<Object> get props => [registerModel];
}

class EngineeringDataState extends RegisterState {
  final EngineerData engineerData;

  const EngineeringDataState({this.engineerData})
      : super(registerStatus: RegisterStatus.authenticated);

  @override
  // TODO: implement props
  List<Object> get props => [engineerData];
}

class BankDataDownloadedState extends RegisterState {
  final BankDataModel bankDataModel;
  const BankDataDownloadedState({this.bankDataModel}): super(registerStatus: RegisterStatus.authenticated);

  @override
  // TODO: implement props
  List<Object> get props => [bankDataModel];
}

class BankDataChangeState extends RegisterState {
  final BankData bankData;
  const BankDataChangeState({this.bankData}): super();

  @override
  // TODO: implement props
  List<Object> get props => [bankData];
}

class RegisterError extends RegisterState {
  final DioError error;

  const RegisterError({this.error})
      : super(registerStatus: RegisterStatus.error);

  @override
  // TODO: implement props
  List<Object> get props => [error];
}

class RegisterUnauthenticatedState extends RegisterState {
  const RegisterUnauthenticatedState()
      : super(registerStatus: RegisterStatus.unauthenticated);

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class UnknownState extends RegisterState {
  const UnknownState() : super(registerStatus: RegisterStatus.unknown);

  @override
  List<Object> get props => [];
}

class LoadingState extends RegisterState {
  const LoadingState() : super(registerStatus: RegisterStatus.loading);

  @override
  List<Object> get props => [];
}

class StartState extends RegisterState {
  const StartState() : super();

  @override
  List<Object> get props => [];
}
class EndState extends RegisterState {
  const EndState() : super();

  @override
  List<Object> get props => [];
}