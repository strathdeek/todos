import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todos/errors/authentication_error.dart';
import 'package:todos/services/authentication/index.dart';
import 'package:todos/services/service_locater.dart';

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
    if (event is AppStarted) {
      try {
        final hasToken = await authenticationService.isAuthenticated();

        if (hasToken) {
          yield AuthenticationAuthenticated(
              await authenticationService.getToken());
        } else {
          yield AuthenticationUnauthenticated('');
        }
      } on AuthenticationException catch (e) {
        yield AuthenticationUnauthenticated(e.message);
      }
    }

    if (event is AuthenticationStatusChanged) {
      if (event.status == AuthenticationStatus.authenticated) {
        add(LoggedIn());
      } else if (event.status == AuthenticationStatus.unauthenticated) {
        yield AuthenticationUnauthenticated('');
      } else {
        yield AuthenticationUninitialized();
      }
    }

    if (event is LoggedIn) {
      yield AuthenticationLoading();
      try {
        var token = await authenticationService.getToken();
        yield AuthenticationAuthenticated(token);
      } on AuthenticationException catch (e) {
        yield AuthenticationUnauthenticated(e.message);
      }
    }

    if (event is LoggedOut) {
      yield AuthenticationLoading();
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
