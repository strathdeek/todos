part of 'login_bloc.dart';

class LoginState extends Equatable {
  final String email;
  final String password;
  final String emailError;
  final String passwordError;
  final String apiError;

  bool get hasError => emailError.isNotEmpty || passwordError.isNotEmpty;
  LoginState(
      {required this.email,
      required this.password,
      required this.emailError,
      required this.passwordError,
      required this.apiError});

  LoginState copyWith(
      {String? email,
      String? password,
      String? emailError,
      String? passwordError,
      String? apiError}) {
    return LoginState(
        email: email ?? this.email,
        password: password ?? this.password,
        emailError: emailError ?? this.emailError,
        passwordError: passwordError ?? this.passwordError,
        apiError: apiError ?? this.apiError);
  }

  @override
  List<Object> get props =>
      [email, password, emailError, passwordError, apiError];
}
