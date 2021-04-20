part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginButtonPressed extends LoginEvent {
  final String email;
  final String password;

  LoginButtonPressed(this.email, this.password);

  @override
  List<Object> get props => [email, password];

  @override
  String toString() =>
      'LoginEvent: LoginButtonPressed: {email: $email, password: $password';
}

class RegisterButtonPressed extends LoginEvent {
  final String email;
  final String password;

  RegisterButtonPressed(this.email, this.password);

  @override
  List<Object> get props => [email, password];

  @override
  String toString() =>
      'LoginEvent: RegisterButtonPressed: {email: $email, password: $password';
}
