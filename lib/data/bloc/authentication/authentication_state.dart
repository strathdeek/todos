part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationUninitialized extends AuthenticationState {}

class AuthenticationAuthenticated extends AuthenticationState {
  final String token;
  final User user;

  AuthenticationAuthenticated(this.token, this.user);
  @override
  List<Object> get props => [token, user];
}

class AuthenticationUnauthenticated extends AuthenticationState {
  final String error;

  AuthenticationUnauthenticated(this.error);

  @override
  List<Object> get props => [error];
}

class AuthenticationLoading extends AuthenticationState {}
