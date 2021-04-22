import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos/data/bloc/authentication/authentication_bloc.dart';
import 'package:todos/data/bloc/bloc_observer.dart';
import 'package:todos/data/bloc/register/register_bloc.dart';
import 'package:todos/data/bloc/todo/todo_bloc.dart';
import 'package:todos/data/providers/todo_provider.dart';
import 'package:todos/data/repositories/todo_repository.dart';
import 'package:todos/pages/index.dart';
import 'package:todos/pages/routes/router.dart';

import 'data/bloc/login/login_bloc.dart';
import 'data/repositories/hive_setup.dart';
import 'data/services/service_locater.dart';
import 'pages/index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseAuth.instance.useEmulator('http://localhost:9099');
  await initializeHiveDatabase();
  Bloc.observer = SimpleBlocObserver();
  var _todoProvider = TodoProvider();
  var _todoRepository = TodoRepository(_todoProvider);

  setupServiceLocater();

  runApp(MultiBlocProvider(providers: [
    BlocProvider<AuthenticationBloc>(
      create: (context) => AuthenticationBloc()..add(AppStarted()),
    ),
    BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(),
    ),
    BlocProvider<RegisterBloc>(
      create: (context) => RegisterBloc(),
    ),
    BlocProvider<TodoBloc>(
        create: (context) => TodoBloc(todoRepository: _todoRepository)
          ..add(TodoLoadedSuccess())),
  ], child: TodoApp()));
}

class TodoApp extends StatelessWidget {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(primary: Colors.grey.shade600)),
        primaryColor: Color.fromARGB(255, 254, 203, 52),
        textTheme: Typography.blackCupertino,
        appBarTheme: AppBarTheme(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent),
      ),
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state is AuthenticationAuthenticated) {
              _navigator.pushNamedAndRemoveUntil('/', (route) => false);
            } else if (state is AuthenticationUnauthenticated) {
              _navigator.pushNamedAndRemoveUntil<void>(
                '/login',
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
      onGenerateRoute: onGenerateRoute,
    );
  }
}
