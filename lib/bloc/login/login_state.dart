part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginFail extends LoginState {
  final String error;

  LoginFail(this.error);
  @override
  List<Object> get props => [error];
}

class LoginLoading extends LoginState {}
