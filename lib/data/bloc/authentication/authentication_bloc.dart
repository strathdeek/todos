import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todos/data/exceptions/index.dart';
import 'package:todos/data/services/authentication/index.dart';
import 'package:todos/data/services/service_locater.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationUninitialized()) {
    _authenticationStatusSubscription = authenticationService.status
        .listen((status) => add(AuthenticationStatusChanged(status)));
  }
  late StreamSubscription<AuthenticationStatus>
      _authenticationStatusSubscription;

  AuthenticationService get authenticationService =>
      getIt<AuthenticationService>();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AuthenticationStatusChanged) {
      if (event.status == AuthenticationStatus.authenticated) {
        add(LoggedIn());
      } else if (event.status == AuthenticationStatus.unauthenticated) {
        yield AuthenticationUnauthenticated('Authentication Failed');
      } else {
        yield AuthenticationUninitialized();
      }
    }

    if (event is AppStarted) {
      yield state;
    }

    if (event is LoggedIn) {
      try {
        var token = await authenticationService.getToken();
        var id = authenticationService.getUserId();
        var email = authenticationService.getUserEmail();
        yield AuthenticationAuthenticated(token, id, email);
      } on AuthenticationException catch (e) {
        yield AuthenticationUnauthenticated(e.message);
      }
    }

    if (event is LoggedOut) {
      await authenticationService.logout();
      yield AuthenticationUnauthenticated('');
    }
  }

  @override
  Future<void> close() {
    _authenticationStatusSubscription.cancel();
    return super.close();
  }
}
