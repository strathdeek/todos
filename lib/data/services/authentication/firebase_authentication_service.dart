import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:todos/data/exceptions/index.dart';

import 'index.dart';

class FirebaseAuthenticationService extends AuthenticationService {
  final _authorizationController = StreamController<AuthenticationStatus>()
    ..add(AuthenticationStatus.unknown);

  late StreamSubscription authSubscription;
  late StreamSubscription tokenSubscription;

  String token = '';

  FirebaseAuthenticationService() {
    authSubscription = FirebaseAuth.instance.authStateChanges().listen((user) {
      var status = (user != null)
          ? AuthenticationStatus.authenticated
          : AuthenticationStatus.unauthenticated;
      _authorizationController.add(status);
    });

    tokenSubscription =
        FirebaseAuth.instance.idTokenChanges().listen((newToken) async {
      token = await newToken?.getIdToken() ?? '';
    });
  }

  @override
  Stream<AuthenticationStatus> get status async* {
    yield* _authorizationController.stream;
  }

  @override
  Future<void> createAccount(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      _authorizationController.add(AuthenticationStatus.authenticated);
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
    return token;
  }

  @override
  Future<void> login(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      _authorizationController.add(AuthenticationStatus.authenticated);
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

  @override
  String getUserId() {
    return FirebaseAuth.instance.currentUser?.uid ?? '';
  }

  @override
  String getUserEmail() {
    return FirebaseAuth.instance.currentUser?.email ?? '';
  }

  @override
  void dispose() {
    authSubscription.cancel();
    tokenSubscription.cancel();
  }
}
