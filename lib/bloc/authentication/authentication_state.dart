part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationUninitialized extends AuthenticationState {}

class AuthenticationAuthenticated extends AuthenticationState {
  final String token;

  AuthenticationAuthenticated(this.token);
  @override
  List<Object> get props => [token];
}

class AuthenticationUnauthenticated extends AuthenticationState {
  final String error;

  AuthenticationUnauthenticated(this.error);

  @override
  List<Object> get props => [error];
}

class AuthenticationLoading extends AuthenticationState {}
