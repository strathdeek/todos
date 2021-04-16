import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todos/services/authentication/index.dart';
import 'package:todos/services/service_locater.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationUninitialized());

  AuthenticationService get authenticationService =>
      getIt<AuthenticationService>();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      final hasToken = await authenticationService.isAuthenticated();

      if (hasToken) {
        yield AuthenticationAuthenticated(
            await authenticationService.getToken());
      } else {
        yield AuthenticationUnauthenticated();
      }
    }

    if (event is LoggedIn) {
      yield AuthenticationLoading();
      yield AuthenticationAuthenticated(await authenticationService.getToken());
    }

    if (event is LoggedOut) {
      yield AuthenticationLoading();
      await authenticationService.logout();
      yield AuthenticationUnauthenticated();
    }
  }
}
