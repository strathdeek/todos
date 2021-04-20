import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todos/data/exceptions/index.dart';
import 'package:todos/data/repositories/user/user_repository.dart';
import 'package:todos/data/services/authentication/index.dart';
import 'package:todos/data/services/service_locater.dart';
import 'package:todos/utils/authentication.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc()
      : super(LoginState(
            apiError: '',
            email: '',
            emailError: '',
            password: '',
            passwordError: ''));

  AuthenticationService get authenticationService =>
      getIt<AuthenticationService>();

  UserRepository get userRepository => getIt<UserRepository>();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginSubmitted) {
      yield* _mapLoginSubmittedToState();
    } else if (event is LoginEmailChanged) {
      yield* _mapLoginEmailChangedToState(event);
    } else if (event is LoginPasswordChanged) {
      yield* _mapLoginPasswordChangedToState(event);
    }
  }

  Stream<LoginState> _mapLoginSubmittedToState() async* {
    try {
      var emailError =
          isValidEmailAddress(state.email) ? '' : 'Not a valid Email Address';
      var passwordError = isValidPassword(state.password)
          ? ''
          : 'Password must be at least 6 characters';
      var newState =
          state.copyWith(emailError: emailError, passwordError: passwordError);
      if (newState.hasError) {
        yield newState;
      } else {
        await authenticationService.login(state.email, state.password);
      }
    } on AuthenticationException catch (e) {
      yield state.copyWith(
          apiError: e.message, emailError: '', passwordError: '');
    }
  }

  Stream<LoginState> _mapLoginEmailChangedToState(
      LoginEmailChanged event) async* {
    yield state.copyWith(email: event.email);
  }

  Stream<LoginState> _mapLoginPasswordChangedToState(
      LoginPasswordChanged event) async* {
    yield state.copyWith(password: event.password);
  }
}
