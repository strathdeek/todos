import 'dart:async';

abstract class AuthenticationService {
  Future<bool> isAuthenticated();
  Future<String> getToken();
  Future<bool> createAccount(String email, String password);
  Future<bool> login(String email, String Password);
  Future<void> logout();
}
