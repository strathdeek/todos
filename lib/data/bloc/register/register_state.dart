part of 'register_bloc.dart';

class RegisterState extends Equatable {
  final String email;
  final String password;
  final String confirmPassword;
  final String emailError;
  final String passwordError;
  final String confirmPasswordError;
  bool get hasError => (emailError.isNotEmpty ||
      passwordError.isNotEmpty ||
      confirmPasswordError.isNotEmpty);

  RegisterState(
      {required this.emailError,
      required this.passwordError,
      required this.confirmPasswordError,
      required this.email,
      required this.password,
      required this.confirmPassword});

  RegisterState copyWith(
      {String? email,
      String? password,
      String? confirmPassword,
      String? emailError,
      String? passwordError,
      String? confirmPasswordError}) {
    return RegisterState(
        emailError: emailError ?? this.emailError,
        passwordError: passwordError ?? this.passwordError,
        confirmPasswordError: confirmPasswordError ?? this.confirmPasswordError,
        email: email ?? this.email,
        password: password ?? this.password,
        confirmPassword: confirmPassword ?? this.confirmPassword);
  }

  @override
  List<Object> get props => [
        email,
        password,
        confirmPassword,
        emailError,
        passwordError,
        confirmPasswordError,
        hasError,
      ];
}
