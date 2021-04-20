import 'dart:async';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

abstract class AuthenticationService {
  Stream<AuthenticationStatus> get status;
  Future<String> getToken();
  Future<void> createAccount(String email, String password);
  Future<void> login(String email, String password);
  Future<void> logout();
  String getUserId();
  String getUserEmail();
  void dispose();
}
