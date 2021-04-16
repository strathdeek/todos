import 'package:firebase_auth/firebase_auth.dart';
import 'package:todos/errors/authentication_error.dart';
import 'package:todos/services/authentication/authentication_service.dart';

class FirebaseAuthenticationService extends AuthenticationService {
  @override
  Future<bool> createAccount(String email, String password) async {
    try {
      var userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential != null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  @override
  Future<String> getToken() async {
    var token = await FirebaseAuth.instance.currentUser?.getIdToken();
    if (token == null) {
      throw AuthenticationException('User authentication expired');
    }
    return token;
  }

  @override
  Future<bool> isAuthenticated() async {
    return FirebaseAuth.instance.currentUser != null;
  }

  @override
  Future<bool> login(String email, String Password) async {
    try {
      var userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: 'barry.allen@example.com',
              password: 'SuperSecretPassword!');
      return userCredential != null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw AuthenticationException('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw AuthenticationException('Wrong password provided for that user.');
      }
    }
    return false;
  }

  @override
  Future<void> logout() {
    return FirebaseAuth.instance.signOut();
  }
}
