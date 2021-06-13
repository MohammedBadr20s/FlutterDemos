part of 'login_bloc.dart';

enum LoginStatus { unknown, authenticated, unauthenticated, error, loading, success}

class LoginState extends Equatable {
  const LoginState({
    this.loginStatus,
    this.status = FormzStatus.pure,
    this.username = const Username.pure(),
    this.password = const Password.pure(),
    this.email = const Email.pure()
  });

  final LoginStatus loginStatus;
  final FormzStatus status;
  final Username username;
  final Password password;
  final Email email;
  LoginState copyWith({
    FormzStatus status,
    Username username,
    Password password,
    Email email,
  }) {
    return LoginState(
      status: status ?? this.status,
      username: username ?? this.username,
      password: password ?? this.password,
      email: email ?? this.email
    );
  }

  @override
  List<Object> get props => [loginStatus,status, username, password];
}

class LoginAuthenticated extends LoginState {
  final LoginModel loginModel;
  const LoginAuthenticated({this.loginModel}): super(loginStatus: LoginStatus.authenticated);

  @override
  List<Object> get props => [loginModel];
}

class LoginUnauthenticated extends LoginState {
  const LoginUnauthenticated(): super(loginStatus: LoginStatus.unauthenticated);

  @override
  List<Object> get props => [];
}
class LoginError extends LoginState {
  final DioError error;
  const LoginError({this.error}): super(loginStatus: LoginStatus.error);

  @override
  List<Object> get props => [error];
}

class ForgetPasswordChangedState extends LoginState {
  final ForgetPasswordModel forgetPasswordModel;
  const ForgetPasswordChangedState({this.forgetPasswordModel}): super(loginStatus: LoginStatus.success);

  @override
  List<Object> get props => [forgetPasswordModel];
}
class UnknownState extends LoginState {
  const UnknownState(): super(loginStatus: LoginStatus.unknown);

  @override
  List<Object> get props => [];
}

class LoadingState extends LoginState {
  const LoadingState(): super(loginStatus: LoginStatus.loading);

  @override
  List<Object> get props => [];
}