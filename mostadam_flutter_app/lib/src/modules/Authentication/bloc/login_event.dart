part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}
class UserNameChanged extends LoginEvent {
  const UserNameChanged({this.username});

  final String username;

  @override
  List<Object> get props => [username];
}
class PasswordChanged extends LoginEvent {
  const PasswordChanged({this.password});

  final String password;

  @override
  List<Object> get props => [password];
}
class LoginUserChanged extends LoginEvent {
  const LoginUserChanged({this.loginModel});

  final LoginModel loginModel;

  @override
  List<Object> get props => [loginModel];
}

class LoginRequestEvent extends LoginEvent {
  const LoginRequestEvent({ this.passwordType = "password"});
  final String passwordType;

  @override
  // TODO: implement props
  List<Object> get props => [passwordType];
}

class LogoutRequested extends LoginEvent {}

class EmailChanged extends LoginEvent {
  const EmailChanged({this.email});

  final String email;

  @override
  List<Object> get props => [email];
}

class ForgetPasswordChanged extends LoginEvent {
  const ForgetPasswordChanged();

  @override
  List<Object> get props => [];
}