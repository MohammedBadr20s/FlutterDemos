import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:mostadam_flutter_app/src/components/SharedPreference.dart';
import 'package:mostadam_flutter_app/src/components/ValidationMixin.dart';
import 'package:mostadam_flutter_app/src/modules/Authentication/model/forget_password_model.dart';
import 'package:mostadam_flutter_app/src/modules/Authentication/model/loginValidations.dart';
import 'package:mostadam_flutter_app/src/modules/Authentication/model/login_model.dart';
import 'package:mostadam_flutter_app/src/modules/Authentication/repo/AuthenticationRepo.dart';

part 'login_state.dart';
part 'login_event.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> with ValidationMixin {
  final Repository repository;
  LoginBloc({@required Repository repository}): assert(repository != null), repository = repository, super(const UnknownState());
  Stream<LoginState> postLoginReq({
    LoginRequestEvent event,
    LoginState state,
  }) async* {
    try {
      yield LoadingState();
      LoginModel loginModel = await repository.postLogin(passwordType: event.passwordType, userName: state.username.value, password: state.password.value);
      yield LoginAuthenticated(loginModel: loginModel);
    } catch (error) {
      final res = (error as DioError);
      yield LoginError(error: res);
    }
  }

  Stream<LoginState> postForgetPassword({
    ForgetPasswordChanged event,
    LoginState state
  }) async* {
    try {
      yield LoadingState();
      ForgetPasswordModel forgetPasswordModel = await repository.postForgetPassword(email: state.email.value);
      yield ForgetPasswordChangedState(forgetPasswordModel: forgetPasswordModel);
    } catch (error) {
      final res = (error as DioError);
      yield LoginError(error: res);
    }

  }
  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is UserNameChanged) {
      yield _mapUsernameChangedToState(event, state);
    } else if (event is PasswordChanged) {
      yield _mapPasswordChangedToState(event, state);
    } else if (event is EmailChanged) {
      yield _mapEmailChangedToState(event, state);
  } else if (event is LoginRequestEvent){
      yield* postLoginReq(event: event, state: state);
    }else if (event is LoginUserChanged) {
      yield _mapLoginUserChangedState(event);
    } else if ( event is ForgetPasswordChanged) {
      yield* postForgetPassword(event: event, state: state);
    } else if ( event is LogoutRequested) {
      final sharedPrefs = await SharedPreferencesService.instance;
      sharedPrefs.setToken(Token: "");
    }
  }

  LoginState _mapUsernameChangedToState(
      UserNameChanged event,
      LoginState state
      ) {
    final username = Username.dirty(event.username);
    return state.copyWith(
      username: username,
      status: Formz.validate([state.password, username])
    );
  }

  LoginState _mapPasswordChangedToState(
      PasswordChanged event,
      LoginState state
      ) {
    final password = Password.dirty(event.password);
        return state.copyWith(
          password: password,
          status: Formz.validate([password, state.username])
        );
  }
  LoginState _mapEmailChangedToState(
      EmailChanged event,
      LoginState state
      ) {
    final email = Email.dirty(event.email);
    return state.copyWith(
        email: email,
        status: Formz.validate([email])
    );
  }


  LoginState _mapLoginUserChangedState(LoginUserChanged event) {
    return LoginAuthenticated(loginModel: event.loginModel);
  }

}
