import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos/bloc/authentication/authentication_bloc.dart';
import 'package:todos/bloc/login/login_bloc.dart';
import 'package:todos/pages/dashboard_page.dart';
import 'package:todos/pages/index.dart';
import 'package:todos/services/service_locater.dart';

import 'pages/index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseAuth.instance.useEmulator('http://localhost:9099');
  setupServiceLocater();
  runApp(MultiBlocProvider(providers: [
    BlocProvider<AuthenticationBloc>(
      create: (context) => AuthenticationBloc()..add(AppStarted()),
    ),
    BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(),
    ),
  ], child: TodoApp()));
}

class TodoApp extends StatelessWidget {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          appBarTheme: AppBarTheme(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent)),
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state is AuthenticationAuthenticated) {
              _navigator.pushAndRemoveUntil<void>(
                DashboardPage.route(),
                (route) => false,
              );
            } else if (state is AuthenticationUnauthenticated) {
              _navigator.pushAndRemoveUntil<void>(
                LoginPage.route(),
                (route) => false,
              );
            } else {
              _navigator.pushAndRemoveUntil(
                  SplashPage.route(), (route) => false);
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (_) => SplashPage.route(),
    );
  }
}
