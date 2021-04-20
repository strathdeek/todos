import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todos/data/services/authentication/index.dart';
import 'package:todos/data/services/service_locater.dart';
import 'package:todos/utils/authentication.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc()
      : super(RegisterState(
          email: '',
          password: '',
          confirmPassword: '',
          confirmPasswordError: '',
          emailError: '',
          passwordError: '',
        ));

  AuthenticationService get _authenticationService =>
      getIt<AuthenticationService>();

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if (event is RegisterEmailChanged) {
      yield* _mapRegisterEmailChangedToState(event);
    } else if (event is RegisterPasswordChanged) {
      yield* _mapRegisterPasswordChangedToState(event);
    } else if (event is RegisterConfirmPasswordChanged) {
      yield* _mapRegisterConfirmPasswordChangedToState(event);
    } else if (event is RegisterSubmitted) {
      yield* _mapRegisterSubmittedToState(event);
    }
  }

  Stream<RegisterState> _mapRegisterEmailChangedToState(
      RegisterEmailChanged event) async* {
    yield state.copyWith(email: event.email);
  }

  Stream<RegisterState> _mapRegisterPasswordChangedToState(
      RegisterPasswordChanged event) async* {
    yield state.copyWith(password: event.password);
  }

  Stream<RegisterState> _mapRegisterConfirmPasswordChangedToState(
      RegisterConfirmPasswordChanged event) async* {
    yield state.copyWith(confirmPassword: event.confirmPassword);
  }

  Stream<RegisterState> _mapRegisterSubmittedToState(
      RegisterSubmitted event) async* {
    var emailError =
        isValidEmailAddress(state.email) ? '' : 'Not a valid Email Address';
    var passwordError = isValidPassword(state.password)
        ? ''
        : 'Password must be at least 6 characters';
    var confirmPasswordError =
        state.password == state.confirmPassword ? '' : 'Passwords do not match';

    var newState = state.copyWith(
        emailError: emailError,
        passwordError: passwordError,
        confirmPasswordError: confirmPasswordError);

    if (newState.hasError) {
      yield newState;
    } else {
      await _authenticationService.createAccount(state.email, state.password);
    }
  }
}
