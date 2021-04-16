import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todos/errors/authentication_error.dart';
import 'package:todos/services/authentication/index.dart';
import 'package:todos/services/service_locater.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial());

  AuthenticationService get authenticationService =>
      getIt<AuthenticationService>();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();
      try {
        await authenticationService.login(event.email, event.password);
        yield (LoginSuccess());
      } on AuthenticationException catch (e) {
        yield LoginFail(e.message);
      }
    }
  }
}
