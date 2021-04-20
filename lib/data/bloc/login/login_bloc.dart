import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todos/data/exceptions/index.dart';
import 'package:todos/data/models/index.dart';
import 'package:todos/data/repositories/user/user_repository.dart';
import 'package:todos/data/services/authentication/index.dart';
import 'package:todos/data/services/service_locater.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial());

  AuthenticationService get authenticationService =>
      getIt<AuthenticationService>();

  UserRepository get userRepository => getIt<UserRepository>();

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
    } else if (event is RegisterButtonPressed) {
      try {
        await authenticationService.createAccount(event.email, event.password);
        await userRepository.addUser(
            User('kevin', event.email, authenticationService.getUserId()));
      } on AuthenticationException catch (e) {
        yield LoginFail(e.message);
      }
    }
  }
}
