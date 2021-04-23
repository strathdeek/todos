part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationUninitialized extends AuthenticationState {}

class AuthenticationAuthenticated extends AuthenticationState {
  final String token;
  final String userId;
  final String email;
  AuthenticationAuthenticated(this.token, this.userId, this.email);
  @override
  List<Object> get props => [token, userId];
}

class AuthenticationUnauthenticated extends AuthenticationState {
  final String error;

  AuthenticationUnauthenticated(this.error);

  @override
  List<Object> get props => [error];
}
