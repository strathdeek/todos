part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthenticationEvent {
  @override
  String toString() {
    return 'AppStarted';
  }
}

class AuthenticationStatusChanged extends AuthenticationEvent {
  final AuthenticationStatus status;
  AuthenticationStatusChanged(this.status);
  @override
  String toString() => 'AuthenticationStatusChanged';

  @override
  List<Object> get props => [status];
}

class LoggedIn extends AuthenticationEvent {
  @override
  String toString() => 'LoggedIn';
}

class LoggedOut extends AuthenticationEvent {
  @override
  String toString() {
    return 'LoggedOut';
  }
}
