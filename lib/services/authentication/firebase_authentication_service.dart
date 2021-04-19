import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:todos/errors/authentication_error.dart';
import 'package:todos/services/authentication/authentication_service.dart';

class FirebaseAuthenticationService extends AuthenticationService {
  final _controller = StreamController<AuthenticationStatus>()
    ..add(AuthenticationStatus.unknown);

  FirebaseAuthenticationService() {
    initializeAuthenticationStatus();
  }

  Future<void> initializeAuthenticationStatus() async {
    var status = (await isAuthenticated())
        ? AuthenticationStatus.authenticated
        : AuthenticationStatus.unauthenticated;
    _controller.add(status);
  }

  @override
  Stream<AuthenticationStatus> get status async* {
    yield* _controller.stream;
  }

  @override
  Future<void> createAccount(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      _controller.add(AuthenticationStatus.authenticated);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<String> getToken() async {
    try {
      var token = await FirebaseAuth.instance.currentUser?.getIdToken();
      return token ?? '';
    } catch (_) {
      throw AuthenticationException('User auth expired');
    }
  }

  @override
  Future<bool> isAuthenticated() async {
    try {
      var authenticated = FirebaseAuth.instance.currentUser != null;
      return authenticated;
    } on FirebaseAuthException catch (_) {
      throw AuthenticationException('User auth expired');
    }
  }

  @override
  Future<void> login(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      _controller.add(AuthenticationStatus.authenticated);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw AuthenticationException('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw AuthenticationException('Wrong password provided for that user.');
      }
    }
  }

  @override
  Future<void> logout() {
    return FirebaseAuth.instance.signOut();
  }
}
